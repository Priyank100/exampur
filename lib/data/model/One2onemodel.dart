// To parse this JSON data, do
//
//     final one2OneModel = one2OneModelFromJson(jsonString);

import 'dart:convert';

One2OneModel one2OneModelFromJson(String str) => One2OneModel.fromJson(json.decode(str));

String one2OneModelToJson(One2OneModel data) => json.encode(data.toJson());

class One2OneModel {
  One2OneModel({
    this.statusCode,
    this.courses,
    this.totalCount,
  });

  int? statusCode;
  List<Course>? courses;
  int? totalCount;

  factory One2OneModel.fromJson(Map<String, dynamic> json) => One2OneModel(
    statusCode: json["statusCode"],
    courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "courses": List<dynamic>.from(courses!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Course {
  Course({
    this.id,
    this.title,
    this.bannerPath,
    this.logoPath,
    this.description,
    this.videoPath,
    this.amount,
    this.flag,
    this.macro,
    this.examCategory,
  });

  String? id;
  String? title;
  String? bannerPath;
  String? logoPath;
  String? description;
  String? videoPath;
  int? amount;
  String? flag;
  List<Macro>? macro;
  ExamCategory? examCategory;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["_id"],
    title: json["title"],
    bannerPath: json["banner_path"],
    logoPath: json["logo_path"],
    description: json["description"],
    videoPath: json["video_path"],
    amount: json["amount"],
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
    "video_path": videoPath,
    "amount": amount,
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
