import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/theme.dart';
import 'package:rollshop/features/chock_feature/screens/all_chocks_screen.dart';
import 'package:rollshop/features/chock_feature/cubit/chock_cubit.dart';
import 'package:rollshop/features/main/cubit/app_cubit.dart';
import 'package:rollshop/features/main/cubit/app_state.dart';
import 'package:rollshop/features/parts_with_material_number/view_model/cubit/parts_cubit.dart';

class RollshopApp extends StatelessWidget {
  final AppRouter appRouter;

  const RollshopApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (context) => sl<AppCubit>()..loadTheme(),
          // create: (context) => sl<AppCubit>(),
        ),
        BlocProvider<ChockCubit>(
          create: (context) => sl<ChockCubit>(),
        ),
        BlocProvider<PartsCubit>(
          create: (context) => sl<PartsCubit>(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          ThemeMode currentTheme = ThemeMode.system; // Default
          if (state is AppChangeThemeModeState) {
            currentTheme = state.themeMode;
          }
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              onGenerateRoute: appRouter.generateRoute,
              initialRoute: Routes.mainScreenScreen,
              debugShowCheckedModeBanner: false,
              // home: AllChocksScreen(),
              // theme: AppTheme.darkTheme,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: currentTheme,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ar'), // Arabic
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                // if (supportedLocales != null) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                  // }
                }
                return supportedLocales.first;
              },
              locale: const Locale('ar'),
            ),
          );
        },
      ),
    );
  }
}
