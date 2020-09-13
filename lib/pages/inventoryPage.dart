import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  InventoryPage({Key key}) : super(key: key);

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inventory Page"),
        ),
      ),
    );
  }
}
