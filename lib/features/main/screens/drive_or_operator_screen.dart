import 'package:flutter/material.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/features/main/widgets/work_type_button.dart';

class DriveOrOperatorScreen extends StatelessWidget {
  const DriveOrOperatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WorkTypeButton(
                buttonName: 'درايف',
                onPressed: () {
                  context.pushNamed(Routes.topOrBottomScreen);
                },
              ),
              WorkTypeButton(
                buttonName: 'مشغل',
                onPressed: () {
                  context.pushNamed(Routes.topOrBottomScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
