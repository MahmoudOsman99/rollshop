import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      textDirection: TextDirection.rtl,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: isReadOnly ?? false,
      validator: isRequired!
          ? (value) {
              if (value == null || value.isEmpty) {
                return "برجاء ادخال $hintText";
              }
            }
          : null,
      autofocus: autofocus ?? false,
      decoration: InputDecoration(
        // hintText: hintText,
        label: Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Text(
            "$hintText",
            style: MyTextStyles.lable18OrangeBold,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintTextDirection: TextDirection.rtl,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorsManager.orangeColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
