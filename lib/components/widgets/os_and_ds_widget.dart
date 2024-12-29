import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/styles.dart';

class OperatorAndDriveSection extends StatelessWidget {
  const OperatorAndDriveSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Drive Side',
          style: MyTextStyles.font32WhiteBold,
        ),
        Text(
          'Operator Side',
          style: MyTextStyles.font32WhiteBold,
        ),
      ],
    );
  }
}
