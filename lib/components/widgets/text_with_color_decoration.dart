import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithColorDecoration extends StatelessWidget {
  TextWithColorDecoration({
    super.key,
    required this.backColor,
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
        color: backColor,
        borderRadius: BorderRadius.circular(5),
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
