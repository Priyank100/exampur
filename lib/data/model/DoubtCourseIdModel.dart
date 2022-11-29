// To parse this JSON data, do
//
//     final doubtCourseIdModel = doubtCourseIdModelFromJson(jsonString);

import 'dart:convert';

DoubtCourseIdModel doubtCourseIdModelFromJson(String str) => DoubtCourseIdModel.fromJson(json.decode(str));

String doubtCourseIdModelToJson(DoubtCourseIdModel data) => json.encode(data.toJson());

class DoubtCourseIdModel {
  DoubtCourseIdModel({
    this.status,
    this.courses,
  });

  bool? status;
  List<Course>? courses;

  factory DoubtCourseIdModel.fromJson(Map<String, dynamic> json) => DoubtCourseIdModel(
    status: json["status"],
    courses: List<Course>.from(json["courses"].map((x) => Course.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "courses": List<dynamic>.from(courses!.map((x) => x.toJson())),
  };
}

class Course {
  Course({
    this.courseId,
    this.webId,
  });

  String? courseId;
  int? webId;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    courseId: json["course_id"],
    webId: json["web_id"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
    "web_id": webId,
  };
}
