// To parse this JSON data, do
//
//     final freeVideoPlayListModel = freeVideoPlayListModelFromJson(jsonString);

import 'dart:convert';

FreeVideoPlayListModel freeVideoPlayListModelFromJson(String str) => FreeVideoPlayListModel.fromJson(json.decode(str));

String freeVideoPlayListModelToJson(FreeVideoPlayListModel data) => json.encode(data.toJson());

class FreeVideoPlayListModel {
  FreeVideoPlayListModel({
     this.chapterId,
     this.name,
     this.slug,
     this.order,
     this.videos,
  });

  int? chapterId;
  String? name;
  String? slug;
  int? order;
  List<Video>? videos;

  factory FreeVideoPlayListModel.fromJson(Map<String, dynamic> json) => FreeVideoPlayListModel(
    chapterId: json["chapter_id"],
    name: json["name"],
    slug: json["slug"],
    order: json["order"],
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter_id": chapterId,
    "name": name,
    "slug": slug,
    "order": order,
    "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
  };
}

class Video {
  Video({
     this.id,
     this.title,
     this.slug,
     this.videoUrl,
     this.pdfUrl,
     this.order,
     this.created,
     this.updated,
  });

  int? id;
  String? title;
  String? slug;
  String? videoUrl;
  String? pdfUrl;
  int? order;
  DateTime? created;
  DateTime? updated;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    videoUrl: json["video_url"],
    pdfUrl: json["pdf_url"],
    order: json["order"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "video_url": videoUrl,
    "pdf_url": pdfUrl,
    "order": order,
    "created": created!.toIso8601String(),
    "updated": updated!.toIso8601String(),
  };
}
