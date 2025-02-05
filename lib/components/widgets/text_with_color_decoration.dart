import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';

class TextWithColorDecoration extends StatelessWidget {
  TextWithColorDecoration({
    super.key,
    this.backColor = ColorsManager.redAccent,
    required this.lable,
    required this.textStyle,
  });
  String lable;
  Color backColor;
  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.read<AppCubit>().currentThemeMode == ThemeMode.dark
            ? ColorsManager.lightBlue
            : ColorsManager.orangeColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 4.sp,
          end: 4.sp,
          top: 3.sp,
          bottom: 3.sp,
        ),
        child: Text(
          lable,
          style: textStyle,
        ),
      ),
    );
  }
}
