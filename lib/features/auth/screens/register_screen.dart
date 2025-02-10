import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/errors/failure.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/svgs_paths.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/auth/components/custom_email_text_form_field.dart';
import 'package:rollshop/features/auth/components/custom_password_text_form_field%20copy.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';
import 'package:rollshop/features/auth/cubit/auth_state.dart';
import 'package:rollshop/features/users/data/models/user_model.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  // bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UserRegisterSuccessState) {
          showCustomSnackBar(
            context: context,
            message: translatedText(
              context: context,
              arabicText:
                  "تم تسجيل المستخدم بنجاح، برجاء الانتظار حتي يتم السماح لك بالدخول",
              englishText:
                  "User successfully registered, please wait until allow you to be approved",
            ),
            color: ColorsManager.mainTeal,
          );
          context.pushReplacementNamed(Routes.loginScreen);
          // showCustomSnackBar(
          //   context: context,
          //   message: translatedText(
          //     context: context,
          //     arabicText: "تم تسجيل المستخدم بنجاح",
          //     englishText: "User successfully registered",
          //   ),
          //   color: ColorsManager.mainTeal,
          // );

          // context.pushReplacementNamed(Routes.mainScreenScreen);
        } else if (state is UserRegisterFailedState) {
          if (state.failure is PhoneNumberExistsFailure) {
            showCustomSnackBar(
              context: context,
              message: translatedText(
                context: context,
                arabicText: "رقم الموبايل مسجل من قبل",
                // englishText: "Error while register new user",
                englishText: state.failure.message,
              ),
              color: ColorsManager.redColor,
            );
          } else if (state.failure is EmailAlreadyExistsFailure) {
            showCustomSnackBar(
              context: context,
              message: translatedText(
                context: context,
                arabicText: "البريد الالكتروني مسجل من قبل",
                // englishText: "Error while register new user",
                englishText: state.failure.message,
              ),
              color: ColorsManager.redColor,
            );
          } else {
            showCustomSnackBar(
              context: context,
              message: translatedText(
                context: context,
                arabicText: "حدث خطأ اثناء تسجيل المستخدم",
                // englishText: "Error while register new user",
                englishText: state.failure.message,
              ),
              color: ColorsManager.redColor,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20.h,
                    children: [
                      // CircleAvatar(
                      //   radius: 100.r,
                      //   backgroundImage: CachedNetworkImageProvider(
                      //     "https://i.imgur.com/kldXnVq.jpeg",
                      //   ),
                      // ),
                      CircleAvatar(
                        radius: 100.r,
                        child: SvgPicture.asset(
                          SvgsPaths.loginSvgPath,
                          semanticsLabel: 'Login logo',
                        ),
                        // backgroundImage: CachedNetworkImageProvider(
                        //   "https://i.imgur.com/kldXnVq.jpeg",
                        // ),
                        // NetworkImage(
                        //   "https://i.imgur.com/kldXnVq.jpeg",
                        // ),
                        // child:
                        // BuildImageWithErrorHandler(
                        //   imageType: ImageType.network,
                        //   path: "",
                        // ),
                      ),
                      TranslatedTextWidget(
                        arabicText: "تسجيل مستخدم جديد",
                        englishText: "Register new user",
                        textStyle: MyTextStyles.font32Bold(Theme.of(context)),
                      ),
                      CustomTextFormField(
                        textFieldController: nameController,
                        inputAction: TextInputAction.next,
                        hintText: translatedText(
                          context: context,
                          arabicText: "الأسم",
                          englishText: "Name",
                        ),
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length > 2) {
                            return null;
                          } else {
                            return translatedText(
                              context: context,
                              arabicText: "برجاء ادخال الاسم",
                              englishText: "Please enter your name",
                            );
                          }
                        },
                      ),
                      CustomEmailFormField(
                        emailController: emailController,
                      ),
                      CustomTextFormField(
                        textFieldController: phoneController,
                        inputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        hintText: translatedText(
                          context: context,
                          arabicText: "الهاتف",
                          englishText: "Phone",
                        ),
                        validator: (value) {
                          if (phoneController.text.length != 11) {
                            return translatedText(
                              context: context,
                              arabicText: "رقم الهاتف غير صحيح",
                              englishText: "Please enter a valid phone number",
                            );
                          }
                          return null;
                        },
                      ),
                      CustomPasswordFormField(
                        passwordController: passwordController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "كلمة المرور",
                          englishText: "Password",
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 6) {
                              return translatedText(
                                context: context,
                                arabicText: "كلمة المرور اقل من ٦ حروف",
                                englishText:
                                    "Password must be 6 digits or hiegher",
                              );
                            }
                            if (value.toLowerCase() !=
                                confirmPasswordController.text.toLowerCase()) {
                              debugPrint(
                                  "password is: $value confirm is: ${confirmPasswordController.text}");
                              return translatedText(
                                context: context,
                                arabicText:
                                    "كلمة المرور  و تأكيد كلمة المرور غير متطابقان",
                                englishText:
                                    "Password and confirm password is not matched",
                              );
                            } else {
                              debugPrint(
                                  "password is: $value confirm is: ${confirmPasswordController.text}");
                              return null;
                            }
                          } else {
                            return translatedText(
                              context: context,
                              arabicText: "يجب ادخال كلمة المرور",
                              englishText: "Password is required",
                            );
                          }
                        },
                      ),
                      CustomPasswordFormField(
                        passwordController: confirmPasswordController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "تأكيد كلمة المرور",
                          englishText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 6) {
                              return translatedText(
                                context: context,
                                arabicText: "كلمة المرور اقل من ٦ حروف",
                                englishText:
                                    "Password must be 6 digits or hiegher",
                              );
                            }
                            if (value.toLowerCase() !=
                                passwordController.text.toLowerCase()) {
                              return translatedText(
                                context: context,
                                arabicText:
                                    "كلمة المرور  و تأكيد كلمة المرور غير متطابقان",
                                englishText:
                                    "Password and confirm password is not matched",
                              );
                            } else {
                              return null;
                            }
                          } else {
                            return translatedText(
                              context: context,
                              arabicText: "يجب ادخال تأكيد كلمة المرور",
                              englishText: "Confirm Password is required",
                            );
                          }
                        },
                      ),
                      // context.read<AuthCubit>().isSaving
                      state is UserRegisteringState
                          ? CircularProgressIndicator.adaptive()
                          : CustomButton(
                              buttonName: translatedText(
                                context: context,
                                arabicText: "انشاء حساب",
                                englishText: "Register",
                              ),
                              onPressed: () {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  if (passwordController.text.length < 6) {
                                    showCustomSnackBar(
                                      context: context,
                                      message: translatedText(
                                        context: context,
                                        arabicText:
                                            "يجب ان تكون كلمة المرور اكتر من ٦ احرف",
                                        englishText:
                                            "Password must be more than 6 digits",
                                      ),
                                      color: ColorsManager.redColor,
                                    );
                                    return;
                                  } else if (phoneController.text.length !=
                                      11) {
                                    showCustomSnackBar(
                                      context: context,
                                      message: translatedText(
                                        context: context,
                                        arabicText: "رقم الهاتف غير صحيح",
                                        englishText:
                                            "Please enter a valid phone number",
                                      ),
                                      color: ColorsManager.redColor,
                                    );
                                    return;
                                  }
                                }

                                // context
                                //     .read<AuthCubit>()
                                //     .isSavingProccess(true);
                                context
                                    .read<AuthCubit>()
                                    .registerByEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phoneNumber: phoneController.text,
                                      userType: UserType.technician.name,
                                    );
                                // context
                                //     .read<AuthCubit>()
                                //     .isSavingProccess(false);

                                // context
                                //     .read<UserCubit>()
                                //     .addWaitingUserToApprove(
                                //       user: WaitingUsersToApproveModel(
                                //         isApproved: false,
                                //         name: nameController.text,
                                //         email: emailController.text,
                                //         userType: UserType.technician.name,
                                //         phoneNumber: phoneController.text,
                                //         createdAt: DateTime.now().toString(),
                                //       ),
                                //     );
                              },
                              color:
                                  context.read<AppCubit>().currentThemeMode ==
                                          ThemeMode.dark
                                      ? ColorsManager.lightBlue
                                      : ColorsManager.orangeColor,
                            ),
                      Row(
                        spacing: 10.w,
                        children: [
                          TranslatedTextWidget(
                            arabicText: "هل لديك حساب؟",
                            englishText: "Already have an account?",
                          ),
                          GestureDetector(
                            onTap: () {
                              debugPrint("Register button");
                              context.pushReplacementNamed(Routes.loginScreen);
                            },
                            child: TranslatedTextWidget(
                              arabicText: "تسجيل دخول",
                              englishText: "Login",
                              textStyle:
                                  MyTextStyles.font16Bold(Theme.of(context))
                                      .copyWith(
                                color: ColorsManager.lightBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
