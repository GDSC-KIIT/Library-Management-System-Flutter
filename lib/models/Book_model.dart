//Books is defined here as a class

import 'package:cloud_firestore/cloud_firestore.dart';

class Books {
   String name;
   String author;
   String uId;
   String publisher;
   String genre;
   String isbn;
   String status;

  Books(
      {this.name,
      this.status,
      this.author,
      this.uId,
      this.publisher,
      this.genre,
      this.isbn});

  Books.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data()["name"],
        author = snapshot.data()["author"],
        uId = snapshot.id,
        publisher = snapshot.data()["publisher"],
        genre = snapshot.data()["genre"],
        isbn = snapshot.data()["isbn"],
        status = snapshot.data()["status"];
  toJson() {
    return {
      "name": name,
      "author": author,
      "uId": uId,
      "publisher": publisher,
      "genre": genre,
      "isbn": isbn,
      "status": status,
    };
  }
}

String result = "";
String reResult = "";
