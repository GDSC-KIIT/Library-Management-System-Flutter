import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Inventory Page"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("books").snapshots(),
          builder: (context, snapshot) {
             if(!snapshot.hasData){
               return Center(child: CircularProgressIndicator());
             }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot books =
                  snapshot.data.documents[index];
              return Card(
                child: ListTile(
                  title: Text(books['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(books['author']),
                      Text(books['genre']),
                      Text(books['isbn']),
                    ],
                  ),
                  trailing: Text(books['publisher']),
                ),
              );
            },
          ),
      );
          },
        ),
      ),
    );
  }
}
