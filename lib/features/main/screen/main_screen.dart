import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/screens/all_chocks_screen.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/main/screen/profile_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _controller = PersistentTabController(initialIndex: 0);
  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //       return [
  //          PersistentBottomNavBarItem(
  //               icon: Icon(CupertinoIcons.home),
  //               title: ("Home"),
  //               activeColorPrimary: CupertinoColors.activeBlue,
  //               inactiveColorPrimary: CupertinoColors.systemGrey,
  //               // scrollController: _scrollController1,
  //               routeAndNavigatorSettings: RouteAndNavigatorSettings(
  //                   initialRoute: "/",
  //                   routes: {
  //                   "/first": (final context) => const MainScreen2(),
  //                   "/second": (final context) => const MainScreen3(),
  //                   },
  //               ),
  //           ),
  // PersistentBottomNavBarItem(
  //     icon: Icon(CupertinoIcons.home),
  //     title: ("Home"),
  //     activeColorPrimary: CupertinoColors.activeBlue,
  //     inactiveColorPrimary: CupertinoColors.systemGrey,
  //     // scrollController: _scrollController1,
  //     routeAndNavigatorSettings: RouteAndNavigatorSettings(
  //         initialRoute: "/",
  //         routes: {
  //         "/first": (final context) => const MainScreen2(),
  //         "/second": (final context) => const MainScreen3(),
  //         },
  //     ),
  // ),
  // PersistentBottomNavBarItem(
  //     icon: Icon(CupertinoIcons.settings),
  //     title: ("Settings"),
  //     activeColorPrimary: CupertinoColors.activeBlue,
  //     inactiveColorPrimary: CupertinoColors.systemGrey,
  //     scrollController: _scrollController2,
  //     routeAndNavigatorSettings: RouteAndNavigatorSettings(
  //         initialRoute: "/",
  //         routes: {
  //         "/first": (final context) => const MainScreen2(),
  //         "/second": (final context) => const MainScreen3(),
  //         },
  //     ),
  // ),
  //     ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          backgroundColor:
              context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                  ? ColorsManager.darkModeColor
                  : ColorsManager.whiteColor,
          width: context.width * 0.6.w,
          child: Padding(
            padding: EdgeInsetsDirectional.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 20.h,
              children: [
                Center(
                  child: SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75.r),
                      child: BuildImageWithErrorHandler(
                        imageType: ImageType.network,
                        path: "https://i.imgur.com/kldXnVq.jpeg",
                      ),
                    ),
                  ),
                ),

                Text(
                  "Mahmoud Osman",
                  style: MyTextStyles.font24Weight700(Theme.of(context)),
                ),
                Text(
                  "Theme",
                  style: MyTextStyles.font16Bold(Theme.of(context)),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AppCubit>().changeAppTheme();
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          width: 2,
                          color: ColorsManager.orangeColor,
                        )),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 20.r,
                        bottom: 20.r,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                  scale: animation, child: child);
                            },
                            child: Icon(
                              context.read<AppCubit>().currentThemeMode ==
                                      ThemeMode.dark
                                  ? Icons.brightness_7
                                  : Icons.brightness_2,
                              key: ValueKey<bool>(
                                context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark,
                              ), // Key for animation
                            ),
                          ),
                          Text(
                            context.read<AppCubit>().currentThemeMode ==
                                    ThemeMode.dark
                                ? "Light Theme"
                                : "Dark Theme",
                            style: MyTextStyles.font16Bold(Theme.of(context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // CustomButton(
                //   buttonName: context.read<AppCubit>().currentThemeMode ==
                //           ThemeMode.dark
                //       ? "Light Theme"
                //       : "Dark Theme",
                //   onPressed: context.read<AppCubit>().changeAppTheme,
                //   color: ColorsManager.mainTeal,
                // ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              spacing: 20.w,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  spacing: 20.h,
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
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20.r),
                          child: SizedBox(
                            width: context.width * .3,
                            height: context.height * 0.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.listImagePath,
                                boxFit: BoxFit.cover,
                              ),
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
                          style: MyTextStyles.font32Bold(Theme.of(context)),
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
                          padding: EdgeInsets.all(20.r),
                          child: SizedBox(
                            width: context.width * .3,
                            height: context.height * 0.2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: BuildImageWithErrorHandler(
                                imageType: ImageType.asset,
                                path: ImagesPath.bdmChockImagePath,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.r,
                          bottom: 10.r,
                          left: 10.r,
                          right: 10.r,
                        ),
                        child: Text(
                          "All Chocks",
                          style: MyTextStyles.font32Bold(Theme.of(context)),
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
    );
  }
}
