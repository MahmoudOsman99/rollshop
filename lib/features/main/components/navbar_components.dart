// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:rollshop/core/router/app_router.dart';
// import 'package:rollshop/core/router/routers.dart';
// import 'package:rollshop/core/theme/colors.dart';

// import 'package:rollshop/features/main/cubit/app_cubit.dart';
// import 'package:rollshop/features/main/cubit/app_state.dart';

// List<PersistentBottomNavBarItem> navItems = [
//   PersistentBottomNavBarItem(
//     activeColorPrimary: ColorsManager.redAccent,
//     icon: BlocSelector<AppCubit, AppState, ThemeMode>(
//       selector: (state) {
//         if (state is AppChangeThemeModeState) {
//           return state.themeMode;
//         }
//         return sl<AppCubit>().currentThemeMode;
//       },
//       builder: (context, themeMode) {
//         return Icon(
//           Icons.home,
//           color: themeMode == ThemeMode.dark
//               ? ColorsManager.whiteColor
//               : ColorsManager.darkModeColor,
//         );
//       },
//     ),
//     routeAndNavigatorSettings: RouteAndNavigatorSettings(
//       initialRoute: Routes.addChockScreen,
//       onGenerateRoute: AppRouter().generateRoute,
//     ),
//   ),
//   PersistentBottomNavBarItem(
//     activeColorPrimary: ColorsManager.redAccent,
//     icon: BlocSelector<AppCubit, AppState, ThemeMode>(
//       selector: (state) {
//         if (state is AppChangeThemeModeState) {
//           return state.themeMode;
//         }
//         return sl<AppCubit>().currentThemeMode;
//       },
//       builder: (context, state) {
//         return Icon(
//           Icons.list,
//           color: state == ThemeMode.dark
//               ? ColorsManager.whiteColor
//               : ColorsManager.darkModeColor,
//         );
//       },

//       //  Icon(
//       //   Icons.list,
//       //   color: sl<AppCubit>().currentThemeMode == ThemeMode.dark
//       //       ? ColorsManager.whiteColor
//       //       : ColorsManager.darkModeColor,
//     ),
//     routeAndNavigatorSettings: RouteAndNavigatorSettings(
//       initialRoute: Routes.addPartWithMaterialNumberScreen,
//       onGenerateRoute: AppRouter().generateRoute,
//     ),
//   ),
//   PersistentBottomNavBarItem(
//     activeColorPrimary: ColorsManager.redAccent,
//     // inactiveColorPrimary: ColorsManager.orangeColor,
//     icon: BlocSelector<AppCubit, AppState, ThemeMode>(
//       selector: (state) {
//         if (state is AppChangeThemeModeState) {
//           return state.themeMode;
//         }
//         return sl<AppCubit>().currentThemeMode;
//       },
//       builder: (context, state) {
//         return Icon(
//           Icons.settings,
//           color: state == ThemeMode.dark
//               ? ColorsManager.whiteColor
//               : ColorsManager.darkModeColor,
//           // color: sl<AppCubit>().currentThemeMode == ThemeMode.dark
//           //     ? ColorsManager.whiteColor
//           //     : ColorsManager.darkModeColor,
//         );
//       },
//     ),
//     routeAndNavigatorSettings: RouteAndNavigatorSettings(
//       initialRoute: Routes.profileScreenRoute,
//       onGenerateRoute: AppRouter().generateRoute,
//     ),
//   ),
// ];
