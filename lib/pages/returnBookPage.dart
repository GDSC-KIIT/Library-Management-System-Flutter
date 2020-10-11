import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_system/models/Book_model.dart';
import 'package:flutter/material.dart';
import 'package:library_system/pages/homePage.dart';

class ReturnBookPage extends StatefulWidget {
  @override
  _ReturnBookPageState createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  void _onScanned(BuildContext context) async {
    print(reResult);
    // ignore: non_constant_identifier_names
    final firestoreInstance = FirebaseFirestore.instance;
    final temp =
        await firestoreInstance.collection("books").doc(reResult.trim()).get();
    if (!temp.exists) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Book doesnt Exists ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    } else if (temp.data()["status"] != "OUT") {
      print("reached");
      Navigator.of(context).pop();
      Fluttertoast.showToast(
          msg: "Book isnt issued so cant be returned ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    } else {
      final tempquery = await FirebaseFirestore.instance
          .collection("log")
          .where("bookuid", isEqualTo: reResult.trim())
          .orderBy("date", descending: true)
          .limit(1)
          .get();
      firestoreInstance
          .collection("log")
          .doc(tempquery.docs[0].id)
          .update({"returned": DateTime.now()});
      firestoreInstance
          .collection("books")
          .doc(reResult.trim())
          .update({"status": " IN"}).then((_) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: new Text("Book Returned",
                    style: TextStyle(color: Colors.greenAccent[500]),
                    textAlign: TextAlign.center),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, HomePage.id, (route) => false);
                    },
                    child: Text("Ok"),
                  )
                ],
              );
            });
      });
    }
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
                            _onScanned(context);
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
