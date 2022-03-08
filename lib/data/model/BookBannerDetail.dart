// To parse this JSON data, do
//
//     final bookModels = bookModelsFromJson(jsonString);

import 'dart:convert';

BookModels bookModelsFromJson(String str) => BookModels.fromJson(json.decode(str));

String bookModelsToJson(BookModels data) => json.encode(data.toJson());

class BookModels {
  BookModels({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Book? data;

  factory BookModels.fromJson(Map<String, dynamic> json) => BookModels(
    statusCode: json["statusCode"],
    data: Book.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data!.toJson(),
  };
}

class Book {
  Book({
    this.id,
    this.category,
    this.title,
    this.description,
    this.sortWeightage,
    this.regularPrice,
    this.salePrice,
    this.isEbook,
    this.flag,
    this.macro,
    this.pdfPath,
    this.bannerPath,
    this.logoPath,
  });

  String? id;
  List<Category>? category;
  String? title;
  String? description;
  int? sortWeightage;
  int? regularPrice;
  int? salePrice;
  bool? isEbook;
  String? flag;
  List<dynamic>? macro;
  String? pdfPath;
  String? bannerPath;
  String? logoPath;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["_id"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    title: json["title"],
    description: json["description"],
    sortWeightage: json["sort_weightage"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    isEbook: json["is_ebook"],
    flag: json["flag"],
    macro: List<dynamic>.from(json["macro"].map((x) => x)),
    pdfPath: json["pdf_path"],
    bannerPath: json["banner_path"],
    logoPath: json["logo_path"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": List<dynamic>.from(category!.map((x) => x.toJson())),
    "title": title,
    "description": description,
    "sort_weightage": sortWeightage,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "is_ebook": isEbook,
    "flag": flag,
    "macro": List<dynamic>.from(macro!.map((x) => x)),
    "pdf_path": pdfPath,
    "banner_path": bannerPath,
    "logo_path": logoPath,
  };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
