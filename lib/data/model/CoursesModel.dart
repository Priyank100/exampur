// To parse this JSON data, do
//
//     final coursesModel = coursesModelFromJson(jsonString);

import 'dart:convert';

CoursesModel coursesModelFromJson(String str) => CoursesModel.fromJson(json.decode(str));

String coursesModelToJson(CoursesModel data) => json.encode(data.toJson());

class CoursesModel {
  CoursesModel({
    this.statusCode,
    this.courses,
    this.totalCount,
  });

  int? statusCode;
  List<Course>? courses;
  int? totalCount;

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
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

  Icon? icon;
  Title? title;

  factory Macro.fromJson(Map<String, dynamic> json) => Macro(
    icon: iconValues.map[json["icon"]],
    title: titleValues.map[json["title"]],
  );

  Map<String, dynamic> toJson() => {
    "icon": iconValues.reverse![icon],
    "title": titleValues.reverse![title],
  };
}

enum Icon { RIGHT_TIK }

final iconValues = EnumValues({
  "right-tik": Icon.RIGHT_TIK
});

enum Title { FEATURE_1, FEATURE_2 }

final titleValues = EnumValues({
  "Feature 1": Title.FEATURE_1,
  "Feature 2": Title.FEATURE_2
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
