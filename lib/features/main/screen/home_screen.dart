// import 'dart:io';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/components/widgets/build_image_with_error_handler.dart';
import 'package:rollshop/components/widgets/custom_button.dart';
import 'package:rollshop/core/helpers/extensions.dart';
import 'package:rollshop/core/helpers/images_path.dart';
import 'package:rollshop/core/helpers/print_service.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/colors.dart';
import 'package:rollshop/core/theme/styles.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/chock_feature/screens/all_chocks_screen.dart';
import 'package:rollshop/features/chock_feature/widgets/build_chock_item.dart';
import 'package:rollshop/features/main/components/main_list_items.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/main/cubit/app_state.dart';
import 'package:rollshop/features/main/screen/settings_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _bottomNavIndex = 0;
  // final _pageController = PageController();

  // final _controller = PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    // final locale = Localizations.localeOf(context);

    // if (Platform.isMacOS) {
    //   debugPrint("In macOS");
    // } else if (Platform.isIOS) {
    //   debugPrint("In IOS");
    // }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            spacing: 20.h,
            children: [
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: CircleAvatar(
                  radius: 80.r,
                  backgroundColor: ColorsManager.lightWhite,
                  child: SizedBox(
                      width: 100.w, height: 100.h, child: Icon(Icons.person)),
                ),
              ),
              Text(
                'Mahmoud Osman',
                style: MyTextStyles.font24Weight700(Theme.of(context)),
              ),
              SizedBox(
                width: context.width,
                // height: context.height * 0.5,
                child: GridView.builder(
                  itemCount: 3,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return MainListItem(
                      title: "كل الكراسي",
                      imagePath: ImagesPath.bdmChockImagePath,
                      pathToGo: Routes.allChocksScreen,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );

    // return Scaffold(

    //   //!
    //   body: PageView(
    //     controller: _pageController,
    //     onPageChanged: (value) {
    //       setState(() {
    //         _bottomNavIndex = value;
    //       });
    //     },
    //     children: <Widget>[
    //       AllChocksScreen(),
    //       AllPartsScreen(),
    //       SettingsScreen(),
    //     ],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: _bottomNavIndex,
    //     onTap: onTappedBar,
    //     iconSize: 25.sp,
    //     selectedItemColor:
    //         context.read<AppCubit>().currentThemeMode == ThemeMode.dark
    //             ? ColorsManager.lightBlue
    //             : ColorsManager.orangeColor,
    //     backgroundColor:
    //         context.read<AppCubit>().currentThemeMode == ThemeMode.dark
    //             ? ColorsManager.blackBackGround
    //             : ColorsManager.lightWhite,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //         ),
    //         label: locale.languageCode == 'ar' ? "كل الكراسي" : "All Chocks",
    //         //  "All Chocks",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.list,
    //         ),
    //         label: locale.languageCode == 'ar' ? "كل العناصر" : "All Parts",

    //         // label: "All Parts",
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.settings,
    //         ),
    //         label: locale.languageCode == 'ar' ? "الاعدادات" : "Settings",
    //       ),
    //     ],
    //   ),

    // );
  }

  // void onTappedBar(int value) {
  //   setState(() {
  //     _bottomNavIndex = value;
  //   });
  //   _pageController.jumpToPage(value);
  // }
}
