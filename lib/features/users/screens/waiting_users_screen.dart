import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/users/cubit/user_cubit.dart';
import 'package:rollshop/features/users/cubit/user_state.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class WaitingUsersScreen extends StatelessWidget {
  const WaitingUsersScreen({
    super.key,
    required this.waitingUsers,
  });
  final List<UserModel> waitingUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(repo: sl())..getWaitingUsersToApproved(),
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserInitialState) {
            // context.read<UserCubit>().getWaitingUsersToApproved();
          } else if (state is WaitingUsersLoadedSuccessState) {
            debugPrint("Waiting users loaded");
          }
        },
        builder: (context, state) {
          return ConditionalBuilder(
            condition: context.read<UserCubit>().waitingUsers.isNotEmpty,
            fallback: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            builder: (context) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Column(
                      spacing: 20.h,
                      children: [
                        Text(
                          "Wating users founded",
                        ),
                        SizedBox(
                          height: context.height * .7,
                          child: ListView.separated(
                            itemCount:
                                context.read<UserCubit>().waitingUsers.length,
                            separatorBuilder: (context, index) => Divider(),
                            itemBuilder: (context, index) => BuildWatingUser(
                              user:
                                  context.read<UserCubit>().waitingUsers[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildWatingUser extends StatelessWidget {
  const BuildWatingUser({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserInfo(
          lable: Text("Name:"),
          text: Text(user.name),
        ),
        UserInfo(
          lable: Text("Email:"),
          text: Text(user.email),
        ),
        UserInfo(
          lable: Text("Phone Number:"),
          text: Text(user.phoneNumber),
        ),
        UserInfo(
          lable: Text("Position:"),
          text: Text(user.userType),
        ),
        UserInfo(
          lable: Text("Created At:"),
          text: Text(
            DateFormat('dd-MMM-yyyy HH:mm a').format(user.createdAt!.toDate()),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: user.isApproved ? Colors.green : ColorsManager.redAccent,
          ),
          child: Text(
            user.isApproved ? "Approved" : "Not Approved",
          ),
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.lable,
    required this.text,
  });

  final Widget lable;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        lable,
        text,
      ],
    );
  }
}
