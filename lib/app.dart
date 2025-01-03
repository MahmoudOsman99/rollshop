import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/core/theme/theme.dart';
import 'package:rollshop/features/assembly_steps_feature/screens/all_chocks_screen.dart';

class RollshopApp extends StatelessWidget {
  final AppRouter appRouter;

  const RollshopApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: MaterialApp(
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.allChocksScreen,
        debugShowCheckedModeBanner: false,
        // home: AllChocksScreen(),
        theme: AppTheme.darkTheme,
      ),
    );
  }
}
