// To parse this JSON data, do
//
//     final freeVideoListModel = freeVideoListModelFromJson(jsonString);

import 'dart:convert';

FreeVideoListModel freeVideoListModelFromJson(String str) => FreeVideoListModel.fromJson(json.decode(str));

String freeVideoListModelToJson(FreeVideoListModel data) => json.encode(data.toJson());

class FreeVideoListModel {
  FreeVideoListModel({
     this.channelId,
     this.name,
     this.slug,
     this.order,
     this.channelplaylist,
  });

  int? channelId;
  String? name;
  String? slug;
  int? order;
  List<ChannelPlaylist>? channelplaylist;

  factory FreeVideoListModel.fromJson(Map<String, dynamic> json) => FreeVideoListModel(
    channelId: json["channel_id"],
    name: json["name"],
    slug: json["slug"],
    order: json["order"],
    channelplaylist: List<ChannelPlaylist>.from(json["playlist"].map((x) => ChannelPlaylist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "channel_id": channelId,
    "name": name,
    "slug": slug,
    "order": order,
    "playlist": List<dynamic>.from(channelplaylist!.map((x) => x.toJson())),
  };
}

class ChannelPlaylist {
  ChannelPlaylist({
     this.id,
     this.name,
     this.slug,
     this.order,
     this.courseId,
     this.bannerLink,
     this.created,
     this.updated,
  });

  int? id;
  String? name;
  String? slug;
  int? order;
  String? courseId;
  String? bannerLink;
  DateTime? created;
  DateTime? updated;

  factory ChannelPlaylist.fromJson(Map<String, dynamic> json) => ChannelPlaylist(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    order: json["order"],
    courseId: json["course_id"],
    bannerLink: json["embdeed_banner"],
    created: DateTime.parse(json["created"]),
    updated: DateTime.parse(json["updated"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "order": order,
    "course_id": courseId,
    "embdeed_banner": bannerLink,
    "created": created!.toIso8601String(),
    "updated": updated!.toIso8601String(),
  };
}
