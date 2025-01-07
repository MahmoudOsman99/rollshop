import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 20.sp,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.allPartsScreen);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorsManager.orangeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Parts",
                            style: MyTextStyles.font32WhiteBold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.allChocksScreen);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorsManager.orangeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Chocks",
                            style: MyTextStyles.font32WhiteBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
