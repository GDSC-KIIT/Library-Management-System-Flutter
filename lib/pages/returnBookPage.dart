import 'package:flutter/material.dart';

class ReturnBookPage extends StatefulWidget {
  ReturnBookPage({Key key}) : super(key: key);

  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Return Book Page"),
          ),
        ),
      ),
    );
  }
}
