import 'package:flutter/material.dart';

import '../../features/main/main_screen.dart';
import '../../features/main/screens/drive_or_operator_screen.dart';
import 'routers.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
      case Routes.driveOrOperatorScreen:
        return MaterialPageRoute(
          builder: (context) => const DriveOrOperatorScreen(),
        );

      // case Routes.loginScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const LoginScreen(),
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text(
                'No routes found for this ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
