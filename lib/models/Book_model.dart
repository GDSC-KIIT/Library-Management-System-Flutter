import 'package:firebase_database/firebase_database.dart';

//Books is defined here as a class


class Books{
  String name;
  String author;
  String uId;
  String publisher;
  String key;
  String genre;
  String isbn;

  Books(this.name, this.author, this.uId, this.publisher, this.genre,this.isbn);

  Books.fromSnapshot(DataSnapshot snapshot)
  : key = snapshot.key,
    name = snapshot.value["name"],
    author = snapshot.value["author"],
    uId = snapshot.value["uId"],
    publisher = snapshot.value["publisher"],
    genre = snapshot.value["genre"],
    isbn = snapshot.value["isbn"];


  toJson(){
    return {
      "name": name,
      "author": author,
      "uId": uId,
      "publisher": publisher,
      "genre": genre,
      "isbn": isbn,
    };
  }
}
String result = "";
    