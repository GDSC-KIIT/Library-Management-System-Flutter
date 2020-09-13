import 'package:flutter/material.dart';

class AddNewBookPage extends StatefulWidget {
  AddNewBookPage({Key key}) : super(key: key);

  @override
  _AddNewBookPageState createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends State<AddNewBookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Data Page"),
          ),
        ),
      ),
    );
  }
}
