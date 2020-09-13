import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:library_system/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF584846),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    hintText: '\tEnter Email-id',
                  ),
                ),
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF584846),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF584846)),
                    ),
                    hintText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      color: Color(0xFF584846),
                      onPressed: () async {
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (user != null)
                            Navigator.pushNamed(context, HomePage.id);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child:
                          Text('LOGIN', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      color: Color(0xFF584846),
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                        print('push');
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
