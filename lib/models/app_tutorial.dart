// To parse this JSON data, do
//
//     final appTutorial = appTutorialFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AppTutorial> appTutorialFromJson(String str) => List<AppTutorial>.from(json.decode(str).map((x) => AppTutorial.fromJson(x)));

String appTutorialToJson(List<AppTutorial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppTutorial {
  AppTutorial({
    required this.title,
    required this.imagePath,
    required this.videoPath,
  });

  String title;
  String imagePath;
  String videoPath;

  factory AppTutorial.fromJson(Map<String, dynamic> json) => AppTutorial(
    title: json["title"] == null ? "" : json["title"],
    imagePath: json["image_path"] == null ? "" : json["image_path"],
    videoPath: json["video_path"] == null ? "" : json["video_path"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "image_path": imagePath == null ? null : imagePath,
    "video_path": videoPath == null ? null : videoPath,
  };
}
