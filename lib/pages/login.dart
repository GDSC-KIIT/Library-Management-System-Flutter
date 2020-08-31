import 'package:flutter/material.dart';
import 'package:library_system/pages/home.dart';
import 'package:library_system/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String id= 'login_page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth=FirebaseAuth.instance;
  String email;
  String password;
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();

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
                controller: _emailController,
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
                onChanged: (value){
                  password=value;
                },
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,//replaces password with bullets as we enter it
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xFF8AC7C0),//for continuing
                    onPressed: () async{
                      try{
                        final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user!=null)
                          Navigator.pushNamed(context, HomePage.id);
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text('LOGIN'),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: <Widget>[
                  Text('Don\'t have an account?'),
                  RaisedButton(
                    color: Color(0xFF8AC7C0),
                    onPressed: (){
                      Navigator.pushNamed(context, SignUpPage.id);
                      print('push');
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