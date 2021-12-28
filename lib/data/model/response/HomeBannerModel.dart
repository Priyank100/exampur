// To parse this JSON data, do
//
//     final homeBannerModel = homeBannerModelFromJson(jsonString);

import 'dart:convert';

List<HomeBannerModel> homeBannerModelFromJson(String str) => List<HomeBannerModel>.from(json.decode(str).map((x) => HomeBannerModel.fromJson(x)));

String homeBannerModelToJson(List<HomeBannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeBannerModel {
  HomeBannerModel({
    this.title,
    this.imagePath,
    this.type,
    this.typeId,
  });

  String? title;
  String? imagePath;
  String? type;
  String? typeId;

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) => HomeBannerModel(
    title: json["title"],
    imagePath: json["image_path"],
    type: json["type"],
    typeId: json["type_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image_path": imagePath,
    "type": type,
    "type_id": typeId,
  };
}
