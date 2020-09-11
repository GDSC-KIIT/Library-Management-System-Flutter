import 'dart:async';
import 'package:flutter/material.dart';
import 'package:library_system/pages/login.dart';

class UIConstants {
  static const double ASSUMED_SCREEN_HEIGHT = 640.0;
  static const double ASSUMED_SCREEN_WIDTH = 360.0;

  static _fitContext(BuildContext context, assumedValue, currentValue, value) =>
      (value / assumedValue) * currentValue;

  static fitToWidth(value, BuildContext context) => _fitContext(
      context, ASSUMED_SCREEN_WIDTH, MediaQuery.of(context).size.width, value);

  static fitToHeight(value, BuildContext context) => _fitContext(context,
      ASSUMED_SCREEN_HEIGHT, MediaQuery.of(context).size.height, value);

  static const splashScreenLogo = 'assets/images/book.png';
}

class SplashScreen extends StatefulWidget {
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0B485),
      body: Center(
        child: Container(
          height: UIConstants.fitToHeight(250, context),
          width: UIConstants.fitToWidth(250, context),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(UIConstants.splashScreenLogo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
