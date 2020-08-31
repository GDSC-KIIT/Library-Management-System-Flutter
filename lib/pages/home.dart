import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id='homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library'),
      ),
      body: Container(
        color: Colors.green,
      )
    );
  }
}
