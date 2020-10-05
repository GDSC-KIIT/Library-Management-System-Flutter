import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:library_system/pages/login.dart';
import 'package:library_system/pages/signup.dart';
import 'package:library_system/pages/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Library());
}

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}

