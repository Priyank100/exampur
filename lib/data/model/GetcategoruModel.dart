// To parse this JSON data, do
//
//     final getCategoriesModel = getCategoriesModelFromJson(jsonString);

import 'dart:convert';

GetCategoriesModel getCategoriesModelFromJson(String str) => GetCategoriesModel.fromJson(json.decode(str));

String getCategoriesModelToJson(GetCategoriesModel data) => json.encode(data.toJson());

class GetCategoriesModel {
  GetCategoriesModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  List<String>? data;

  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) => GetCategoriesModel(
    statusCode: json["statusCode"],
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}