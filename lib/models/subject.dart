// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Subject> subjectFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    required this.course,
    required this.subject,
    required this.subjectLogo,
  });

  int course;
  String subject;
  String subjectLogo;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        course: json["course"] == null ? -1 : json["course"],
        subject: json["subject"] == null ? "" : json["subject"],
        subjectLogo: json["subject_logo"] == null ? "" : json["subject_logo"],
      );

  Map<String, dynamic> toJson() => {
        "course": course == null ? null : course,
        "subject": subject == null ? null : subject,
        "subject_logo": subjectLogo == null ? null : subjectLogo,
      };
}
