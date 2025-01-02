import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChockDetailesScreen extends StatelessWidget {
  ChockTypesModel chock;
  ChockDetailesScreen({
    super.key,
    required this.chock,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chock.name),
        titleTextStyle: MyTextStyles.font32WhiteBold,
        centerTitle: true,
        backgroundColor: ColorsManager.darkModeColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                chock.chockImagePath,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              chock.name,
              style: MyTextStyles.font32WhiteBold,
            ),
            Expanded(
              child: Text(
                chock.assemblySteps.first.description,
                style: MyTextStyles.font32WhiteBold,
              ),
            ),
            // Expanded(
            //   child: Text(
            //     chock.notes,
            //     style: MyTextStyles.font32WhiteBold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
