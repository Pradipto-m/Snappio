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
    iconTheme: const IconThemeData().copyWith(
      color: darkBg,
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
      bodyMedium: const TextStyle(
        fontFamily: "Nunito",
        color: darkBg,
        fontWeight: FontWeight.bold,
        fontSize: 18.4,
      ),
      bodySmall: const TextStyle(
        fontFamily: "Nunito",
        color: darkBg,
        fontSize: 16.7,
      ),
      displaySmall: const TextStyle(
        color: darkBg,
        fontFamily: "Nunito",
        fontSize: 16.0,
      )
    ),
    cardTheme: ThemeData().cardTheme.copyWith(
      color: lightBg,
      elevation: 0,
    ),
    canvasColor: lightBg,
    cardColor: lightAccent,
    highlightColor: darkBg,
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
    iconTheme: ThemeData().iconTheme.copyWith(
      color: lightContrast,
    ),
    textTheme: ThemeData().textTheme.copyWith(
      titleLarge: const TextStyle(
        color: lightContrast,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 34.0
      ),
      labelLarge: const TextStyle(
        color: lightContrast,
        fontFamily: "Nunito",
        fontWeight: FontWeight.bold,
        fontSize: 24.0
      ),
      bodyMedium: const TextStyle(
        fontFamily: "Nunito",
        color: lightContrast,
        fontWeight: FontWeight.bold,
        fontSize: 18.4,
      ),
      bodySmall: const TextStyle(
        fontFamily: "Nunito",
        color: lightContrast,
        fontSize: 16.7,
      ),
      displaySmall: const TextStyle(
        color: lightBg,
        fontFamily: "Nunito",
        fontSize: 16.0,
      )
    ),
    cardTheme: ThemeData().cardTheme.copyWith(
      color: darkBg,
      elevation: 0,
    ),
    canvasColor: darkBg,
    cardColor: darkAccent,
    highlightColor: lightContrast,
  );

  // colors
  static const Color lightBg = Color(0xffd1e1f5);
  static const Color lightAccent = Color(0xff2ccea5);
  static const Color darkBg = Color(0xff0f0f2a);
  static const Color darkAccent = Color(0xff7563f6);
  static const Color lightContrast = Color.fromARGB(255, 231, 238, 255);
}
