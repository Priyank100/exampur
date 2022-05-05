// To parse this JSON data, do
//
//     final studyMaterialNewModel = studyMaterialNewModelFromJson(jsonString);

import 'dart:convert';

List<StudyMaterialNewModel> studyMaterialNewModelFromJson(String str) => List<StudyMaterialNewModel>.from(json.decode(str).map((x) => StudyMaterialNewModel.fromJson(x)));

String studyMaterialNewModelToJson(List<StudyMaterialNewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudyMaterialNewModel {
  StudyMaterialNewModel({
    this.id,
    this.superCategory,
    this.category,
  });

  int? id;
  String? superCategory;
  List<Category>? category;

  factory StudyMaterialNewModel.fromJson(Map<String, dynamic> json) => StudyMaterialNewModel(
    id: json["id"],
    superCategory: json["super_category"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "super_category": superCategory,
    "category": List<dynamic>.from(category!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
  };
}
