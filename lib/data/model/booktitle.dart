import 'dart:convert';
/// book : [{"id":"0","name":"Books"},{"id":"1","name":"App Crashing"}]

Booktitle booktitleFromJson(String str) => Booktitle.fromJson(json.decode(str));
String booktitleToJson(Booktitle data) => json.encode(data.toJson());
class Booktitle {
  Booktitle({
      List<Book>? book,}){
    _book = book;
}

  Booktitle.fromJson(dynamic json) {
    if (json['book'] != null) {
      _book = [];
      json['book'].forEach((v) {
        _book?.add(Book.fromJson(v));
      });
    }
  }
  List<Book>? _book;

  List<Book>? get book => _book;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_book != null) {
      map['book'] = _book?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "0"
/// name : "Books"

Book bookFromJson(String str) => Book.fromJson(json.decode(str));
String bookToJson(Book data) => json.encode(data.toJson());
class Book {
  Book({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Book.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}