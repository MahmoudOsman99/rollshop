import 'package:flutter/material.dart';
import 'package:rollshop/app.dart';
import 'package:rollshop/core/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    RollshopApp(
      appRouter: AppRouter(),
    ),
  );
}
