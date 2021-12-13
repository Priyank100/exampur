// To parse this JSON data, do
//
//     final testSeries = testSeriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TestSeries> testSeriesFromJson(String str) =>
    List<TestSeries>.from(json.decode(str).map((x) => TestSeries.fromJson(x)));

String testSeriesToJson(List<TestSeries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestSeries {
  TestSeries({
    required this.testSeries,
    required this.examCategory,
    required this.title,
    required this.description,
    required this.macro,
    required this.questionCount,
    required this.marks,
    required this.minute,
    required this.amount,
    required this.flag,
    required this.category,
    required this.status,
  });

  int testSeries;
  int examCategory;
  String title;
  String description;
  List<Macro> macro;
  int questionCount;
  int marks;
  int minute;
  int amount;
  String flag;
  String category;
  String status;

  factory TestSeries.fromJson(Map<String, dynamic> json) => TestSeries(
        testSeries: json["test_series"] == null ? -1 : json["test_series"],
        examCategory:
            json["exam_category"] == null ? -1 : json["exam_category"],
        title: json["title"] == null ? "" : json["title"],
        description: json["description"] == null ? "" : json["description"],
        macro: json["macro"] == null
            ? []
            : List<Macro>.from(json["macro"].map((x) => Macro.fromJson(x))),
        questionCount:
            json["question_count"] == null ? -1 : json["question_count"],
        marks: json["marks"] == null ? -1 : json["marks"],
        minute: json["minute"] == null ? -1 : json["minute"],
        amount: json["amount"] == null ? -1 : json["amount"],
        flag: json["flag"] == null ? "" : json["flag"],
        category: json["category"] == null ? "" : json["category"],
        status: json["status"] == null ? "" : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "test_series": testSeries == null ? null : testSeries,
        "exam_category": examCategory == null ? null : examCategory,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "macro": macro == null
            ? null
            : List<dynamic>.from(macro.map((x) => x.toJson())),
        "question_count": questionCount == null ? null : questionCount,
        "marks": marks == null ? null : marks,
        "minute": minute == null ? null : minute,
        "amount": amount == null ? null : amount,
        "flag": flag == null ? null : flag,
        "category": category == null ? null : category,
        "status": status == null ? null : status,
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
