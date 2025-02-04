import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rollshop/features/auth/signin/screens/login_screen.dart';
import 'package:rollshop/features/chock_feature/models/chock_type_model.dart';
import 'package:rollshop/features/chock_feature/screens/add_chock_screen.dart';
import 'package:rollshop/features/chock_feature/screens/all_chocks_screen.dart';
import 'package:rollshop/features/main/screen/main_screen.dart';
import 'package:rollshop/features/main/screen/settings_screen.dart';
import 'package:rollshop/features/parts_with_material_number/model/parts_with_material_number_model.dart';
import 'package:rollshop/features/parts_with_material_number/screens/add_parts_with_material_number_screen.dart';
import 'package:rollshop/features/chock_feature/screens/chock_detailes_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/all_parts_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/part_detailes_screen.dart';
import 'routers.dart';

final sl = GetIt.instance;

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreenScreen:
        return MaterialPageRoute(
          builder: (context) => MainScreen(),
        );
      case Routes.allPartsScreen:
        return MaterialPageRoute(
          builder: (context) => AllPartsScreen(),
        );
      case Routes.addNewPart:
        return MaterialPageRoute(
          builder: (context) => AddPartWithMaterialNumberScreen(
            isEdit: false,
          ),
        );
      case Routes.editPartScreen:
        return MaterialPageRoute(builder: (context) {
          return AddPartWithMaterialNumberScreen.edit(
            isEdit: true,
            partModel: settings.arguments as PartsWithMaterialNumberModel,
          );
        });
      case Routes.allChocksScreen:
        return MaterialPageRoute(
          builder: (context) => AllChocksScreen(),
        );
      case Routes.addChockScreen:
        return MaterialPageRoute(
          builder: (context) => AddChockScreen(),
        );
      case Routes.profileScreenRoute:
        return MaterialPageRoute(
          builder: (context) => SettingsScreen(),
        );
      case Routes.signinScreen:
        return MaterialPageRoute(
          builder: (context) => SigninScreen(),
        );
      case Routes.chockDetailesScreen:
        // print(settings.arguments);
        // if (settings.arguments == ChockTypesModel) {
        ChockTypesModel chockData = settings.arguments as ChockTypesModel;
        return MaterialPageRoute(
            builder: (context) => ChockDetailesScreen(
                  chock: chockData,
                ));
      case Routes.partDetailesScreen:
        // print(settings.arguments);
        // if (settings.arguments == ChockTypesModel) {
        PartsWithMaterialNumberModel part =
            settings.arguments as PartsWithMaterialNumberModel;
        return MaterialPageRoute(
            builder: (context) => PartDetailesScreen(
                  part: part,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => AllChocksScreen(),
        );
    }
  }
}
