import 'package:flutter/material.dart';
import 'package:flutter_application_to_do_list/home_to_do.dart';
import 'package:flutter_application_to_do_list/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body:ToDOHome() 
        
        //SplashScreen()
        ),
      );
  }
}
