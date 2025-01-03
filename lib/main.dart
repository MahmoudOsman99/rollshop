import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rollshop/BlocObserver.dart';
import 'package:rollshop/app.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  di.init();
  runApp(
    RollshopApp(
      appRouter: AppRouter(),
    ),
  );
}
