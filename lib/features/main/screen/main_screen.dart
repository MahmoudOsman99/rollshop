import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/chock_feature/screens/all_chocks_screen.dart';
import 'package:rollshop/features/chock_feature/widgets/build_chock_item.dart';
import 'package:rollshop/features/main/components/navbar_components.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/main/cubit/app_state.dart';
import 'package:rollshop/features/main/screen/settings_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _bottomNavIndex = 0;
  final _pageController = PageController();

  // final _controller = PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    if (Platform.isMacOS) {
      debugPrint("In macOS");
    } else if (Platform.isIOS) {
      debugPrint("In IOS");
    }
    return Scaffold(
      // appBar: AppBar(
      //   actions: [],
      //   leading: IconButton(
      //       onPressed: () {
      //         showSearch(
      //           context: context,
      //           delegate: CustomSearchDelegate(),
      //         );
      //       },
      //       icon: Icon(Icons.search)),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.dark_mode,
      //   ),
      //   //params
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   icons: [Icons.portrait, Icons.home, Icons.list],
      //   activeIndex: _bottomNavIndex,
      //   gapLocation: GapLocation.center,
      //   leftCornerRadius: 32,
      //   rightCornerRadius: 32,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   onTap: _onTappedBar,
      // onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
      // ),
      //  BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.list), label: "Parts"),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.portrait),
      //       label: 'Profile',
      //     )
      //   ],
      //   onTap: _onTappedBar,
      //   selectedItemColor: Colors.orange,
      //   currentIndex: _bottomNavIndex,
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _bottomNavIndex = value;
          });
        },
        children: <Widget>[
          AllChocksScreen(),
          AllPartsScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: onTappedBar,
        iconSize: 25.sp,
        selectedItemColor:
            context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                ? ColorsManager.lightBlue
                : ColorsManager.orangeColor,
        backgroundColor:
            context.read<AppCubit>().currentThemeMode == ThemeMode.dark
                ? ColorsManager.blackBackGround
                : ColorsManager.lightWhite,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: locale.languageCode == 'ar' ? "كل الكراسي" : "All Chocks",
            //  "All Chocks",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: locale.languageCode == 'ar' ? "كل العناصر" : "All Parts",

            // label: "All Parts",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: locale.languageCode == 'ar' ? "الاعدادات" : "Settings",
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: ColorsManager.orangeColor,
      //   onPressed: () {},
      //   child: Icon(
      //     Icons.dark_mode,
      //     color: ColorsManager.whiteColor,
      //   ),
      // ),
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   backgroundColor: ColorsManager.blackBackGround,
      //   activeColor: ColorsManager.redAccent,
      //   inactiveColor: ColorsManager.orangeColor,

      //   icons: [
      //     Icons.home,
      //     Icons.list,
      //     Icons.portrait,
      //     Icons.settings,
      //   ],
      //   activeIndex: _bottomNavIndex,
      //   gapLocation: GapLocation.center,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   leftCornerRadius: 32,
      //   rightCornerRadius: 32,
      //   onTap: onTappedBar,
      //   //other params
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   //params
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   icons: [
      //     Icons.home,
      //     Icons.settings,
      //     Icons.list,
      //   ],
      //   // icons: iconList,
      //   activeIndex: _bottomNavIndex,
      //   gapLocation: GapLocation.end,
      //   notchSmoothness: NotchSmoothness.verySmoothEdge,
      //   leftCornerRadius: 32,
      //   rightCornerRadius: 0,
      //   onTap: (index) {
      //     setState(() {
      //       _bottomNavIndex = index;
      //     });
      //   },
      //   //other params
      // ),
      // drawer: SafeArea(
      //   child: Drawer(
      //     backgroundColor:
      //         context.read<AppCubit>().currentThemeMode == ThemeMode.dark
      //             ? ColorsManager.darkModeColor
      //             : ColorsManager.whiteColor,
      //     width: context.width * 0.6.w,
      //     child: Padding(
      //       padding: EdgeInsetsDirectional.all(20.r),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         spacing: 20.h,
      //         children: [
      //           Center(
      //             child: SizedBox(
      //               width: 150.w,
      //               height: 150.h,
      //               child: ClipRRect(
      //                 borderRadius: BorderRadius.circular(75.r),
      //                 child: BuildImageWithErrorHandler(
      //                   imageType: ImageType.network,
      //                   path: "https://i.imgur.com/kldXnVq.jpeg",
      //                 ),
      //               ),
      //             ),
      //           ),

      //           Text(
      //             "Mahmoud Osman",
      //             style: MyTextStyles.font24Weight700(Theme.of(context)),
      //           ),
      //           Text(
      //             "Theme",
      //             style: MyTextStyles.font16Bold(Theme.of(context)),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               context.read<AppCubit>().changeAppTheme();
      //             },
      //             child: DecoratedBox(
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10.r),
      //                   border: Border.all(
      //                     width: 2,
      //                     color: ColorsManager.orangeColor,
      //                   )),
      //               child: Padding(
      //                 padding: EdgeInsetsDirectional.only(
      //                   top: 20.r,
      //                   bottom: 20.r,
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   children: [
      //                     AnimatedSwitcher(
      //                       duration: const Duration(milliseconds: 300),
      //                       transitionBuilder:
      //                           (Widget child, Animation<double> animation) {
      //                         return ScaleTransition(
      //                             scale: animation, child: child);
      //                       },
      //                       child: Icon(
      //                         context.read<AppCubit>().currentThemeMode ==
      //                                 ThemeMode.dark
      //                             ? Icons.brightness_7
      //                             : Icons.brightness_2,
      //                         key: ValueKey<bool>(
      //                           context.read<AppCubit>().currentThemeMode ==
      //                               ThemeMode.dark,
      //                         ), // Key for animation
      //                       ),
      //                     ),
      //                     Text(
      //                       context.read<AppCubit>().currentThemeMode ==
      //                               ThemeMode.dark
      //                           ? "Light Theme"
      //                           : "Dark Theme",
      //                       style: MyTextStyles.font16Bold(Theme.of(context)),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           // CustomButton(
      //           //   buttonName: context.read<AppCubit>().currentThemeMode ==
      //           //           ThemeMode.dark
      //           //       ? "Light Theme"
      //           //       : "Dark Theme",
      //           //   onPressed: context.read<AppCubit>().changeAppTheme,
      //           //   color: ColorsManager.mainTeal,
      //           // ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      // appBar: AppBar(),
      // body: PageView(
      //   physics: BouncingScrollPhysics(),
      //   controller: pageController,
      //   scrollDirection: Axis.horizontal,

      //   children: [
      //     AllChocksScreen(),
      //     AllPartsScreen(),
      //     ProfileScreen(),
      //   ],
      // ),

      //  Padding(
      //   padding: EdgeInsets.all(8.0.r),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Row(
      //         spacing: 20.w,
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           Column(
      //             spacing: 20.h,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {
      //                   context.pushNamed(Routes.allPartsScreen);
      //                 },
      //                 child: DecoratedBox(
      //                   decoration: BoxDecoration(
      //                     // color: ColorsManager.orangeColor,
      //                     border: Border.all(
      //                       width: 2,
      //                       color: ColorsManager.mainBlue,
      //                     ),
      //                     borderRadius: BorderRadius.circular(10.r),
      //                   ),
      //                   child: Padding(
      //                     padding: EdgeInsets.all(20.r),
      //                     child: SizedBox(
      //                       width: context.width * .3,
      //                       height: context.height * 0.2,
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(10.r),
      //                         child: BuildImageWithErrorHandler(
      //                           imageType: ImageType.asset,
      //                           path: ImagesPath.listImagePath,
      //                           boxFit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               DecoratedBox(
      //                 decoration: BoxDecoration(
      //                   color: ColorsManager.mainBlue,
      //                   borderRadius: BorderRadius.circular(10),
      //                 ),
      //                 child: Padding(
      //                   padding: EdgeInsets.only(
      //                     top: 10.sp,
      //                     bottom: 10.sp,
      //                     left: 40.sp,
      //                     right: 40.sp,
      //                   ),
      //                   child: Text(
      //                     "Parts",
      //                     style: MyTextStyles.font32Bold(Theme.of(context)),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           Column(
      //             spacing: 20.sp,
      //             children: [
      //               GestureDetector(
      //                 onTap: () {
      //                   context.pushNamed(Routes.allChocksScreen);
      //                 },
      //                 child: DecoratedBox(
      //                   decoration: BoxDecoration(
      //                     // color: ColorsManager.orangeColor,
      //                     border: Border.all(
      //                       width: 2,
      //                       color: ColorsManager.mainBlue,
      //                     ),
      //                     borderRadius: BorderRadius.circular(10),
      //                   ),
      //                   child: Padding(
      //                     padding: EdgeInsets.all(20.r),
      //                     child: SizedBox(
      //                       width: context.width * .3,
      //                       height: context.height * 0.2,
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(10.r),
      //                         child: BuildImageWithErrorHandler(
      //                           imageType: ImageType.asset,
      //                           path: ImagesPath.bdmChockImagePath,
      //                           boxFit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               DecoratedBox(
      //                 decoration: BoxDecoration(
      //                   color: ColorsManager.mainBlue,
      //                   borderRadius: BorderRadius.circular(10.r),
      //                 ),
      //                 child: Padding(
      //                   padding: EdgeInsets.only(
      //                     top: 10.r,
      //                     bottom: 10.r,
      //                     left: 10.r,
      //                     right: 10.r,
      //                   ),
      //                   child: Text(
      //                     "All Chocks",
      //                     style: MyTextStyles.font32Bold(Theme.of(context)),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //           // GestureDetector(
      //           //   onTap: () {
      //           //     context.pushNamed(Routes.allChocksScreen);
      //           //   },
      //           //   child: DecoratedBox(
      //           //     decoration: BoxDecoration(
      //           //       color: ColorsManager.orangeColor,
      //           //       borderRadius: BorderRadius.circular(10),
      //           //     ),
      //           //     child: Padding(
      //           //       padding: EdgeInsets.all(20),
      //           //       child: Text(
      //           //         "Chocks",
      //           //         style: MyTextStyles.font32WhiteBold,
      //           //       ),
      //           //     ),
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
    // PersistentTabView(
    //   context,
    //   controller: _controller,
    //   screens: [
    //     AllChocksScreen(),
    //     AllPartsScreen(),
    //     ProfileScreen(),
    //   ],
    //   items: navItems,
    //   // screens: _buildScreens(),
    //   // items: _navBarsItems(),
    //   handleAndroidBackButtonPress: true, // Default is true.
    //   resizeToAvoidBottomInset:
    //       true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
    //   stateManagement: true, // Default is true.
    //   hideNavigationBarWhenKeyboardAppears: true,
    //   // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
    //   padding: const EdgeInsets.only(top: 8),
    //   backgroundColor:
    //       context.read<AppCubit>().currentThemeMode == ThemeMode.dark
    //           ? ColorsManager.darkModeColor
    //           : ColorsManager.whiteColor,
    //   isVisible: true,
    //   animationSettings: const NavBarAnimationSettings(
    //     navBarItemAnimation: ItemAnimationSettings(
    //       // Navigation Bar's items animation properties.
    //       duration: Duration(milliseconds: 400),
    //       curve: Curves.ease,
    //     ),
    //     screenTransitionAnimation: ScreenTransitionAnimationSettings(
    //       // Screen transition animation on change of selected tab.
    //       animateTabTransition: true,
    //       duration: Duration(milliseconds: 400),
    //       screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
    //     ),
    //   ),
    //   confineToSafeArea: true,
    //   navBarHeight: kBottomNavigationBarHeight,
    //   navBarStyle: NavBarStyle.style7,

    //   // navBarStyle: _navBarStyle, // Choose the nav bar style with this property
    // );
    // return Scaffold(
    //   drawer: SafeArea(
    //     child: Drawer(
    //       backgroundColor:
    //           context.read<AppCubit>().currentThemeMode == ThemeMode.dark
    //               ? ColorsManager.darkModeColor
    //               : ColorsManager.whiteColor,
    //       width: context.width * 0.6.w,
    //       child: Padding(
    //         padding: EdgeInsetsDirectional.all(20.r),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           spacing: 20.h,
    //           children: [
    //             Center(
    //               child: SizedBox(
    //                 width: 150.w,
    //                 height: 150.h,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(75.r),
    //                   child: BuildImageWithErrorHandler(
    //                     imageType: ImageType.network,
    //                     path: "https://i.imgur.com/kldXnVq.jpeg",
    //                   ),
    //                 ),
    //               ),
    //             ),

    //             Text(
    //               "Mahmoud Osman",
    //               style: MyTextStyles.font24Weight700(Theme.of(context)),
    //             ),
    //             Text(
    //               "Theme",
    //               style: MyTextStyles.font16Bold(Theme.of(context)),
    //             ),
    //             GestureDetector(
    //               onTap: () {
    //                 context.read<AppCubit>().changeAppTheme();
    //               },
    //               child: DecoratedBox(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(10.r),
    //                     border: Border.all(
    //                       width: 2,
    //                       color: ColorsManager.orangeColor,
    //                     )),
    //                 child: Padding(
    //                   padding: EdgeInsetsDirectional.only(
    //                     top: 20.r,
    //                     bottom: 20.r,
    //                   ),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       AnimatedSwitcher(
    //                         duration: const Duration(milliseconds: 300),
    //                         transitionBuilder:
    //                             (Widget child, Animation<double> animation) {
    //                           return ScaleTransition(
    //                               scale: animation, child: child);
    //                         },
    //                         child: Icon(
    //                           context.read<AppCubit>().currentThemeMode ==
    //                                   ThemeMode.dark
    //                               ? Icons.brightness_7
    //                               : Icons.brightness_2,
    //                           key: ValueKey<bool>(
    //                             context.read<AppCubit>().currentThemeMode ==
    //                                 ThemeMode.dark,
    //                           ), // Key for animation
    //                         ),
    //                       ),
    //                       Text(
    //                         context.read<AppCubit>().currentThemeMode ==
    //                                 ThemeMode.dark
    //                             ? "Light Theme"
    //                             : "Dark Theme",
    //                         style: MyTextStyles.font16Bold(Theme.of(context)),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             // CustomButton(
    //             //   buttonName: context.read<AppCubit>().currentThemeMode ==
    //             //           ThemeMode.dark
    //             //       ? "Light Theme"
    //             //       : "Dark Theme",
    //             //   onPressed: context.read<AppCubit>().changeAppTheme,
    //             //   color: ColorsManager.mainTeal,
    //             // ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   appBar: AppBar(),
    //   body: Padding(
    //     padding: EdgeInsets.all(8.0.r),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Row(
    //           spacing: 20.w,
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Column(
    //               spacing: 20.h,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () {
    //                     context.pushNamed(Routes.allPartsScreen);
    //                   },
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       // color: ColorsManager.orangeColor,
    //                       border: Border.all(
    //                         width: 2,
    //                         color: ColorsManager.mainBlue,
    //                       ),
    //                       borderRadius: BorderRadius.circular(10.r),
    //                     ),
    //                     child: Padding(
    //                       padding: EdgeInsets.all(20.r),
    //                       child: SizedBox(
    //                         width: context.width * .3,
    //                         height: context.height * 0.2,
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(10.r),
    //                           child: BuildImageWithErrorHandler(
    //                             imageType: ImageType.asset,
    //                             path: ImagesPath.listImagePath,
    //                             boxFit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 DecoratedBox(
    //                   decoration: BoxDecoration(
    //                     color: ColorsManager.mainBlue,
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   child: Padding(
    //                     padding: EdgeInsets.only(
    //                       top: 10.sp,
    //                       bottom: 10.sp,
    //                       left: 40.sp,
    //                       right: 40.sp,
    //                     ),
    //                     child: Text(
    //                       "Parts",
    //                       style: MyTextStyles.font32Bold(Theme.of(context)),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Column(
    //               spacing: 20.sp,
    //               children: [
    //                 GestureDetector(
    //                   onTap: () {
    //                     context.pushNamed(Routes.allChocksScreen);
    //                   },
    //                   child: DecoratedBox(
    //                     decoration: BoxDecoration(
    //                       // color: ColorsManager.orangeColor,
    //                       border: Border.all(
    //                         width: 2,
    //                         color: ColorsManager.mainBlue,
    //                       ),
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                     child: Padding(
    //                       padding: EdgeInsets.all(20.r),
    //                       child: SizedBox(
    //                         width: context.width * .3,
    //                         height: context.height * 0.2,
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(10.r),
    //                           child: BuildImageWithErrorHandler(
    //                             imageType: ImageType.asset,
    //                             path: ImagesPath.bdmChockImagePath,
    //                             boxFit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 DecoratedBox(
    //                   decoration: BoxDecoration(
    //                     color: ColorsManager.mainBlue,
    //                     borderRadius: BorderRadius.circular(10.r),
    //                   ),
    //                   child: Padding(
    //                     padding: EdgeInsets.only(
    //                       top: 10.r,
    //                       bottom: 10.r,
    //                       left: 10.r,
    //                       right: 10.r,
    //                     ),
    //                     child: Text(
    //                       "All Chocks",
    //                       style: MyTextStyles.font32Bold(Theme.of(context)),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             // GestureDetector(
    //             //   onTap: () {
    //             //     context.pushNamed(Routes.allChocksScreen);
    //             //   },
    //             //   child: DecoratedBox(
    //             //     decoration: BoxDecoration(
    //             //       color: ColorsManager.orangeColor,
    //             //       borderRadius: BorderRadius.circular(10),
    //             //     ),
    //             //     child: Padding(
    //             //       padding: EdgeInsets.all(20),
    //             //       child: Text(
    //             //         "Chocks",
    //             //         style: MyTextStyles.font32WhiteBold,
    //             //       ),
    //             //     ),
    //             //   ),
    //             // ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  void onTappedBar(int value) {
    setState(() {
      _bottomNavIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
