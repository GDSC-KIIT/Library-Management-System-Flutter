import 'dart:io';
import 'dart:typed_data';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_system/pages/homePage.dart';
import 'package:mailer2/mailer.dart';
import 'package:path_provider/path_provider.dart';
import '../details.dart';
import '../invoice.dart';

//wrote by amanv8060
class DummyIssueBook extends StatefulWidget {
  const DummyIssueBook({Key key}) : super(key: key);

  @override
  _DummyIssueBookState createState() => _DummyIssueBookState();
}

class _DummyIssueBookState extends State<DummyIssueBook> {
  Future<String> _scanBarcode() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      return qrResult;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        throw Exception("Camera permission was denied");
      } else {
        throw Exception("Unknown Error $e occurred");
      }
    } on FormatException {
      throw Exception("You pressed the back button before scanning anything");
    } catch (ex) {
      throw Exception("Unknown Error $ex occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _scanBarcode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              Fluttertoast.showToast(
                  msg: snapshot.error.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              
              return HomePage();
            }
            if (snapshot.hasData) {
              
              return IssueBookPage(
                barcode: snapshot.data,
              );
            }
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class IssueBookPage extends StatefulWidget {
  final String barcode;

  const IssueBookPage({Key key, this.barcode}) : super(key: key);
  @override
  _IssueBookPageState createState() => _IssueBookPageState();
}

class _IssueBookPageState extends State<IssueBookPage> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference log = FirebaseFirestore.instance.collection("log");
  CollectionReference books = FirebaseFirestore.instance.collection("books");

  DateTime issueDate;
  DateTime dueDate;

  int invoiceno; //Used to set invoice Number in pdf
  int currentIndex; //Defines Current Index of visibility
  String dir; //Stores Directory
  String path;

  final smtpServer = GmailSmtpOptions()
    ..username = username
    ..password = password;
  var emailTransport;
  TextEditingController issuerEmail = TextEditingController();
  TextEditingController issuerPhone = TextEditingController();
  TextEditingController issuerName = TextEditingController();
  @override
  void initState() {
    super.initState();
    init();
    currentIndex = 0;
    emailTransport = new SmtpTransport(smtpServer);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Issue Book Page",
            ), //Not Meant to be visible
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: books.doc(widget.barcode).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                      child: Center(child: Text(snapshot.error.toString())));
                }
                if (snapshot.hasData) {
                  if (!snapshot.data.exists) {
                    Fluttertoast.showToast(
                        msg: "Book Doesn't exist",
                        gravity: ToastGravity.CENTER,
                        toastLength: Toast.LENGTH_SHORT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    return HomePage();
                  } else {
                    return IndexedStack(
                      index: currentIndex,
                      children: [
                        Container(
                            child: Form(
                          key: _formKey,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/books123.png",
                                    width: 200,
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    color: Colors.grey,
                                    child: ListTile(
                                      title: TextFormField(
                                        decoration: InputDecoration.collapsed(
                                            hintText: ""),
                                        initialValue: widget.barcode,
                                        enabled: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: DateTimeFormField(
                                  onlyDate: true,
                                  initialValue: issueDate ?? DateTime.now(),
                                  label: "Issue Date",
                                  validator: (DateTime dateTime) {
                                    if (dateTime == null) {
                                      return "Issue Date Required";
                                    }
                                    return null;
                                  },
                                  firstDate: DateTime.now()
                                      .subtract(Duration(days: 3)),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 15)),
                                  onSaved: (DateTime dateTime) {
                                    setState(() {
                                      this.issueDate = dateTime;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: DateTimeFormField(
                                  onlyDate: true,
                                  initialValue: dueDate ??
                                      DateTime.now().add(Duration(days: 15)),
                                  label: "Due Date",
                                  validator: (DateTime dateTime) {
                                    if (dateTime == null) {
                                      return "Due Date Required";
                                    }
                                    return null;
                                  },
                                  firstDate: DateTime.now(),
                                  lastDate:
                                      DateTime.now().add(Duration(days: 45)),
                                  onSaved: (DateTime dateTime) {
                                    setState(() {
                                      this.dueDate = dateTime;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextFormField(
                                  // onChanged: (value) {},
                                  validator: (value) => validateEmail(value),
                                  controller: issuerEmail,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xFF584846),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF584846)),
                                    ),
                                    hintText: '\tEnter Email-id',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextFormField(
                                  // onChanged: (value) {},
                                  validator: (value) => validateMobile(value),
                                  controller: issuerPhone,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Color(0xFF584846),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF584846)),
                                    ),
                                    hintText: '\tEnter Phone Number',
                                  ),
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: TextFormField(
                                  // onChanged: (value) {},
                                  validator: (value) {
                                    if (value.length > 4) {
                                      return null;
                                    } else {
                                      return "Too Short";
                                    }
                                  },
                                  controller: issuerName,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xFF584846),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF584846)),
                                    ),
                                    hintText: '\tEnter Name',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 20),
                                child: FlatButton(
                                    color: Colors.blue,
                                    disabledColor: Colors.blue,
                                    onPressed: () async {
                                      _formKey.currentState.save();
                                      _handleSubmit(snapshot.data);
                                    },
                                    child: Text("Issue")),
                              )
                            ],
                          ),
                        )),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    );
                  }
                } else
                  return CircularProgressIndicator();
              } else {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          )),
    );
  }

  void init() async {
    this.dir = (await getApplicationDocumentsDirectory()).path;
    this.path = '$dir/invoice.pdf';
  }

  void _handleSubmit(DocumentSnapshot snp) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        currentIndex = 1;
      });
      final File file = File(path);
      await FirebaseFirestore.instance
          .collection("invoice")
          .doc("invoice")
          .get()
          .then((value) {
        setState(() {
          invoiceno = value.data()["invoiceNo"];
        });
      });
      Uint8List bytes = await generateInvoice(
          this.invoiceno.toString(),
          snp,
          issuerName.text,
          issuerPhone.text,
          issuerEmail.text,
          this.issueDate,
          this.dueDate);

      await file.writeAsBytes(bytes);
      final message = Envelope()
        ..from = username
        ..recipients.add(issuerEmail.text)
        ..subject = 'Book Issued 😀 '
        ..attachments.add(Attachment(file: file))
        ..text =
            'Please see the below attached pdf for details '; //body of the email

      await books.doc(widget.barcode).update({"status": "Out"});
      await FirebaseFirestore.instance
          .collection("invoice")
          .doc("invoice")
          .update({"invoiceNo": FieldValue.increment(1)});
      log.doc().set({
        "date": this.issueDate,
        "issuerName": issuerName.text,
        "issuerEmail": issuerEmail.text,
        "issuerPhone": issuerPhone.text,
        "bookuid": widget.barcode,
        "duedate": this.dueDate
      }).whenComplete(() {
        setState(() {
          currentIndex = 0;
        });
        Navigator.popUntil(context, ModalRoute.withName(HomePage.id));
        Fluttertoast.showToast(msg: "Issued");
      });
      try {
        await emailTransport
            .send(message)
            .whenComplete(() => Fluttertoast.showToast(msg: 'Email sent: '));
      } catch (e) {
        Fluttertoast.showToast(
            msg: "Book Issued but Email not sent due to: " + e.toString());
      }
    } else {
      Fluttertoast.showToast(
        gravity: ToastGravity.CENTER,
        msg: "Fill Form properly",
      );
    }
  }

  String validateMobile(String value) {
    RegExp regExp = RegExp(r'^[0-9]{10}$');
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String validateEmail(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    if (value.length == 0) {
      return 'Please enter Email Address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid email Address';
    }
    return null;
  }
}
