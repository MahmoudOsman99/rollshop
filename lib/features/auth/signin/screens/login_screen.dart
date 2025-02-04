import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final formKey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  CustomTextFormField(
                    textFieldController: userNameController,
                    inputAction: TextInputAction.next,
                    hintText: translatedText(
                      context: context,
                      arabicText: "اسم المستخدم",
                      englishText: "User name",
                    ),
                  ),
                  CustomTextFormField(
                    textFieldController: passwordController,
                    isPassword: true,
                    inputAction: TextInputAction.done,
                    hintText: translatedText(
                      context: context,
                      arabicText: "كلمة المرور",
                      englishText: "Password",
                    ),
                  ),
                  CustomButton(
                    buttonName: translatedText(
                      context: context,
                      arabicText: "دجول",
                      englishText: "Sign in",
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        showCustomSnackBar(
                          context: context,
                          message: translatedText(
                              context: context,
                              arabicText:
                                  "برجاء ادخال اسم المستخدم و كلمة المرور",
                              englishText:
                                  "Please enter username and password!"),
                          color: ColorsManager.redAccent,
                        );
                      } else {}
                    },
                    color: context.read<AppCubit>().currentThemeMode ==
                            ThemeMode.dark
                        ? ColorsManager.redAccent
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
                        },
                        child: TranslatedTextWidget(
                          arabicText: "انشاء حساب",
                          englishText: "Register",
                          textStyle: MyTextStyles.font16Bold(Theme.of(context))
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
  }
}
