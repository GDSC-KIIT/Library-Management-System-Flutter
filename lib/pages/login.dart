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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.only(left:8.0,right: 8.0),
          child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
            //    SizedBox(height: 80),
                Image(image: NetworkImage(
                  //  'https://www.netclipart.com/pp/m/79-791996_icons-and-graphics-stack-of-books-transparent.png'
                'https://i.dlpng.com/static/png/4262526-cartoon-teachers-day-calendar-is-a-commercial-element-calendar-teacher-calendar-png-640_640_preview.webp'
                ),
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
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  hintText: '\tEmail',
                  icon: Icon(Icons.email,color: Colors.brown),
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
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown),
                  ),
                  hintText: 'Password',
                  icon: Icon(Icons.lock, color: Colors.brown),
                ),
                obscureText: true,//replaces password with bullets as we enter it
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    padding: EdgeInsets.only(left: 50,right: 50),
                    shape: StadiumBorder(),
                    color: Color(0xFF8AC7C0),
                    onPressed: () async{
                      try{
                        final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user!=null)
                          Navigator.pushNamed(context, HomePage.id);
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text('LOGIN',
                    ),
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
                    shape: StadiumBorder(),
                    color: Color(0xFF8AC7C0),
                    onPressed: (){
                      Navigator.pushNamed(context, SignUpPage.id);
                      print('push');
                    },
                    child: Text('SIGN UP',
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