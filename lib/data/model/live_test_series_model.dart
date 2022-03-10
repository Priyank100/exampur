// To parse this JSON data, do
//
//     final liveTestSeriesModel = liveTestSeriesModelFromJson(jsonString);

import 'dart:convert';

LiveTestSeriesModel liveTestSeriesModelFromJson(String str) => LiveTestSeriesModel.fromJson(json.decode(str));

String liveTestSeriesModelToJson(LiveTestSeriesModel data) => json.encode(data.toJson());

class LiveTestSeriesModel {
  LiveTestSeriesModel({
    this.statusCode,
    this.testseries,
    this.totalCount,
  });

  int? statusCode;
  List<Testsery>? testseries;
  int? totalCount;

  factory LiveTestSeriesModel.fromJson(Map<String, dynamic> json) => LiveTestSeriesModel(
    statusCode: json["statusCode"],
    testseries: List<Testsery>.from(json["testseries"].map((x) => Testsery.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "testseries": List<dynamic>.from(testseries!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class Testsery {
  Testsery({
    this.id,
    this.title,
    this.description,
    this.macro,
    this.amount,
    this.flag,
  });

  String? id;
  String? title;
  String? description;
  List<dynamic>? macro;
  int? amount;
  String? flag;

  factory Testsery.fromJson(Map<String, dynamic> json) => Testsery(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    macro: List<dynamic>.from(json["macro"].map((x) => x)),
    amount: json["amount"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "macro": List<dynamic>.from(macro!.map((x) => x)),
    "amount": amount,
    "flag": flag,
  };
}
