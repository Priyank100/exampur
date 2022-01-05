// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.statusCode,
    this.categories,
    this.totalCount,
  });

  int? statusCode;
  List<Category>? categories;
  int? totalCount;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    statusCode: json["statusCode"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Category {
  Category({
    this.id,
    this.logoPath,
    this.description,
    this.name,
    this.sorting,
  });

  String? id;
  String? logoPath;
  String? description;
  String? name;
  int? sorting;
  bool isSelected=false;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    logoPath: json["logo_path"],
    description: json["description"],
    name: json["name"],
    sorting: json["sorting"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "logo_path": logoPath,
    "description": description,
    "name": name,
    "sorting": sorting,
  };
}
