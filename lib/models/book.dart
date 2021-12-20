// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Book> bookFromJson(String str) =>
    List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.examCategory,
    required this.title,
    required this.bannerPath,
    required this.logoPath,
    required this.description,
    required this.category,
    required this.amount,
    required this.isEbook,
    required this.pdfPath,
    required this.flag,
    required this.macro,
  });

  String examCategory;
  String title;
  String bannerPath;
  String logoPath;
  String description;
  String category;
  int amount;
  bool isEbook;
  String pdfPath;
  String flag;
  List<Macro> macro;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        examCategory:
            json["exam_category"] == null ? "" : json["exam_category"],
        title: json["title"] == null ? "" : json["title"],
        bannerPath: json["banner_path"] == null ? "" : json["banner_path"],
        logoPath: json["logo_path"] == null ? "" : json["logo_path"],
        description: json["description"] == null ? "" : json["description"],
        category: json["category"] == null ? "" : json["category"],
        amount: json["amount"] == null ? -1 : json["amount"],
        isEbook: json["is_ebook"] == null ? false : json["is_ebook"],
        pdfPath: json["pdf_path"] == null ? "" : json["pdf_path"],
        flag: json["flag"] == null ? "" : json["flag"],
        macro: json["macro"] == null
            ? []
            : List<Macro>.from(json["macro"].map((x) => Macro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exam_category": examCategory == null ? null : examCategory,
        "title": title == null ? null : title,
        "banner_path": bannerPath == null ? null : bannerPath,
        "logo_path": logoPath == null ? null : logoPath,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "amount": amount == null ? null : amount,
        "is_ebook": isEbook == null ? null : isEbook,
        "pdf_path": pdfPath == null ? null : pdfPath,
        "flag": flag == null ? null : flag,
        "macro": macro == null
            ? null
            : List<dynamic>.from(macro.map((x) => x.toJson())),
      };
}

class Macro {
  Macro({
    required this.icon,
    required this.title,
  });

  String icon;
  String title;

  factory Macro.fromJson(Map<String, dynamic> json) => Macro(
        icon: json["icon"] == null ? "" : json["icon"],
        title: json["title"] == null ? "" : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon == null ? null : icon,
        "title": title == null ? null : title,
      };
}

class BookList {
  final List<Book> bookList;

  BookList({required this.bookList});
}
