import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';

class CustomButton extends StatelessWidget {
  String buttonName;
  Color color;
  Color textColor = ColorsManager.whiteColor;
  VoidCallback onPressed;
  CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.8,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: MyTextStyles.font16Bold(Theme.of(context)),
          ),
        ),
      ),
    );
  }
}
