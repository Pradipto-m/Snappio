import 'package:flutter/material.dart';
import 'package:snappio/screens/home.dart';
import 'package:snappio/screens/registration.dart';
import 'package:snappio/screens/signup.dart';
import 'package:snappio/screens/verification.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case SplashScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SplashScreen());
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen());
    case OtpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpScreen(),
      );
    case SignupPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupPage());
    case HomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomePage());
    // case BottomNavBar.routeName:
    //   return MaterialPageRoute(
    //       settings: routeSettings, builder: (_) => const BottomNavBar());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
          child: Text("This page doesn't exists"),
      )));
  }
}
