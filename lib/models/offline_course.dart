// To parse this JSON data, do
//
//     final offlineCourse = offlineCourseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OfflineCourse> offlineCourseFromJson(String str) =>
    List<OfflineCourse>.from(
        json.decode(str).map((x) => OfflineCourse.fromJson(x)));

String offlineCourseToJson(List<OfflineCourse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfflineCourse {
  OfflineCourse({
    required this.examCategory,
    required this.centerId,
    required this.title,
    required this.bannerPath,
    required this.description,
    required this.logoPath,
    required this.videoPath,
    required this.amount,
    required this.isEmi,
    required this.isDemo,
    required this.flag,
    required this.status,
    required this.monthDuration,
    required this.macro,
  });

  String examCategory;
  String centerId;
  String title;
  String bannerPath;
  String description;
  String logoPath;
  String videoPath;
  int amount;
  int isEmi;
  int isDemo;
  int flag;
  int status;
  int monthDuration;
  List<Macro> macro;

  factory OfflineCourse.fromJson(Map<String, dynamic> json) => OfflineCourse(
        examCategory:
            json["exam_category"] == null ? "" : json["exam_category"],
        centerId: json["center_id"] == null ? "" : json["center_id"],
        title: json["title"] == null ? "" : json["title"],
        bannerPath: json["banner_path"] == null ? "" : json["banner_path"],
        description: json["description"] == null ? "" : json["description"],
        logoPath: json["logo_path"] == null ? "" : json["logo_path"],
        videoPath: json["video_path"] == null ? "" : json["video_path"],
        amount: json["amount"] == null ? -1 : json["amount"],
        isEmi: json["is_emi"] == null ? -1 : json["is_emi"],
        isDemo: json["is_demo"] == null ? -1 : json["is_demo"],
        flag: json["flag"] == null ? -1 : json["flag"],
        status: json["status"] == null ? -1 : json["status"],
        monthDuration:
            json["month_duration"] == null ? -1 : json["month_duration"],
        macro: json["macro"] == null
            ? []
            : List<Macro>.from(json["macro"].map((x) => Macro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "exam_category": examCategory == null ? null : examCategory,
        "center_id": centerId == null ? null : centerId,
        "title": title == null ? null : title,
        "banner_path": bannerPath == null ? null : bannerPath,
        "description": description == null ? null : description,
        "logo_path": logoPath == null ? null : logoPath,
        "video_path": videoPath == null ? null : videoPath,
        "amount": amount == null ? null : amount,
        "is_emi": isEmi == null ? null : isEmi,
        "is_demo": isDemo == null ? null : isDemo,
        "flag": flag == null ? null : flag,
        "status": status == null ? null : status,
        "month_duration": monthDuration == null ? null : monthDuration,
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
