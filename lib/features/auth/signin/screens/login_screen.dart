import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
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
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                        arabicText: "تسجيل دخول",
                        englishText: "Sign in",
                        textStyle: MyTextStyles.font32Bold(Theme.of(context)),
                      ),
                      CustomEmailFormField(
                        emailController: userNameController,
                      ),
                      CustomPasswordFormField(
                        passwordController: passwordController,
                        hintText: translatedText(
                          context: context,
                          arabicText: "كلمة المرور",
                          englishText: "Password",
                        ),
                      ),
                      CustomButton(
                        buttonName: translatedText(
                          context: context,
                          arabicText: "دخول",
                          englishText: "Sign in",
                        ),
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
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
                          } else {}
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
                            arabicText: "ليس لديك حساب؟",
                            englishText: "Don't have an account?",
                          ),
                          GestureDetector(
                            onTap: () {
                              debugPrint("Register button");
                              context
                                  .pushReplacementNamed(Routes.registerScreen);
                            },
                            child: TranslatedTextWidget(
                              arabicText: "انشاء حساب",
                              englishText: "Register",
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

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    super.key,
    required this.passwordController,
    this.validator,
    this.hintText,
  });

  final TextEditingController passwordController;
  final String? Function(String? value)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFieldController: passwordController,
      isPassword: context.read<AuthCubit>().showPassword,
      validator: validator,
      sufixIcon: GestureDetector(
        onTap: () {
          context.read<AuthCubit>().changeShowPassword();
        },
        child: Icon(
          context.read<AuthCubit>().showPassword
              ? Icons.visibility
              : Icons.visibility_off,
        ),
      ),
      inputAction: TextInputAction.done,
      hintText: hintText,
    );
  }
}

class CustomEmailFormField extends StatelessWidget {
  const CustomEmailFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      textFieldController: emailController,
      inputAction: TextInputAction.next,
      sufixIcon: Icon(
        Icons.email,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return translatedText(
            context: context,
            arabicText: "برجاء ادخال البريد الاليكتروني",
            englishText: "Please enter your email",
          );
        }
        if (!EmailValidator.validate(value)) {
          showCustomSnackBar(
            context: context,
            message: translatedText(
              context: context,
              arabicText: "صيغة البريد الاليكتروني غير صحيحة",
              englishText: "Email address not valid",
            ),
            color: ColorsManager.redColor,
          );
          return translatedText(
            context: context,
            arabicText: "صيغة الايميل غير صحيحة",
            englishText: "Email format incorrect",
          );
        } else {
          return null;
        }
      },
      hintText: translatedText(
        context: context,
        arabicText: "البريد الاليكتروني",
        englishText: "Email",
      ),
    );
  }
}
