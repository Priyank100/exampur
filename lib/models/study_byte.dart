// To parse this JSON data, do
//
//     final studyByte = studyByteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

StudyByte studyByteFromJson(String str) => StudyByte.fromJson(json.decode(str));

String studyByteToJson(StudyByte data) => json.encode(data.toJson());

class StudyByte {
  StudyByte({
    required this.examCategory,
    required this.title,
    required this.description,
    required this.category,
    required this.resourceType,
    required this.resourcePath,
    required this.flag,
  });

  String examCategory;
  String title;
  String description;
  String category;
  String resourceType;
  String resourcePath;
  String flag;

  factory StudyByte.fromJson(Map<String, dynamic> json) => StudyByte(
        examCategory:
            json["exam_category"] == null ? "" : json["exam_category"],
        title: json["title"] == null ? "" : json["title"],
        description: json["description"] == null ? "" : json["description"],
        category: json["category"] == null ? "" : json["category"],
        resourceType:
            json["resource_type"] == null ? "" : json["resource_type"],
        resourcePath:
            json["resource_path"] == null ? "" : json["resource_path"],
        flag: json["flag"] == null ? "" : json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "exam_category": examCategory == null ? null : examCategory,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "category": category == null ? null : category,
        "resource_type": resourceType == null ? null : resourceType,
        "resource_path": resourcePath == null ? null : resourcePath,
        "flag": flag == null ? null : flag,
      };
}
