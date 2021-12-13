// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.examCategory,
    required this.title,
    required this.bannerPath,
    required this.logoPath,
    required this.description,
    required this.videoPath,
    required this.amount,
    required this.flag,
    required this.status,
    required this.macro,
    required this.upsellCourse,
    required this.upsellBook,
  });

  String examCategory;
  String title;
  String bannerPath;
  String logoPath;
  String description;
  String videoPath;
  int amount;
  String flag;
  String status;
  List<Macro> macro;
  List<int> upsellCourse;
  List<int> upsellBook;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    examCategory: json["exam_category"] == null ? "" : json["exam_category"],
    title: json["title"] == null ? "" : json["title"],
    bannerPath: json["banner_path"] == null ? "" : json["banner_path"],
    logoPath: json["logo_path"] == null ? "" : json["logo_path"],
    description: json["description"] == null ? "" : json["description"],
    videoPath: json["video_path"] == null ? "" : json["video_path"],
    amount: json["amount"] == null ? -1 : json["amount"],
    flag: json["flag"] == null ? "" : json["flag"],
    status: json["status"] == null ? "" : json["status"],
    macro: json["macro"] == null ? [] : List<Macro>.from(json["macro"].map((x) => Macro.fromJson(x))),
    upsellCourse: json["upsell_course"] == null ? [] : List<int>.from(json["upsell_course"].map((x) => x)),
    upsellBook: json["upsell_book"] == null ? [] : List<int>.from(json["upsell_book"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "exam_category": examCategory == null ? null : examCategory,
    "title": title == null ? null : title,
    "banner_path": bannerPath == null ? null : bannerPath,
    "logo_path": logoPath == null ? null : logoPath,
    "description": description == null ? null : description,
    "video_path": videoPath == null ? null : videoPath,
    "amount": amount == null ? null : amount,
    "flag": flag == null ? null : flag,
    "status": status == null ? null : status,
    "macro": macro == null ? null : List<dynamic>.from(macro.map((x) => x.toJson())),
    "upsell_course": upsellCourse == null ? null : List<dynamic>.from(upsellCourse.map((x) => x)),
    "upsell_book": upsellBook == null ? null : List<dynamic>.from(upsellBook.map((x) => x)),
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
