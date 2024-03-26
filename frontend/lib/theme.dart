import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightMode(BuildContext context) => ThemeData().copyWith(
    scaffoldBackgroundColor: lightBg,
    appBarTheme: ThemeData().appBarTheme.copyWith(
      color: lightAccent,
      iconTheme: const IconThemeData(color: darkBg),
      titleTextStyle: const TextStyle(
        color: darkBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      )
    ),
    primaryIconTheme: ThemeData().iconTheme.copyWith(
      color: darkBg
    ),
    iconTheme: const IconThemeData().copyWith(
      color: const Color.fromRGBO(0, 0, 0, 0.55),
    ),
    navigationBarTheme: const NavigationBarThemeData().copyWith(
      backgroundColor: lightAccent,
      elevation: 0,
      height: 75,
      indicatorColor: const Color.fromRGBO(255, 255, 255, 0.25),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: const TextStyle(
        color: darkBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 34.0
      ),
      labelLarge: const TextStyle(
        color: darkBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      ),
      bodySmall: const TextStyle(
        fontFamily: "Nunito",
        color: darkBg,
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      ),
      displaySmall: const TextStyle(
        color: lightBg,
        fontFamily: "Nunito",
        fontSize: 15.0
      )
    ),
    canvasColor: lightBg,
    cardColor: lightAccent,
  );

  static ThemeData darkMode(BuildContext context) => ThemeData().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    appBarTheme: ThemeData().appBarTheme.copyWith(
      color: darkAccent,
      iconTheme: const IconThemeData(color: lightBg),
      titleTextStyle: const TextStyle(
        color: lightBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      )
    ),
    primaryIconTheme: ThemeData().iconTheme.copyWith(
      color: lightBg,
    ),
    iconTheme: const IconThemeData().copyWith(
      color: const Color.fromRGBO(255, 255, 255, 0.55),
    ),
    navigationBarTheme: const NavigationBarThemeData().copyWith(
      backgroundColor: darkAccent,
      elevation: 0,
      height: 75,
      indicatorColor: const Color.fromRGBO(0, 0, 0, 0.1),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: const TextStyle(
        color: lightBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 34.0
      ),
      labelLarge: const TextStyle(
        color: lightBg,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      ),
      bodySmall: const TextStyle(
        fontFamily: "Nunito",
        color: lightBg,
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      ),
      displaySmall: const TextStyle(
        color: darkBg,
        fontFamily: "Nunito",
        fontSize: 15.0
      )
    ),
    canvasColor: darkBg,
    cardColor: darkAccent,
  );

  // colors
  static const Color lightBg = Color(0xffd7e1f5);
  static const Color lightAccent = Color(0xff2ccea5);
  static const Color darkBg = Color(0xff0f0f2a);
  static const Color darkAccent = Color(0xff7563f6);
}
