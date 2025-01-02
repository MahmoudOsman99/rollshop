import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rollshop/app.dart';
import 'package:rollshop/core/router/app_router.dart';
import 'package:rollshop/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    RollshopApp(
      appRouter: AppRouter(),
    ),
  );
}
