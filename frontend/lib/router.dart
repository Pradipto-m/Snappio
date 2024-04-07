import 'package:flutter/material.dart';
import 'package:snappio/widgets/navigation.dart';
import 'package:snappio/screens/auth/registration.dart';
import 'package:snappio/screens/auth/signup.dart';
import 'package:snappio/screens/auth/splash.dart';
import 'package:snappio/screens/auth/verification.dart';
import 'package:snappio/widgets/onboarding.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Onboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Onboard());
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen());
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen());
    case OtpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OtpScreen());
    case SignupPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupPage());
    case NavBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const NavBar());
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
          child: Text("This page doesn't exists"),
      )));
  }
}
