// this file for GoRouter app routes
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rollshop/core/router/routers.dart';
import 'package:rollshop/features/auth/cubit/auth_cubit.dart';
import 'package:rollshop/features/auth/screens/login_screen.dart';
import 'package:rollshop/features/auth/screens/register_screen.dart';
import 'package:rollshop/features/main/screen/home_screen.dart';

import '../../injection_container.dart';


class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: Routes.homeScreen,
    redirect: (context, state) {
      // Implement your redirect logic here if needed
      // check if the user is going to a login route and is already authenticated
      // bool isLoggedIn = sl<AuthCubit>().authRepo.; 
      // if (isLoggedIn && state.matchedLocation == Routes.loginScreen) {
      //   return Routes.homeScreen;
      // } 

      return null;
    },
    routes: [
      // Define your app routes here
      GoRoute(
        path: Routes.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: Routes.registerScreen,
        builder: (context, state) => RegisterScreen(),
      ),
    ],
  );
}