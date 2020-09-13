import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:library_system/pages/login.dart';
import 'package:library_system/pages/signup.dart';
import 'package:library_system/pages/splashScreen.dart';

void main() {
  runApp(Library());
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: SplashScreen(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
