import 'dart:convert';
/// statusCode : 200
/// data : {"_id":"6238d9f9944a5206ec64c0cc","course_id":"6232b9caba12feaa99efbbf9","is_demo":true,"apex_link":{"hlsURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078.m3u8","hls720pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_720p1128kbs/index.m3u8","hls480pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_480p878kbs/index.m3u8","hls360pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_360p528kbs/index.m3u8","hls240pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_240p264kbs/index.m3u8"},"liveStreamStatus":false}

CourseTimelineLiveStreamModel courseTimelineLiveStreamModelFromJson(String str) => CourseTimelineLiveStreamModel.fromJson(json.decode(str));
String courseTimelineLiveStreamModelToJson(CourseTimelineLiveStreamModel data) => json.encode(data.toJson());
class CourseTimelineLiveStreamModel {
  CourseTimelineLiveStreamModel({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  CourseTimelineLiveStreamModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  Data? _data;

  int? get statusCode => _statusCode;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// _id : "6238d9f9944a5206ec64c0cc"
/// course_id : "6232b9caba12feaa99efbbf9"
/// is_demo : true
/// apex_link : {"hlsURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078.m3u8","hls720pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_720p1128kbs/index.m3u8","hls480pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_480p878kbs/index.m3u8","hls360pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_360p528kbs/index.m3u8","hls240pURL":"https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_240p264kbs/index.m3u8"}
/// liveStreamStatus : false

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? courseId, 
      bool? isDemo, 
      Apex_link? apexLink, 
      bool? liveStreamStatus,}){
    _id = id;
    _courseId = courseId;
    _isDemo = isDemo;
    _apexLink = apexLink;
    _liveStreamStatus = liveStreamStatus;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _courseId = json['course_id'];
    _isDemo = json['is_demo'];
    _apexLink = json['apex_link'] != null ? Apex_link.fromJson(json['apex_link']) : null;
    _liveStreamStatus = json['liveStreamStatus'];
  }
  String? _id;
  String? _courseId;
  bool? _isDemo;
  Apex_link? _apexLink;
  bool? _liveStreamStatus;

  String? get id => _id;
  String? get courseId => _courseId;
  bool? get isDemo => _isDemo;
  Apex_link? get apexLink => _apexLink;
  bool? get liveStreamStatus => _liveStreamStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['course_id'] = _courseId;
    map['is_demo'] = _isDemo;
    if (_apexLink != null) {
      map['apex_link'] = _apexLink?.toJson();
    }
    map['liveStreamStatus'] = _liveStreamStatus;
    return map;
  }

}

/// hlsURL : "https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078.m3u8"
/// hls720pURL : "https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_720p1128kbs/index.m3u8"
/// hls480pURL : "https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_480p878kbs/index.m3u8"
/// hls360pURL : "https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_360p528kbs/index.m3u8"
/// hls240pURL : "https://dcga6fn5s6xlr.cloudfront.net/mnt/hls/867099078_240p264kbs/index.m3u8"

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