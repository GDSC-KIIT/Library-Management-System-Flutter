import 'package:flutter/material.dart';
import 'package:library_system/pages/addNewBookPage.dart';
import 'package:library_system/pages/inventoryPage.dart';
import 'package:library_system/pages/issueBookPage.dart';
import 'package:library_system/pages/returnBookPage.dart';

class HomePage extends StatefulWidget {
  static String id = 'homepage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.apps,
                      color: Color(0xFF584846),
                      size: 40,
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Color(0xFFDD3617),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {},
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20)),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF584846),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          display1(
            context,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReturnBookPage(),
                ),
              );
            },
            "RETURN BOOK",
            Colors.white38,
            Colors.white70,
            Color(0xFF584846),
          ),
          display1(
            context,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InventoryPage(),
                ),
              );
            },
            "INVENTORY",
            Colors.white38,
            Colors.white70,
            Color(0xFF584846),
          ),
          display1(
            context,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNewBookPage(),
                ),
              );
            },
            "ADD NEW BOOK",
            Colors.white38,
            Colors.white70,
            Color(0xFF584846),
          ),
          display1(
            context,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IssueBookPage(),
                ),
              );
            },
            "ISSUE BOOK",
            Colors.white38,
            Colors.white70,
            Color(0xFF584846),
          ),
        ],
      ),
    );
  }
}

display1(BuildContext context, onTap, String title, Color c1, Color c2,
    Color textc) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.black,
        elevation: 8,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [c1, c2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15),
          ),
          width: MediaQuery.of(context).size.width - 40,
          height: 105,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 27,
                        color: textc,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
