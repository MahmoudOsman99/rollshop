import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/translated_text_widget.dart';
import 'package:rollshop/core/theme/styles.dart';

import '../../core/theme/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textFieldController;
  String? hintText;
  int? maxLines = 5;
  TextInputAction? inputAction = TextInputAction.next;
  TextInputType? keyboardType;
  bool? autofocus;
  bool? isRequired;
  bool? isReadOnly;
  // bool? showSnakBarError;
  bool isPassword;
  String? Function(String?)? validator;
  Widget? prefixIcon;
  Widget? sufixIcon;
  // bool isMultiLine;
  // TextDirection? textDirection = TextDirection.rtl;
  CustomTextFormField({
    super.key,
    required this.textFieldController,
    this.hintText,
    this.inputAction,
    this.maxLines,
    this.autofocus,
    // this.textDirection,
    this.keyboardType,
    this.isRequired = true,
    this.isReadOnly = false,
    this.isPassword = false,
    this.validator,
    this.prefixIcon,
    this.sufixIcon,
    // this.showSnakBarError = true,
    // this.isMultiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      // textDirection: TextDirection.rtl,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      maxLines: isPassword ? 1 : maxLines,
      readOnly: isReadOnly ?? false,
      obscureText: isPassword,
      validator: validator ??
          (isRequired!
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return translatedText(
                      context: context,
                      arabicText: "برجاء ادخال $hintText",
                      englishText: "Please enter $hintText",
                    );
                    // return "برجاء ادخال $hintText";
                  }
                }
              : null),
      autofocus: autofocus ?? false,
      decoration: InputDecoration(
        // hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        label: Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Text(
            hintText ?? "",
            style: MyTextStyles.lable18OrangeBold(theme: Theme.of(context)),
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintTextDirection: TextDirection.rtl,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: ColorsManager.orangeColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
