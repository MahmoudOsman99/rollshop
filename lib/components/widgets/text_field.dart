import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/theme/styles.dart';

import '../../core/theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  String? hintText;
  int? maxLines = 5;
  TextInputAction? inputAction = TextInputAction.next;
  TextInputType? keyboardType;
  // TextDirection? textDirection = TextDirection.rtl;
  CustomTextField({
    super.key,
    required this.textFieldController,
    this.hintText,
    this.inputAction,
    this.maxLines,
    // this.textDirection,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      textDirection: TextDirection.rtl,
      textInputAction: inputAction,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
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
