import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignupPage extends StatefulWidget {
  static String id = 'login_page';
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  RegExp regExp = RegExp(
      r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.)*[a-zA-Z0-9][a-zA-Z0-9-]{0,253}\.[a-zA-Z0-9]{2,}$");
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String emailError = "";
  String passwordError = "";
  String loginSignUpError = "";
  bool busy = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset('assets/images/library.png'),
                  SizedBox(height: 40),
                  (loginSignUpError == "")
                      ? SizedBox(height: 0)
                      : Center(child: Text(loginSignUpError)),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        if (value.length <= 0) {
                          setState(() {
                            emailError = "Enter Email";
                          });
                        } else if (!regExp.hasMatch(value)) {
                          setState(() {
                            emailError = "Invalid Email";
                          });
                        } else {
                          setState(() {
                            emailError = "";
                            email = value;
                          });
                        }
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
                        errorText: emailError != "" ? emailError : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      onChanged: (value) {
                        if (value.length < 6) {
                          setState(() {
                            passwordError = "Too Short";
                          });
                        } else {
                          setState(() {
                            passwordError = "";
                            password = value;
                          });
                        }
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
                        errorText: passwordError == "" ? null : passwordError,
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
                          onPressed: (emailError==""&&passwordError=="") ?() async {
                            setState(() {
                              busy = true;
                            });
                            await _auth
                                .signInWithEmailAndPassword(
                                    email: email, password: password)
                                .catchError((e) {
                              setState(() {
                                busy = false;
                              });
                              if (e.code == "invalid-email") {
                                setState(() {
                                  loginSignUpError = "Invalid Email";
                                });
                              } else if (e.code == "user-disabled") {
                                setState(() {
                                  loginSignUpError = "Account Disabled";
                                });
                              } else if (e.code == "user-not-found") {
                                setState(() {
                                  loginSignUpError = "User Not Registered";
                                });
                              } else if (e.code == "wrong-password") {
                                setState(() {
                                  loginSignUpError = "Wrong Password Entered";
                                });
                              } else {
                                setState(() {
                                  loginSignUpError = e.toString();
                                });
                              }
                            }).then((temp) {
                              if (temp != null) {
                                if (temp.user != null) {
                                  setState(() {
                                    loginSignUpError = "";
                                  });
                                  Navigator.pushReplacementNamed(context, HomePage.id);
                                }
                              }
                            });
                          }:null,
                          child: Text('LOGIN',
                              style: TextStyle(color: Colors.white)),
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
                          onPressed:  (emailError==""&&passwordError=="") ?(){
                            setState(() {
                              busy = true;
                            });
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .catchError((e) {
                              setState(() {
                                busy = false;
                              });
                              if (e.code == "invalid-email") {
                                setState(() {
                                  loginSignUpError = "Invalid Email";
                                });
                              } else if (e.code == "email-already-in-use") {
                                setState(() {
                                  loginSignUpError =
                                      "Account Already Exists , please login";
                                });
                              } else if (e.code == "weak-password") {
                                setState(() {
                                  loginSignUpError = "User Not Registered";
                                });
                              } else if (e.code == "operation-not-allowed") {
                                setState(() {
                                  loginSignUpError =
                                      "Signups are temporarily disabled";
                                });
                              } else {
                                setState(() {
                                  loginSignUpError = e.toString();
                                });
                              }
                            }).then((value) {
                              if (value != null) {
                                if (value.user != null) {
                                  setState(() {
                                    loginSignUpError = "";
                                  });
                                  Navigator.pushReplacementNamed(context, HomePage.id);
                                }
                              }
                            });
                            print('push');
                          }:null,
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
            busy
                ? Container(
                    color: Colors.white54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SizedBox(height: 0)
          ],
        ),
      ),
    );
  }
}
