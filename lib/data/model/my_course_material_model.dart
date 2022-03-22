import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"6239a90c46b2da65a08ba094","subject_id":{"_id":"623491f63e737b8d62111110","title":"History"},"chapter_name":"Ch 2","title":"This is final Tets","timeline":{"_id":"6239a8fa46b2da65a08ba074","title":"This is final Tets","logo_path":"course_timeline/90npwUbK-0-61908432935990331626543302041-jpg","timelineStatus":"completed","apex_link":{"hlsURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445.m3u8","hls720pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_720p1128kbs/index.m3u8","hls480pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_480p878kbs/index.m3u8","hls360pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_360p528kbs/index.m3u8","hls240pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_240p264kbs/index.m3u8"},"liveStreamStatus":false},"pdf_path":"course_material/6239a90c46b2da65a08ba094/mHPVW5z4-GST-Certificaate-pdf"},{"_id":"62399cb7d4ae21925f62ac7a","subject_id":{"_id":"623491f63e737b8d62111110","title":"History"},"title":"Live Stream Test","timeline":{"_id":"62385ac26f81f44bd913bac7","title":"Live Stream Test","logo_path":"course_timeline/W4R9goUS-343-3436982-calling-png-images-transparent-transparent-background-voice-call-png-png","timelineStatus":"completed","apex_link":{"hlsURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/1907269637.m3u8","hls720pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/1907269637_720p1128kbs/index.m3u8","hls480pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/1907269637_480p878kbs/index.m3u8","hls360pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/1907269637_360p528kbs/index.m3u8","hls240pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/1907269637_240p264kbs/index.m3u8"},"liveStreamStatus":false},"chapter_name":"Ch1","pdf_path":"course_material/62399cb7d4ae21925f62ac7a/9yqJAb7A-GST-Certificaate-pdf"},{"_id":"62349533d5100d6ed29e8b49","subject_id":{"_id":"623491f63e737b8d62111110","title":"History"},"chapter_name":"Ch 2","title":"This is test","video_link":"","pdf_path":"course_material/62349533d5100d6ed29e8b49/64JI6Pdc-Receipt-pay-Hn4zi34YB57zB3-from-Classplus-Paid-pdf"},{"_id":"623494dc3e737b8d621111c4","subject_id":{"_id":"623491f63e737b8d62111110","title":"History"},"chapter_name":"Ch 1","title":"This is test","video_link":"","pdf_path":"course_material/623494dc3e737b8d621111c4/0WGSnp7P-Receipt-pay-Hn4zi34YB57zB3-from-Classplus-Paid-pdf"}]

MyCourseMaterialModel myCourseMaterialModelFromJson(String str) => MyCourseMaterialModel.fromJson(json.decode(str));
String myCourseMaterialModelToJson(MyCourseMaterialModel data) => json.encode(data.toJson());
class MyCourseMaterialModel {
  MyCourseMaterialModel({
      int? statusCode, 
      List<MaterialData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseMaterialModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MaterialData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<MaterialData>? _data;

  int? get statusCode => _statusCode;
  List<MaterialData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6239a90c46b2da65a08ba094"
/// subject_id : {"_id":"623491f63e737b8d62111110","title":"History"}
/// chapter_name : "Ch 2"
/// title : "This is final Tets"
/// timeline : {"_id":"6239a8fa46b2da65a08ba074","title":"This is final Tets","logo_path":"course_timeline/90npwUbK-0-61908432935990331626543302041-jpg","timelineStatus":"completed","apex_link":{"hlsURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445.m3u8","hls720pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_720p1128kbs/index.m3u8","hls480pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_480p878kbs/index.m3u8","hls360pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_360p528kbs/index.m3u8","hls240pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_240p264kbs/index.m3u8"},"liveStreamStatus":false}
/// pdf_path : "course_material/6239a90c46b2da65a08ba094/mHPVW5z4-GST-Certificaate-pdf"

MaterialData dataFromJson(String str) => MaterialData.fromJson(json.decode(str));
String dataToJson(MaterialData data) => json.encode(data.toJson());
class MaterialData {
  MaterialData({
      String? id, 
      Subject_id? subjectId, 
      String? chapterName, 
      String? title, 
      Timeline? timeline, 
      String? pdfPath,}){
    _id = id;
    _subjectId = subjectId;
    _chapterName = chapterName;
    _title = title;
    _timeline = timeline;
    _pdfPath = pdfPath;
}

  MaterialData.fromJson(dynamic json) {
    _id = json['_id'];
    _subjectId = json['subject_id'] != null ? Subject_id.fromJson(json['subject_id']) : null;
    _chapterName = json['chapter_name'];
    _title = json['title'];
    _timeline = json['timeline'] != null ? Timeline.fromJson(json['timeline']) : null;
    _pdfPath = json['pdf_path'];
  }
  String? _id;
  Subject_id? _subjectId;
  String? _chapterName;
  String? _title;
  Timeline? _timeline;
  String? _pdfPath;

  String? get id => _id;
  Subject_id? get subjectId => _subjectId;
  String? get chapterName => _chapterName;
  String? get title => _title;
  Timeline? get timeline => _timeline;
  String? get pdfPath => _pdfPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_subjectId != null) {
      map['subject_id'] = _subjectId?.toJson();
    }
    map['chapter_name'] = _chapterName;
    map['title'] = _title;
    if (_timeline != null) {
      map['timeline'] = _timeline?.toJson();
    }
    map['pdf_path'] = _pdfPath;
    return map;
  }

}

/// _id : "6239a8fa46b2da65a08ba074"
/// title : "This is final Tets"
/// logo_path : "course_timeline/90npwUbK-0-61908432935990331626543302041-jpg"
/// timelineStatus : "completed"
/// apex_link : {"hlsURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445.m3u8","hls720pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_720p1128kbs/index.m3u8","hls480pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_480p878kbs/index.m3u8","hls360pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_360p528kbs/index.m3u8","hls240pURL":"https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_240p264kbs/index.m3u8"}
/// liveStreamStatus : false

Timeline timelineFromJson(String str) => Timeline.fromJson(json.decode(str));
String timelineToJson(Timeline data) => json.encode(data.toJson());
class Timeline {
  Timeline({
      String? id, 
      String? title, 
      String? logoPath, 
      String? timelineStatus, 
      Apex_link? apexLink, 
      bool? liveStreamStatus,}){
    _id = id;
    _title = title;
    _logoPath = logoPath;
    _timelineStatus = timelineStatus;
    _apexLink = apexLink;
    _liveStreamStatus = liveStreamStatus;
}

  Timeline.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
    _timelineStatus = json['timelineStatus'];
    _apexLink = json['apex_link'] != null ? Apex_link.fromJson(json['apex_link']) : null;
    _liveStreamStatus = json['liveStreamStatus'];
  }
  String? _id;
  String? _title;
  String? _logoPath;
  String? _timelineStatus;
  Apex_link? _apexLink;
  bool? _liveStreamStatus;

  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;
  String? get timelineStatus => _timelineStatus;
  Apex_link? get apexLink => _apexLink;
  bool? get liveStreamStatus => _liveStreamStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    map['timelineStatus'] = _timelineStatus;
    if (_apexLink != null) {
      map['apex_link'] = _apexLink?.toJson();
    }
    map['liveStreamStatus'] = _liveStreamStatus;
    return map;
  }

}

/// hlsURL : "https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445.m3u8"
/// hls720pURL : "https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_720p1128kbs/index.m3u8"
/// hls480pURL : "https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_480p878kbs/index.m3u8"
/// hls360pURL : "https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_360p528kbs/index.m3u8"
/// hls240pURL : "https://dqiwkpiibilt0.cloudfront.net/mnt/hls/677058445_240p264kbs/index.m3u8"

Apex_link apex_linkFromJson(String str) => Apex_link.fromJson(json.decode(str));
String apex_linkToJson(Apex_link data) => json.encode(data.toJson());
class Apex_link {
  Apex_link({
      String? hlsURL, 
      String? hls720pURL, 
      String? hls480pURL, 
      String? hls360pURL, 
      String? hls240pURL,}){
    _hlsURL = hlsURL;
    _hls720pURL = hls720pURL;
    _hls480pURL = hls480pURL;
    _hls360pURL = hls360pURL;
    _hls240pURL = hls240pURL;
}

  Apex_link.fromJson(dynamic json) {
    _hlsURL = json['hlsURL'];
    _hls720pURL = json['hls720pURL'];
    _hls480pURL = json['hls480pURL'];
    _hls360pURL = json['hls360pURL'];
    _hls240pURL = json['hls240pURL'];
  }
  String? _hlsURL;
  String? _hls720pURL;
  String? _hls480pURL;
  String? _hls360pURL;
  String? _hls240pURL;

  String? get hlsURL => _hlsURL;
  String? get hls720pURL => _hls720pURL;
  String? get hls480pURL => _hls480pURL;
  String? get hls360pURL => _hls360pURL;
  String? get hls240pURL => _hls240pURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hlsURL'] = _hlsURL;
    map['hls720pURL'] = _hls720pURL;
    map['hls480pURL'] = _hls480pURL;
    map['hls360pURL'] = _hls360pURL;
    map['hls240pURL'] = _hls240pURL;
    return map;
  }

}

/// _id : "623491f63e737b8d62111110"
/// title : "History"

Subject_id subject_idFromJson(String str) => Subject_id.fromJson(json.decode(str));
String subject_idToJson(Subject_id data) => json.encode(data.toJson());
class Subject_id {
  Subject_id({
      String? id,
      String? title,}){
    _id = id;
    _title = title;
}

  Subject_id.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;

  String? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    return map;
  }

}