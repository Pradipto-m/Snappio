import 'package:flutter/material.dart';

// class Themes {
//   static ThemeData lightMode(BuildContext context) => ThemeData(
//     colorScheme: const ColorScheme(
//       brightness: Brightness.light,
//       primary: Colors.indigo,
//       onPrimary: Colors.red,
//       secondary: Colors.red,
//       onSecondary: Colors.red,
//       error: Colors.red,
//       onError: Colors.white,
//       background: Colors.cyan,
//       onBackground: Colors.cyanAccent,
//       surface: Colors.black,
//       onSurface: darkBg,
//       outline: darkBg,
//     ),
//     primarySwatch: Colors.indigo,
//     fontFamily: "Nunito",
//     textTheme: Theme.of(context).textTheme.apply(
//       bodyColor: darkBg,
//       displayColor: darkBg,
//       fontFamily: "Nunito"
//     ),
//     canvasColor: lightBg,
//     cardColor: lightAccent,
//     primaryColor: Colors.indigoAccent,
//     splashColor: darkBg,
//     appBarTheme: const AppBarTheme(
//       color: lightAccent,
//       iconTheme: IconThemeData(color: darkBg),
//       titleTextStyle: TextStyle(
//         color: darkBg,
//         fontFamily: "Nunito",
//         fontWeight: FontWeight.bold,
//         fontSize: 21.0
//       )
//     )
//   );

//   static ThemeData darkMode(BuildContext context) => ThemeData(
//       primarySwatch: Colors.deepPurple,
//       colorScheme: const ColorScheme.dark(
//         primary: darkAccent,
//         secondary: lightAccent,
//         surface: darkBg,
//         background: darkBg,
//         onPrimary: lightBg,
//         onSecondary: lightBg,
//         onSurface: lightBg,
//         onBackground: lightBg
//       ),
//       brightness: Brightness.dark,
//       fontFamily: "Nunito",
//       textTheme: Theme.of(context).textTheme.apply(
//         bodyColor: lightBg,
//         displayColor: lightBg,
//         fontFamily: "Nunito"
//       ),
//       canvasColor: darkBg,
//       cardColor: darkAccent,
//       primaryColor: Colors.white60,
//       splashColor: lightBg,
//       appBarTheme: const AppBarTheme(
//         color: darkAccent,
//         iconTheme: IconThemeData(color: lightBg),
//         titleTextStyle: TextStyle(
//           fontFamily: "Nunito",
//           fontWeight: FontWeight.bold,
//           fontSize: 21.0
//         )
//       )
//   );

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
        color: lightBg,
        fontFamily: "Nunito",
        fontSize: 15.0
      ),
      displaySmall: const TextStyle(
        fontFamily: "Nunito",
        color: darkBg,
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      )
    ),
    cardColor: lightAccent,
  );

  static ThemeData darkMode(BuildContext context) => ThemeData().copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(brightness: Brightness.dark, primary: lightBg, onPrimary: lightBg, secondary: lightBg, onSecondary: lightBg, error: lightBg, onError: lightBg, background: lightBg, onBackground: lightBg, surface: lightBg, onSurface: lightBg),
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
        color: darkBg,
        fontFamily: "Nunito",
        fontSize: 15.0
      ),
      displaySmall: const TextStyle(
        fontFamily: "Nunito",
        color: lightBg,
        fontWeight: FontWeight.bold,
        fontSize: 18.0
      )
    ),
    cardColor: darkAccent,
  );

  // colors
  static const Color lightBg = Color(0xffd7e1f5);
  static const Color lightAccent = Color(0xff2ccea5);
  static const Color darkBg = Color(0xff0f0f2a);
  static const Color darkAccent = Color(0xff7563f6);
}
