import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Profile Page"),
            ),
          ),
        ),
      ),
    );
  }
}
