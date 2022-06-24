// To parse this JSON data, do
//
//     final myCourseMaterialModel = myCourseMaterialModelFromJson(jsonString);

import 'dart:convert';

MyCourseMaterialModel myCourseMaterialModelFromJson(String str) => MyCourseMaterialModel.fromJson(json.decode(str));

String myCourseMaterialModelToJson(MyCourseMaterialModel data) => json.encode(data.toJson());

class MyCourseMaterialModel {
  MyCourseMaterialModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  List<MaterialData>? data;

  factory MyCourseMaterialModel.fromJson(Map<String, dynamic> json) => MyCourseMaterialModel(
    statusCode: json["statusCode"],
    data: List<MaterialData>.from(json["data"].map((x) => MaterialData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MaterialData {
  MaterialData({
    this.id,
    this.subjectId,
    this.chapterName,
    this.title,
    this.timeline,
    this.pdfPath,
    this.unit,
    this.videoLink,
    this.docpath
  });

  String? id;
  SubjectId? subjectId;
  String? chapterName;
  String? title;
  Timeline? timeline;
  String? pdfPath;
  String? unit;
  String? videoLink;
  String? docpath;

  factory MaterialData.fromJson(Map<String, dynamic> json) => MaterialData(
    id: json["_id"],
    subjectId: SubjectId.fromJson(json["subject_id"]),
    chapterName: json["chapter_name"],
    title: json["title"],
    timeline: json["timeline"] == null ? null : Timeline.fromJson(json["timeline"]),
    pdfPath: json["pdf_path"],
    unit:json["unit"],
    videoLink: json["video_link"] == null ? null : json["video_link"],
    docpath: json["doc_path"] == null ? null : json["doc_path"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subject_id": subjectId!.toJson(),
    "chapter_name": chapterName,
    "title": title,
    "timeline": timeline == null ? null : timeline!.toJson(),
    "pdf_path": pdfPath,
    "unit":unit,
    "video_link": videoLink == null ? null : videoLink,
    "doc_path": docpath == null ? null : docpath,
  };
}

class SubjectId {
  SubjectId({
    this.id,
    this.title,
  });

  String? id;
  String? title;

  factory SubjectId.fromJson(Map<String, dynamic> json) => SubjectId(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
  };
}

class Timeline {
  Timeline({
    this.id,
    this.title,
    this.logoPath,
    this.timelineStatus,
    this.apexLink,
    this.liveStreamStatus,
    this.recordingProps,
  });

  String? id;
  String? title;
  String? logoPath;
  String? timelineStatus;
  ApexLink? apexLink;
  bool? liveStreamStatus;
  RecordingProps? recordingProps;

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    id: json["_id"],
    title: json["title"],
    logoPath: json["logo_path"],
    timelineStatus: json["timelineStatus"],
    apexLink: ApexLink.fromJson(json["apex_link"]),
    liveStreamStatus: json["liveStreamStatus"],
    recordingProps:  json["recordingProps"] == null ? null : RecordingProps.fromJson(json["recordingProps"])
    // RecordingProps.fromJson(json["recordingProps"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "logo_path": logoPath,
    "timelineStatus": timelineStatus,
    "apex_link": apexLink!.toJson(),
    "liveStreamStatus": liveStreamStatus,
    "recordingProps": recordingProps!.toJson(),
  };
}

class ApexLink {
  ApexLink({
    this.hlsUrl,
    this.hls720PUrl,
    this.hls480PUrl,
    this.hls360PUrl,
    this.hls240PUrl,
  });

  String? hlsUrl;
  String? hls720PUrl;
  String? hls480PUrl;
  String? hls360PUrl;
  String? hls240PUrl;

  factory ApexLink.fromJson(Map<String, dynamic> json) => ApexLink(
    hlsUrl: json["hlsURL"],
    hls720PUrl: json["hls720pURL"],
    hls480PUrl: json["hls480pURL"],
    hls360PUrl: json["hls360pURL"],
    hls240PUrl: json["hls240pURL"],
  );

  Map<String, dynamic> toJson() => {
    "hlsURL": hlsUrl,
    "hls720pURL": hls720PUrl,
    "hls480pURL": hls480PUrl,
    "hls360pURL": hls360PUrl,
    "hls240pURL": hls240PUrl,
  };
}

class RecordingProps {
  RecordingProps({
    this.the240,
    this.the360,
    this.the576,
    this.thumbnail,
  });

  String? the240;
  String? the360;
  String? the576;
  String? thumbnail;

  factory RecordingProps.fromJson(Map<String, dynamic> json) => RecordingProps(
    the240: json["240"],
    the360: json["360"],
    the576: json["576"],
    thumbnail: json["thumbnail"],
  );

  Map<String, dynamic> toJson() => {
    "240": the240,
    "360": the360,
    "576": the576,
    "thumbnail": thumbnail,
  };
}
