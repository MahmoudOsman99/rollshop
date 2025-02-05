import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/auth/signin/cubit/auth_cubit.dart';
import 'package:rollshop/features/auth/signin/cubit/auth_state.dart';
import 'package:rollshop/features/auth/signin/screens/login_screen.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
                    spacing: 20.h,
                    children: [
                      CircleAvatar(
                        radius: 100.r,
                        backgroundImage: CachedNetworkImageProvider(
                          "https://i.imgur.com/kldXnVq.jpeg",
                        ),
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
                      CustomEmailFormField(
                        emailController: userNameController,
                      ),
                      // CustomTextFormField(
                      //   textFieldController: userNameController,
                      //   inputAction: TextInputAction.next,
                      //   hintText: translatedText(
                      //     context: context,
                      //     arabicText: "البريد الاليكتروني",
                      //     englishText: "Email",
                      //   ),
                      // ),
                      CustomTextFormField(
                        textFieldController: phoneController,
                        inputAction: TextInputAction.next,
                        keyboardType: TextInputType.numberWithOptions(),
                        hintText: translatedText(
                          context: context,
                          arabicText: "الهاتف",
                          englishText: "Phone",
                        ),
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
                            if (value != confirmPasswordController.text) {
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
                            if (value != passwordController.text) {
                              return translatedText(
                                context: context,
                                arabicText:
                                    "كلمة المرور  و تأكيد كلمة المرور غير متطابقان",
                                englishText:
                                    "Password and confirm password is not matched",
                              );
                            } else {
                              return translatedText(
                                context: context,
                                arabicText:
                                    "كلمة المرور  و تأكيد كلمة المرور غير متطابقان",
                                englishText:
                                    "Password and confirm password is not matched",
                              );
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
                      // CustomTextFormField(
                      //   textFieldController: passwordController,
                      //   isPassword: true,
                      //   inputAction: TextInputAction.next,
                      //   hintText: translatedText(
                      //     context: context,
                      //     arabicText: "كلمة المرور",
                      //     englishText: "Password",
                      //   ),
                      //   validator: (value) {

                      //   },
                      // ),
                      // CustomTextFormField(
                      //   textFieldController: confirmPasswordController,
                      //   isPassword: true,
                      //   inputAction: TextInputAction.done,
                      //   validator: (value) {

                      //   },
                      //   hintText: translatedText(
                      //     context: context,
                      //     arabicText: "تأكيد كلمة المرور",
                      //     englishText: "Confirm Password",
                      //   ),
                      // ),
                      CustomButton(
                        buttonName: translatedText(
                          context: context,
                          arabicText: "انشاء حساب",
                          englishText: "Register",
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                            // showCustomSnackBar(
                            //   context: context,
                            //   message: translatedText(
                            //       context: context,
                            //       arabicText:
                            //           "برجاء ادخال اسم المستخدم و كلمة المرور",
                            //       englishText:
                            //           "Please enter username and password!"),
                            //   color: ColorsManager.redColor,
                            // );
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
                            } else if (phoneController.text.length != 11) {
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
                            } else if (passwordController.text !=
                                confirmPasswordController.text) {
                              showCustomSnackBar(
                                context: context,
                                message: translatedText(
                                  context: context,
                                  arabicText:
                                      "كلمة المرور  و تأكيد كلمة المرور غير متطابقان",
                                  englishText:
                                      "Password and confirm password is not matched",
                                ),
                                color: ColorsManager.redColor,
                              );
                              return;
                            }
                          }
                          context.read<AuthCubit>().registerByEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                        },
                        color: context.read<AppCubit>().currentThemeMode ==
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
