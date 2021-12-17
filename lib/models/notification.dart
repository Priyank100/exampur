// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(
    json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Notification({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.action,
  });

  String title;
  String description;
  String imagePath;
  String action;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"] == null ? "" : json["title"],
        description: json["description"] == null ? "" : json["description"],
        imagePath: json["image_path"] == null ? "" : json["image_path"],
        action: json["action"] == null ? "" : json["action"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "image_path": imagePath == null ? null : imagePath,
        "action": action == null ? null : action,
      };
}
class NotificationList {
  final List<Notification> notificationList;

  NotificationList({required this.notificationList});
}
