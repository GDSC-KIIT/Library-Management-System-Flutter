import 'package:flutter/material.dart';

class IssueBookPage extends StatefulWidget {
  IssueBookPage({Key key}) : super(key: key);

  @override
  _IssueBookPageState createState() => _IssueBookPageState();
}

class _IssueBookPageState extends State<IssueBookPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Issue Book Page"),
            ),
          ),
        ),
      ),
    );
  }
}
