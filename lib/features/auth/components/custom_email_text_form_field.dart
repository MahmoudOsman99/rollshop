import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/components/widgets/custom_text_field.dart';
import 'package:rollshop/components/widgets/snack_bar.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/theme/colors.dart';

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
            arabicText: "برجاء ادخال البريد الالكتروني",
            englishText: "Please enter your email",
          );
        }
        if (!EmailValidator.validate(value)) {
          showCustomSnackBar(
            context: context,
            message: translatedText(
              context: context,
              arabicText: "صيغة البريد الالكتروني غير صحيحة",
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
        arabicText: "البريد الالكتروني",
        englishText: "Email",
      ),
    );
  }
}
