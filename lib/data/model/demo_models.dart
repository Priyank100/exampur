// To parse this JSON data, do
//
//     final demoModels = demoModelsFromJson(jsonString);

import 'dart:convert';

DemoModels demoModelsFromJson(String str) => DemoModels.fromJson(json.decode(str));

String demoModelsToJson(DemoModels data) => json.encode(data.toJson());

class DemoModels {
  DemoModels({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  List<Datum>? data;

  factory DemoModels.fromJson(Map<String, dynamic> json) => DemoModels(
    statusCode: json["statusCode"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.courseId,
    this.subjectId,
    this.title,
    this.description,
    this.logoPath,
    this.type,
    this.targetLink,
    this.schedule,
  });

  String? id;
  Id? courseId;
  Id? subjectId;
  String? title;
  String? description;
  String? logoPath;
  String? type;
  String? targetLink;
  DateTime? schedule;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    courseId: Id.fromJson(json["course_id"]),
    subjectId: Id.fromJson(json["subject_id"]),
    title: json["title"],
    description: json["description"],
    logoPath: json["logo_path"],
    type: json["type"],
    targetLink: json["target_link"],
    schedule: DateTime.parse(json["schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "course_id": courseId!.toJson(),
    "subject_id": subjectId!.toJson(),
    "title": title,
    "description": description,
    "logo_path": logoPath,
    "type": type,
    "target_link": targetLink,
    "schedule": schedule!.toIso8601String(),
  };
}

class Id {
  Id({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}
