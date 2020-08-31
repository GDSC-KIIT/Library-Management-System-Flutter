import 'package:flutter/material.dart';
import 'package:library_system/pages/home.dart';
import 'package:library_system/pages/login.dart';
import 'package:library_system/pages/signup.dart';

void main() {
  runApp(Library());
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context)=>LoginPage(),
        SignUpPage.id: (context)=>SignUpPage(),
        HomePage.id:  (context)=>HomePage(),
      },
    );
  }
}

