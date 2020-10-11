import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:library_system/models/Book_model.dart';
import 'package:barcode/barcode.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';

class AddNewBookPage extends StatefulWidget {
  AddNewBookPage({this.isbn});
  final String isbn;
  @override
  _AddNewBookPageState createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends State<AddNewBookPage> {
  List<Books> books = List();
  Books book;

  DatabaseReference itemRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    book = Books();
    book.isbn = widget.isbn;
    book.status = "IN";
  }

  void _handleSubmit() {
    final FormState form = formKey.currentState;
    // ignore: non_constant_identifier_names
    final firestoreInstance = FirebaseFirestore.instance;
    if (form.validate()) {
      form.save();
      form.reset();
      firestoreInstance.collection("books").add(book.toJson()).then(
        (value) {
          print(value.id);
          setState(() {
            code = bc.toSvg(
              value.id,
            );
          });
          showDialog(
            context: context,
            child: new SimpleDialog(
              title: new Text("Book Added"),
              children: <Widget>[
                Container(
                  height: 100,
                  width: 200,
                  child: SvgPicture.string(
                    code,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 25,
                )
              ],
            ),
          );
        },
      );
    }
  }

  /*Future _scanQR() async {
      try {
        String qrResult = await BarcodeScanner.scan();
        setState(() {
          result = qrResult;

        });
      } on PlatformException catch (ex) {
        if (ex.code == BarcodeScanner.CameraAccessDenied) {
          setState(() {
            result = "Camera permission was denied";
          });
        } else {
          setState(() {
            result = "Unknown Error $ex";
          });
        }
      } on FormatException {
        setState(() {
          result = "You pressed the back button before scanning anything";
        });
      } catch (ex) {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    }*/

  Barcode bc = Barcode.code128();
  String code;

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
                  padding: EdgeInsets.only(right: 190),
                  child: Text("ADD A NEW BOOK ",
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
                      "assets/images/books123.png",
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
                  key: formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: result,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter ISBN",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onSaved: (val) => book.isbn = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: "",
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter Title of the book",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onSaved: (val) => book.name = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter Author Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onSaved: (val) => book.author = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter Publisher Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                            ),
                            onSaved: (val) => book.publisher = val,
                            validator: (val) => val == "" ? val : null,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          height: 65,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: TextFormField(
                            initialValue: '',
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "Enter Genre",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: const BorderSide(),
                              ),
                            ),
                            onSaved: (val) => book.genre = val,
                            validator: (val) => val == "" ? val : null,
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
                          child: Text("ADD",
                              style: TextStyle(
                                  color: Color(0xFFF3BB84), fontSize: 15)),
                          onPressed: () async {
                            _handleSubmit();
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
