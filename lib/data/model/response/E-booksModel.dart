// To parse this JSON data, do
//
//     final eBooksModel = eBooksModelFromJson(jsonString);

import 'dart:convert';

EBooksModel eBooksModelFromJson(String str) => EBooksModel.fromJson(json.decode(str));

String eBooksModelToJson(EBooksModel data) => json.encode(data.toJson());

class EBooksModel {
  EBooksModel({
    this.statusCode,
    this.books,
    this.totalCount,
  });

  int? statusCode;
  List<Book>? books;
  int? totalCount;

  factory EBooksModel.fromJson(Map<String, dynamic> json) => EBooksModel(
    statusCode: json["statusCode"],
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "books": List<dynamic>.from(books!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Book {
  Book({
    this.id,
    this.title,
    this.bannerPath,
    this.logoPath,
    this.description,
    this.amount,
    this.category,
    this.flag,
    this.macro,
    this.examCategory,
  });

  String? id;
  String? title;
  String? bannerPath;
  String? logoPath;
  String? description;
  int? amount;
  String? category;
  String? flag;
  List<Macro>? macro;
  ExamCategory? examCategory;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["_id"],
    title: json["title"],
    bannerPath: json["banner_path"],
    logoPath: json["logo_path"],
    description: json["description"],
    amount: json["amount"],
    category: json["category"],
    flag: json["flag"],
    macro: List<Macro>.from(json["macro"].map((x) => Macro.fromJson(x))),
    examCategory: ExamCategory.fromJson(json["exam_category"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "banner_path": bannerPath,
    "logo_path": logoPath,
    "description": description,
    "amount": amount,
    "category": category,
    "flag": flag,
    "macro": List<dynamic>.from(macro!.map((x) => x.toJson())),
    "exam_category": examCategory!.toJson(),
  };
}

class ExamCategory {
  ExamCategory({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory ExamCategory.fromJson(Map<String, dynamic> json) => ExamCategory(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class Macro {
  Macro({
    this.icon,
    this.title,
  });

  String? icon;
  String? title;

  factory Macro.fromJson(Map<String, dynamic> json) => Macro(
    icon: json["icon"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "title": title,
  };
}
