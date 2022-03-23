// To parse this JSON data, do
//
//     final downloadModel = downloadModelFromJson(jsonString);

import 'dart:convert';

DownloadModel downloadModelFromJson(String str) => DownloadModel.fromJson(json.decode(str));

String downloadModelToJson(DownloadModel data) => json.encode(data.toJson());

class DownloadModel {
  DownloadModel({
    this.download,
  });

  List<Download>? download;

  factory DownloadModel.fromJson(Map<String, dynamic> json) => DownloadModel(
    download: List<Download>.from(json["download"].map((x) => Download.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "download": List<dynamic>.from(download!.map((x) => x.toJson())),
  };
}

class Download {
  Download({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Download.fromJson(Map<String, dynamic> json) => Download(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
