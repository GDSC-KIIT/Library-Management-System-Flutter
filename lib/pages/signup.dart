import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'signup_page';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset('assets/images/library.png'),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  // controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF584846),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF584846)),
                    ),
                    hintText: '\tEnter Email-id',
                  ),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    password = value;
                  },
                  //  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF584846),
                    ),
                    hoverColor: Colors.brown,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    hintText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      color: Color(0xFF584846),
                      onPressed: () async {
                        try {
                          final newuser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newuser != null)
                            Navigator.pushReplacementNamed(
                                context, HomePage.id);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
