import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snappio/router.dart';
import 'package:snappio/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightMode(context),
      darkTheme: Themes.darkMode(context),
      title: "Snappio",
      onGenerateRoute: (settings) => generateRoute(settings),
      initialRoute: '/auth',
    );
  }
}
