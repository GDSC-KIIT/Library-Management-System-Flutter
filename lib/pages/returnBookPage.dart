import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_system/models/Book_model.dart';
import 'package:flutter/material.dart';

class ReturnBookPage extends StatefulWidget {
  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  void _onScanned() async {
    // ignore: non_constant_identifier_names
    final FirestoreInstance = Firestore.instance;
    FirestoreInstance.collection("books")
        .document(reResult)
        .updateData({"status": "IN"}).then((_) {
      showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("Book Returned",
              style: TextStyle(color: Colors.greenAccent[500]),
              textAlign: TextAlign.center),
          children: <Widget>[
            /*Container(
              height: 100,
              width: 200,
            ),*/
            SizedBox(
              height: 5,
            ),
            Image.asset(
              "assets/images/done.png",
              width: 200,
              height: 100,
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(children: <Widget>[
                Container(
                  child: Text("RETURN A BOOK",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF584846),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      "assets/images/Group 2.png",
                      width: 200,
                      height: 100,
                    ),
                  ]),
                ),
              ]),
            ),
            SizedBox(
              height: 45,
            ),
            Flexible(
              flex: 0,
              child: Center(
                child: Form(
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: reResult,
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: Colors.grey[200],
                              hintText: " U-ID ",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 245,
                        child: FlatButton(
                          color: Color(0xFF584846),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          child: Text("RETURN",
                              style: TextStyle(
                                  color: Color(0xFFF3BB84), fontSize: 15)),
                          onPressed: () async {
                            _onScanned();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
