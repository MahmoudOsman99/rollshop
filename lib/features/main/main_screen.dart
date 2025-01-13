import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                spacing: 20.sp,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    spacing: 20.sp,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.allPartsScreen);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            // color: ColorsManager.orangeColor,
                            border: Border.all(
                              width: 2,
                              color: ColorsManager.mainBlue,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: SizedBox(
                              width: context.width * .3,
                              height: context.height * 0.2,
                              child: BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.listImagePath,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorsManager.mainBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10.sp,
                            bottom: 10.sp,
                            left: 40.sp,
                            right: 40.sp,
                          ),
                          child: Text(
                            "Parts",
                            style: MyTextStyles.font32WhiteBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 20.sp,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(Routes.allChocksScreen);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            // color: ColorsManager.orangeColor,
                            border: Border.all(
                              width: 2,
                              color: ColorsManager.mainBlue,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: SizedBox(
                              width: context.width * .3,
                              height: context.height * 0.2,
                              child: BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.bdmChockImagePath,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: ColorsManager.mainBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10.sp,
                            bottom: 10.sp,
                            left: 10.sp,
                            right: 10.sp,
                          ),
                          child: Text(
                            "All Chocks",
                            style: MyTextStyles.font32WhiteBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     context.pushNamed(Routes.allChocksScreen);
                  //   },
                  //   child: DecoratedBox(
                  //     decoration: BoxDecoration(
                  //       color: ColorsManager.orangeColor,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(20),
                  //       child: Text(
                  //         "Chocks",
                  //         style: MyTextStyles.font32WhiteBold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
