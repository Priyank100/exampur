// To parse this JSON data, do
//
//     final doubtCourseIdModel = doubtCourseIdModelFromJson(jsonString);

import 'dart:convert';

OfflineCounselingModel offlineCounselingModelFromJson(String str) => OfflineCounselingModel.fromJson(json.decode(str));

String offlineCounselingModelToJson(OfflineCounselingModel data) => json.encode(data.toJson());

class OfflineCounselingModel {
  OfflineCounselingModel({
    this.status,
    this.courses,
  });

  bool? status;
  List<CounselingCourse>? courses;

  factory OfflineCounselingModel.fromJson(Map<String, dynamic> json) => OfflineCounselingModel(
    status: json["status"],
    courses: List<CounselingCourse>.from(json["courses"].map((x) => CounselingCourse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "courses": List<dynamic>.from(courses!.map((x) => x.toJson())),
  };
}

class CounselingCourse {
  CounselingCourse({
    this.courseId,
    this.webLink,
  });

  String? courseId;
  String? webLink;

  factory CounselingCourse.fromJson(Map<String, dynamic> json) => CounselingCourse(
    courseId: json["course_id"],
    webLink: json["web_link"],
  );

  Map<String, dynamic> toJson() => {
    "course_id": courseId,
    "web_link": webLink,
  };
}
