import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/users/cubit/user_cubit.dart';
import 'package:rollshop/features/users/cubit/user_state.dart';

class ProfileScreen extends StatefulWidget {
  // final UserModel user;
  ProfileScreen({
    super.key,
    // required this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final picker = ImagePicker();

  File? imagePath;
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthCubit>().currentUser;
    return ConditionalBuilder(
      condition: currentUser != null,
      fallback: (context) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Column(
                spacing: 20.r,
                children: [
                  TranslatedTextWidget(
                    arabicText: "برجاء تسجيل الدخول لرؤية ملفك الشخصي",
                    englishText: "Please sign in to see your profile",
                  ),
                  CustomButton(
                    buttonName: translatedText(
                      context: context,
                      arabicText: "تسجيل دخول",
                      englishText: "Sign in",
                    ),
                    onPressed: () {
                      context.pushReplacementNamed(Routes.loginScreen);
                    },
                    color: ColorsManager.orangeColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      builder: (context) {
        return BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserUpdatedSuccessState) {
              showCustomSnackBar(
                context: context,
                message: translatedText(
                  context: context,
                  arabicText: "تم حفظ التغيرات بنجاح",
                  englishText: "Changes Save",
                ),
                color: ColorsManager.mainTeal,
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              // appBar: AppBar(
              //   backgroundColor: Colors.transparent,
              //   elevation: 0,
              // ),
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.adaptive.arrow_back,
                      size: 30.r,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              imagePath = null;
                              isEdit = !isEdit;
                            });
                          },
                          child: Icon(
                            isEdit ? Icons.clear : Icons.edit,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                // elevation: 0,
                backgroundColor:
                    context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                        ? ColorsManager.darkColor
                        : ColorsManager.whiteColor,
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: SizedBox(
                    width: context.width,
                    child: Column(
                      spacing: 20.r,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ConditionalBuilder(
                        //   condition: !currentUser!.isEmailVerified!,
                        //   fallback: (context) => SizedBox(),
                        //   builder: (context) => SizedBox(
                        //     width: context.width,
                        //     child: SafeArea(
                        //       child: DecoratedBox(
                        //         decoration: BoxDecoration(
                        //           color: Colors.amber,
                        //         ),
                        //         child: Padding(
                        //           padding: EdgeInsets.symmetric(
                        //               horizontal: 20.w, vertical: 10.h),
                        //           child: Row(
                        //             spacing: 20.w,
                        //             children: [
                        //               Expanded(
                        //                 child: Row(
                        //                   spacing: 20.w,
                        //                   children: [
                        //                     Icon(Icons.info),
                        //                     Text(
                        //                       translatedText(
                        //                         context: context,
                        //                         arabicText:
                        //                             "برجاء تفعيل بريدك الالكتروني",
                        //                         englishText:
                        //                             "Please verify your email",
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               TextButton(
                        //                 onPressed: () async {
                        //                   debugPrint("Verify pressed");
                        //                 },
                        //                 style: ButtonStyle(
                        //                   backgroundColor: WidgetStatePropertyAll(
                        //                       ColorsManager.lightBlue),
                        //                 ),
                        //                 child: Text(
                        //                   translatedText(
                        //                     context: context,
                        //                     arabicText: "تفعيل",
                        //                     englishText: "Verify",
                        //                   ),
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // currentUser != null
                        //     ? Text(
                        //         context.read<AuthCubit>().currentUser!.name,
                        //       )
                        //     : Text("User not signed in"),
                        // currentUser!.imagePath != null
                        //     ?
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10.r),
                        //   child: SizedBox(
                        //     width: context.width,
                        //     height: context.height / 3,
                        //     child: DecoratedBox(
                        //       decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //           image: CachedNetworkImageProvider(
                        //             currentUser!.imagePath ??
                        //                 "https://i.imgur.com/kldXnVq.jpeg",
                        //           ),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // : SizedBox(
                        //     child: GestureDetector(
                        //       onTap: () {},
                        //       child: Icon(Icons.upload),
                        //     ),
                        //   ),

                        Align(
                          // alignment: AlignmentDirectional.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 100.r,
                                backgroundImage: (isEdit == false &&
                                        currentUser!.imagePath != null)
                                    ? CachedNetworkImageProvider(
                                        currentUser.imagePath!)
                                    : imagePath != null
                                        ? FileImage(imagePath!)
                                        : null,
                              ),
                              isEdit
                                  ? PositionedDirectional(
                                      bottom: 0,
                                      start: 15.w,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorsManager.orangeColor,
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            final path = await picker.pickImage(
                                                source: ImageSource.gallery);
                                            if (path != null) {
                                              setState(() {
                                                imagePath = File(path.path);
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10.r),
                                            child: Icon(
                                              Icons.edit,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        // : GestureDetector(
                        //     onTap: () async {
                        //       final path = await picker.pickImage(
                        //         source: ImageSource.gallery,
                        //       );
                        //       if (path != null) {
                        //         setState(() {
                        //           imagePath = File(path.path);
                        //         });
                        //       }
                        //     },
                        //     child: CircleAvatar(
                        //       backgroundImage: FileImage(imagePath!),
                        //       radius: 100.r,
                        //     ),
                        //   ),

                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 20.r,
                            end: 20.r,
                            bottom: 20.r,
                          ),
                          child: Column(
                            spacing: 20.h,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // currentUser!.imagePath != null
                              //     ? Align(
                              //         alignment: AlignmentDirectional.center,
                              //         child: CircleAvatar(
                              //           radius: 75.r,
                              //           backgroundImage: CachedNetworkImageProvider(
                              //             currentUser.imagePath!,
                              //           ),
                              //         ),
                              //       )
                              //     : Align(
                              //         alignment: AlignmentDirectional.center,
                              //         child: CircleAvatar(
                              //           radius: 75.r,
                              //           child: Icon(
                              //             Icons.upload,
                              //             size: 50.r,
                              //           ),
                              //         ),
                              //       ),
                              BuildProfileInfo(
                                lable: Text(translatedText(
                                  context: context,
                                  arabicText: "الأسم",
                                  englishText: "Name",
                                )),
                                info: currentUser!.name,
                              ),
                              BuildProfileInfo(
                                lable: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translatedText(
                                        context: context,
                                        arabicText: "البريد الالكتروني",
                                        englishText: "Email Address",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: currentUser.isEmailVerified!
                                          ? null
                                          : () {
                                              debugPrint("Email not verified");
                                            },
                                      child: Text(
                                        currentUser.isPhoneVerified!
                                            ? translatedText(
                                                context: context,
                                                arabicText: "تم التفعيل",
                                                englishText: "Verified",
                                              )
                                            : translatedText(
                                                context: context,
                                                arabicText: "اضغط للتفعيل",
                                                englishText: "Tap to verify",
                                              ),
                                        style:
                                            MyTextStyles.font14OrangeOrRedBold(
                                                    Theme.of(context))
                                                .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                info: currentUser.email,
                              ),
                              BuildProfileInfo(
                                lable: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translatedText(
                                        context: context,
                                        arabicText: "رقم الموبايل",
                                        englishText: "Phone Number",
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: currentUser.isEmailVerified!
                                          ? null
                                          : () {
                                              debugPrint("Not verified phone");
                                            },
                                      child: Text(
                                        currentUser.isPhoneVerified!
                                            ? translatedText(
                                                context: context,
                                                arabicText: "تم التفعيل",
                                                englishText: "Verified",
                                              )
                                            : translatedText(
                                                context: context,
                                                arabicText: "اضغط للتفعيل",
                                                englishText: "Press to verify",
                                              ),
                                        style:
                                            MyTextStyles.font14OrangeOrRedBold(
                                                    Theme.of(context))
                                                .copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                info: currentUser.phoneNumber,
                              ),
                              // currentUser.isEmailVerified != null
                              //     ? BuildProfileInfo(
                              //         lable: translatedText(
                              //           context: context,
                              //           arabicText: "حالة البريد الالكتروني",
                              //           englishText: "Is email virefied?",
                              //         ),
                              //         info: currentUser.isEmailVerified! == true
                              //             ? translatedText(
                              //                 context: context,
                              //                 arabicText: "تم التفعيل",
                              //                 englishText: "Verified",
                              //               )
                              //             : translatedText(
                              //                 context: context,
                              //                 arabicText: "غير مفعل",
                              //                 englishText: "Not Verified",
                              //               ),
                              //       )
                              //     : SizedBox(),
                              // BuildProfileInfo(
                              //   lable: Text(
                              //     translatedText(
                              //       context: context,
                              //       arabicText: "رقم الموبايل",
                              //       englishText: "Phone Number",
                              //     ),
                              //   ),
                              //   info: currentUser.phoneNumber,
                              // ),
                              BuildProfileInfo(
                                lable: Text(translatedText(
                                  context: context,
                                  arabicText: "الوظيفة",
                                  englishText: "position",
                                )),
                                info: currentUser.userType,
                              ),
                              BuildProfileInfo(
                                lable: Text(translatedText(
                                  context: context,
                                  arabicText: "تاريخ التسجيل",
                                  englishText: "Date of registered",
                                )),
                                info: DateFormat('yyyy-MMMM-dd')
                                    .format(currentUser.createdAt!.toDate()),
                              ),
                            ],
                          ),
                        ),

                        isEdit
                            ? ConditionalBuilder(
                                condition: state is UserLoadingState,
                                builder: (context) => Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                                fallback: (context) => CustomButton(
                                  buttonName: "Save",
                                  onPressed: () async {
                                    await context.read<UserCubit>().setUser(
                                          user: currentUser,
                                          imagePath: imagePath,
                                        );
                                    await context
                                        .read<AuthCubit>()
                                        .refreshUser();
                                    setState(() {
                                      isEdit = false;
                                    });
                                  },
                                  color: ColorsManager.orangeColor,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class BuildProfileInfo extends StatelessWidget {
  const BuildProfileInfo({
    super.key,
    required this.lable,
    required this.info,
  });

  final Widget lable;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable,
        Text(
          info,
          style: MyTextStyles.font16Weight500(Theme.of(context)),
        ),
      ],
    );
  }
}
