import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/styles.dart';

class WorkTypeButton extends StatelessWidget {
  String buttonName;
  VoidCallback onPressed;
  WorkTypeButton({
    required this.buttonName,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsManager.mainBlue,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            buttonName,
            textAlign: TextAlign.center,
            style: MyTextStyles.font32WhiteBold,
          ),
        ),
      ),
    );
  }
}
