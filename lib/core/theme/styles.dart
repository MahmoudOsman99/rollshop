import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/colors.dart';

class MyTextStyles {
  static TextStyle font24Black700Weight = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
    color: Colors.black,
  );

  static TextStyle font32BlueBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: ColorsManager.mainBlue,
  );
  static TextStyle font32WhiteBold = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: ColorsManager.whiteText,
  );

  static TextStyle font13GreyRegular = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
    color: ColorsManager.greyText,
  );

  static TextStyle font16WhiteWeight500 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
