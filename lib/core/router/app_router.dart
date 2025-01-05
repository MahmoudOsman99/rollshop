import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/features/assembly_steps_feature/models/chock_type_model.dart';
import 'package:rollshop/features/assembly_steps_feature/screens/add_chock_screen.dart';
import 'package:rollshop/features/parts_with_material_number/screens/add_parts_with_material_number_screen.dart';
import 'package:rollshop/features/assembly_steps_feature/screens/chock_detailes_screen.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_cubit.dart';
import 'package:rollshop/features/assembly_steps_feature/view_model/chock_state.dart';

import '../../features/assembly_steps_feature/screens/all_chocks_screen.dart';
import 'routers.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.allChocksScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                ChockCubit(ChocksInitialState())..loadAllChocks(),
            child: AllChocksScreen(),
          ),
        );
      case Routes.addChockScreen:
        return MaterialPageRoute(
          builder: (context) => AddChockScreen(),
        );
      case Routes.addPartWithMaterialNumberScreen:
        return MaterialPageRoute(
          builder: (context) => AddPartWithMaterialNumberScreen(),
        );
      case Routes.chockDetailesScreen:
        // print(settings.arguments);
        // if (settings.arguments == ChockTypesModel) {
        ChockTypesModel chockData = settings.arguments as ChockTypesModel;
        return MaterialPageRoute(
            builder: (context) => ChockDetailesScreen(
                  chock: chockData,
                ));
      // } else {
      //   return MaterialPageRoute(
      //     builder: (context) => Scaffold(
      //       body: Center(
      //         child: Text(
      //           'No Chock found by this data',
      //           style: MyTextStyles.font32WhiteBold,
      //         ),
      //       ),
      //     ),
      //   );
      // }
      // builder: (context) => ChockDetailesScreen(
      //   chock: ChockTypesModel(
      //     id: "1",
      //     name: "Bottom Operator Side Chock",
      //     imagePath: ImagesPath.bottomDriveSideImagePath,
      //     positionInTheStand: "positionInTheStand",
      //     assemblySteps:
      //         "assemblyStepssccccccccccccccccccccccccccccccccccccccccccccccccccccccfegfbgtbhtrhbtrbbbbbbbbbbbbbbbbbbbbbbbbbb",
      //   ),
      // ),

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
