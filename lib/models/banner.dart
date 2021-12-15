// To parse this JSON data, do
//
//     final banner = bannerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Banner> bannerFromJson(String str) =>
    List<Banner>.from(json.decode(str).map((x) => Banner.fromJson(x)));

String bannerToJson(List<Banner> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banner {
  Banner({
    required this.title,
    required this.imagePath,
    required this.type,
    required this.typeId,
  });

  String title;
  String imagePath;
  String type;
  String typeId;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        title: json["title"] == null ? "" : json["title"],
        imagePath: json["image_path"] == null ? "" : json["image_path"],
        type: json["type"] == null ? "" : json["type"],
        typeId: json["type_id"] == null ? "" : json["type_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "image_path": imagePath == null ? null : imagePath,
        "type": type == null ? null : type,
        "type_id": typeId == null ? null : typeId,
      };
}

class BannerList {
  final List<Banner> bannerList;

  BannerList({required this.bannerList});
}
