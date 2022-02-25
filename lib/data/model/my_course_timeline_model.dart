import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"620e3004304b1a6aff05e660","subject_id":{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"},"title":"asd","description":"asd","logo_path":"course_timeline/tpgZQcFk-Screenshot-2022-02-13-at-2-34-26-PM-png","type":"Livesteam","target_link":"asd","schedule":"2022-02-17T18:30:00.000Z","is_demo":true,"chapter_name":"Test Chapter here"}]

MyCourseTimelineModel myCourseTimelineModelFromJson(String str) => MyCourseTimelineModel.fromJson(json.decode(str));
String myCourseTimelineModelToJson(MyCourseTimelineModel data) => json.encode(data.toJson());
class MyCourseTimelineModel {
  MyCourseTimelineModel({
      int? statusCode, 
      List<TimelineData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseTimelineModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TimelineData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<TimelineData>? _data;

  int? get statusCode => _statusCode;
  List<TimelineData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "620e3004304b1a6aff05e660"
/// subject_id : {"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"}
/// title : "asd"
/// description : "asd"
/// logo_path : "course_timeline/tpgZQcFk-Screenshot-2022-02-13-at-2-34-26-PM-png"
/// type : "Livesteam"
/// target_link : "asd"
/// schedule : "2022-02-17T18:30:00.000Z"
/// is_demo : true
/// chapter_name : "Test Chapter here"

TimelineData dataFromJson(String str) => TimelineData.fromJson(json.decode(str));
String dataToJson(TimelineData data) => json.encode(data.toJson());
class TimelineData {
  TimelineData({
      String? id, 
      Subject_id? subjectId, 
      String? title, 
      String? description, 
      String? logoPath, 
      String? type, 
      String? targetLink, 
      String? schedule, 
      bool? isDemo, 
      String? chapterName,}){
    _id = id;
    _subjectId = subjectId;
    _title = title;
    _description = description;
    _logoPath = logoPath;
    _type = type;
    _targetLink = targetLink;
    _schedule = schedule;
    _isDemo = isDemo;
    _chapterName = chapterName;
}

  TimelineData.fromJson(dynamic json) {
    _id = json['_id'];
    _subjectId = json['subject_id'] != null ? Subject_id.fromJson(json['subject_id']) : null;
    _title = json['title'];
    _description = json['description'];
    _logoPath = json['logo_path'];
    _type = json['type'];
    _targetLink = json['target_link'];
    _schedule = json['schedule'];
    _isDemo = json['is_demo'];
    _chapterName = json['chapter_name'];
  }
  String? _id;
  Subject_id? _subjectId;
  String? _title;
  String? _description;
  String? _logoPath;
  String? _type;
  String? _targetLink;
  String? _schedule;
  bool? _isDemo;
  String? _chapterName;

  String? get id => _id;
  Subject_id? get subjectId => _subjectId;
  String? get title => _title;
  String? get description => _description;
  String? get logoPath => _logoPath;
  String? get type => _type;
  String? get targetLink => _targetLink;
  String? get schedule => _schedule;
  bool? get isDemo => _isDemo;
  String? get chapterName => _chapterName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_subjectId != null) {
      map['subject_id'] = _subjectId?.toJson();
    }
    map['title'] = _title;
    map['description'] = _description;
    map['logo_path'] = _logoPath;
    map['type'] = _type;
    map['target_link'] = _targetLink;
    map['schedule'] = _schedule;
    map['is_demo'] = _isDemo;
    map['chapter_name'] = _chapterName;
    return map;
  }

}

/// _id : "61da9cb904d40f7873b61f2e"
/// title : "First Subject"

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