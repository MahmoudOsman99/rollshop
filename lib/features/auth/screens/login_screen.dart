import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
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
import 'package:rollshop/features/auth/model/user_model.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          // final user = context.read<AuthCubit>().get
          // context.pushReplacementNamed(Routes.allChocksScreen);
          showCustomSnackBar(
            context: context,
            message: translatedText(
              context: context,
              arabicText: "تم تسجيل الدخول بنجاح",
              englishText: "Successfully logged in",
            ),
            color: ColorsManager.mainTeal,
          );
          context.pushReplacementNamed(Routes.mainScreenScreen);

          // context.pushReplacementNamed(
          //   Routes.profileScreenRoute,
          //   arguments: UserModel(
          //     name: "Osman",
          //     email: emailController.text,
          //     userType: UserType.admin.name,
          //     phoneNumber: "01000249042",
          //   ),
          // );
        } else if (state is AuthLoginFailureState) {
          if (state.failure is UserNotFoundFailure) {
            showCustomSnackBar(
              context: context,
              message: translatedText(
                context: context,
                arabicText: "لا يوجد مستخدم مسسجل بهذه البيانات",
                englishText: "There is no user registered by this email",
              ),
              color: ColorsManager.redColor,
            );
            return;
          }
          showCustomSnackBar(
            context: context,
            message: translatedText(
              context: context,
              arabicText: "البريد الالكتروني او كلمة المرور غير صحيحة",
              englishText: "Email or password is incorrect",
            ),
            color: ColorsManager.redColor,
          );
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20.h,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TranslatedTextWidget(
                          arabicText: "تسجيل دخول",
                          englishText: "Sign in",
                          textStyle: MyTextStyles.font32Bold(Theme.of(context)),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TranslatedTextWidget(
                          arabicText: "اهلا بيك",
                          englishText: "Welcome back",
                          textStyle: MyTextStyles.font16Bold(Theme.of(context)),
                        ),
                      ),
                      CircleAvatar(
                        radius: 150.r,
                        child: SvgPicture.asset(
                          SvgsPaths.loginSvgPath,
                          semanticsLabel: 'Login logo',
                        ),
                      ),
                      CustomEmailFormField(
                        emailController: emailController,
                      ),
                      CustomPasswordFormField(
                        passwordController: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translatedText(
                              context: context,
                              arabicText: "يجب ادخال كلمة المرور",
                              englishText: "Password is required",
                            );
                          } else if (value.length < 6) {
                            return translatedText(
                              context: context,
                              arabicText: "كلمة المرور اقل من ٦ حروف",
                              englishText:
                                  "Password must be 6 digits or hiegher",
                            );
                          } else {
                            return null;
                          }
                        },
                        hintText: translatedText(
                          context: context,
                          arabicText: "كلمة المرور",
                          englishText: "Password",
                        ),
                      ),
                      state is AuthLoginLoadingState
                          ? CircularProgressIndicator.adaptive()
                          : SizedBox(
                              width: context.width,
                              child: CustomButton(
                                buttonName: translatedText(
                                  context: context,
                                  arabicText: "دخول",
                                  englishText: "Sign in",
                                ),
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) {
                                  } else {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                  }
                                },
                                color:
                                    context.read<AppCubit>().currentThemeMode ==
                                            ThemeMode.dark
                                        ? ColorsManager.lightBlue
                                        : ColorsManager.orangeColor,
                              ),
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
