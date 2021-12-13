// To parse this JSON data, do
//
//     final subjectContent = subjectContentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SubjectContent> subjectContentFromJson(String str) => List<SubjectContent>.from(json.decode(str).map((x) => SubjectContent.fromJson(x)));

String subjectContentToJson(List<SubjectContent> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectContent {
  SubjectContent({
    required this.course,
    required this.subject,
    required this.chapter,
    required this.subjectLogo,
    required this.title,
    required this.bannerPath,
    required this.description,
    required this.videoPath,
    required this.pdfPath,
    required this.sheetPath,
    required this.schedule,
    required this.isDemo,
    required this.status,
  });

  int course;
  String subject;
  String chapter;
  String subjectLogo;
  String title;
  String bannerPath;
  String description;
  String videoPath;
  String pdfPath;
  String sheetPath;
  String schedule;
  bool isDemo;
  String status;

  factory SubjectContent.fromJson(Map<String, dynamic> json) => SubjectContent(
    course: json["course"] == null ? -1 : json["course"],
    subject: json["subject"] == null ? "" : json["subject"],
    chapter: json["chapter"] == null ? "" : json["chapter"],
    subjectLogo: json["subject_logo"] == null ? "" : json["subject_logo"],
    title: json["title"] == null ? "" : json["title"],
    bannerPath: json["banner_path"] == null ? "" : json["banner_path"],
    description: json["description"] == null ? "" : json["description"],
    videoPath: json["video_path"] == null ? "" : json["video_path"],
    pdfPath: json["pdf_path"] == null ? "" : json["pdf_path"],
    sheetPath: json["sheet_path"] == null ? "" : json["sheet_path"],
    schedule: json["schedule"] == null ? "" : json["schedule"],
    isDemo: json["is_demo"] == null ? false : json["is_demo"],
    status: json["status"] == null ? "" : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "course": course == null ? null : course,
    "subject": subject == null ? null : subject,
    "chapter": chapter == null ? null : chapter,
    "subject_logo": subjectLogo == null ? null : subjectLogo,
    "title": title == null ? null : title,
    "banner_path": bannerPath == null ? null : bannerPath,
    "description": description == null ? null : description,
    "video_path": videoPath == null ? null : videoPath,
    "pdf_path": pdfPath == null ? null : pdfPath,
    "sheet_path": sheetPath == null ? null : sheetPath,
    "schedule": schedule == null ? null : schedule,
    "is_demo": isDemo == null ? null : isDemo,
    "status": status == null ? null : status,
  };
}
