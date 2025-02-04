import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import '/core/theme/colors.dart';

class MyTextStyles {
  static TextStyle font24Weight700(ThemeData theme) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 24.sp,
      color: theme.brightness == Brightness.dark
          ? ColorsManager.whiteText
          : ColorsManager.blackText,
      // color: Colors.black,
    );
  }

  static TextStyle font32OrangeBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: ColorsManager.orangeColor,
  );
  static TextStyle font32Bold(ThemeData theme) {
    return TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
      color: theme.brightness == Brightness.dark
          ? ColorsManager.whiteText
          : ColorsManager.blackText,
    );
  }

  static TextStyle font13GreyRegular(ThemeData theme) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
        color: theme.brightness == Brightness.dark
            ? ColorsManager.whiteText
            : ColorsManager.greyText,
      );
  static TextStyle font14OrangeOrRedBold(ThemeData theme) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: theme.brightness == Brightness.light
            ? ColorsManager.orangeColor
            : ColorsManager.redAccent,
      );

  static TextStyle font16Weight500(ThemeData theme) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: theme.brightness == Brightness.dark
            ? ColorsManager.whiteText
            : ColorsManager.blackText,
      );
  // static TextStyle font16WhiteWeight500 = TextStyle(
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.w500,
  //   color: Colors.white,
  // );
  // static TextStyle font16WhiteBold = TextStyle(
  //   fontSize: 16.sp,
  //   fontWeight: FontWeight.bold,
  //   color: Colors.white,
  // );
  static TextStyle font16BlackeWeight500 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle font16Bold(ThemeData theme) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: theme.brightness == Brightness.dark
            ? ColorsManager.whiteText
            : ColorsManager.blackText,
      );
  static TextStyle font12(ThemeData theme, {FontWeight? fontWeight}) =>
      TextStyle(
        fontSize: 12.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: theme.brightness == Brightness.dark
            ? ColorsManager.whiteText
            : ColorsManager.blackText,
      );
  static TextStyle lable18OrangeBold({required ThemeData theme}) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: theme.brightness == Brightness.light
            ? ColorsManager.orangeColor
            : ColorsManager.redAccent,
      );
}
