import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rollshop/BlocObserver.dart';
import 'package:rollshop/app.dart';
import 'package:rollshop/core/helpers/shared_pref_helper.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final bool isShowOnboarding =
      await SharedPreferencesHelper.getBoolValue("onBoarding");

  Bloc.observer = MyBlocObserver();
  di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      RollshopApp(
        appRouter: AppRouter(),
        isShowOnboarding: isShowOnboarding,
      ),
    );
    // runApp(
    //   RollshopApp(
    //   appRouter: AppRouter(),
    // ));
  });
}
  // runApp(
  //   RollshopApp(
  //     appRouter: AppRouter(),
  //   ),
  // );
// }
