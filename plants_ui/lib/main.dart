import 'package:flutter/material.dart';
import 'package:plants_ui/login_screen/launchingscreen.dart';
import 'package:plants_ui/login_screen/loginscreen.dart';
import 'package:plants_ui/mainapp/homescreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchScreen(),
        // '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
