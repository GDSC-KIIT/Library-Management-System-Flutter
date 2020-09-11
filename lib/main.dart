import 'package:flutter/material.dart';
import 'package:library_system/pages/home.dart';
import 'package:library_system/pages/login.dart';
import 'package:library_system/pages/signup.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(Library());
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 2,
        backgroundColor: Color(0xFFF4D0AB),
        loaderColor: Colors.white,
        image: Image.asset('assets/images/book.png'),
        photoSize: 150.0,
        navigateAfterSeconds: LoginPage(),
      ),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
