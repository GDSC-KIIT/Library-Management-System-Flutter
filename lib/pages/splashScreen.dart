import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:library_system/pages/loginSignupPage.dart';

class UIConstants {
  static const double ASSUMED_SCREEN_HEIGHT = 640.0;
  static const double ASSUMED_SCREEN_WIDTH = 360.0;

  static _fitContext(BuildContext context, assumedValue, currentValue, value) =>
      (value / assumedValue) * currentValue;

  static fitToWidth(value, BuildContext context) => _fitContext(
      context, ASSUMED_SCREEN_WIDTH, MediaQuery.of(context).size.width, value);

  static fitToHeight(value, BuildContext context) => _fitContext(context,
      ASSUMED_SCREEN_HEIGHT, MediaQuery.of(context).size.height, value);

  static const splashScreenLogo = 'assets/images/logo.png';
}

class SplashScreen extends StatefulWidget {
  static String id = 'splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigate);
  }

  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.id, ModalRoute.withName('/'));
    } else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginSignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0B485),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/splashbg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 180,
                  ),
                  Container(
                    height: 220,
                    width: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(UIConstants.splashScreenLogo),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LIBRARY',
                        style: TextStyle(
                          color: Color(0xFFDD3617),
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'MANAGED',
                        style: TextStyle(
                          color: Color(0xFF584846),
                          fontSize: 28,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
