import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';
import 'package:rollshop/features/auth/cubit/auth_state.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Center(
          child: SafeArea(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
