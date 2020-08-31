import 'package:flutter/material.dart';
import 'package:library_system/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  static String id='signup_page';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 80),
            Column(
              children: <Widget>[
                Image(image: NetworkImage('https://www.netclipart.com/pp/m/79-791996_icons-and-graphics-stack-of-books-transparent.png'),
                ),
                SizedBox(height:16),
                Text('Library Management System',
                  style: TextStyle(
                    fontSize: 20,
                  ),),
              ],
            ),
            SizedBox(height:60),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: TextField(
                onChanged: (value){
                  email=value;
                },
                // controller: _usernameController,
                decoration: InputDecoration(
                  hintText: '\tEmail',
                  icon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left:10,right:10),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  password=value;
                },
                //  controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,//replaces password with bullets as we enter it
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: <Widget>[
                  Text('Continue for a seamless experience!'),
                  RaisedButton(
                    color: Color(0xFF8AC7C0),
                     onPressed: () async{
                      try{
                        final newuser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newuser!=null)
                          Navigator.pushNamed(context, HomePage.id);
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text('SIGN UP'),
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
