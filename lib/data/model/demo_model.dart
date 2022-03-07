import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"620e3004304b1a6aff05e660","course_id":{"_id":"61c98d223a7d50ce67803edb","title":"Course 1"},"subject_id":{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"},"title":"asd","description":"asd","logo_path":"course_timeline/tpgZQcFk-Screenshot-2022-02-13-at-2-34-26-PM-png","type":"Zoom","target_link":"asd","schedule":"2022-03-17T18:30:00.000Z"},{"_id":"620a4c413517d705ce72ff9b","course_id":null,"subject_id":{"_id":"620a4bdd3517d705ce72ff83","title":"Demo"},"title":"AA","description":"AA","logo_path":"course_timeline/fMAZE6Jd-Screenshot-2022-02-13-at-2-34-20-PM-png","type":"Livesteam","target_link":"AA","schedule":"2022-03-14T18:30:00.000Z"}]

DemoModel demoModelFromJson(String str) => DemoModel.fromJson(json.decode(str));
String demoModelToJson(DemoModel data) => json.encode(data.toJson());
class DemoModel {
  DemoModel({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DemoModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Data>? _data;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;

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
/// course_id : {"_id":"61c98d223a7d50ce67803edb","title":"Course 1"}
/// subject_id : {"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"}
/// title : "asd"
/// description : "asd"
/// logo_path : "course_timeline/tpgZQcFk-Screenshot-2022-02-13-at-2-34-26-PM-png"
/// type : "Zoom"
/// target_link : "asd"
/// schedule : "2022-03-17T18:30:00.000Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      Course_id? courseId, 
      Subject_id? subjectId, 
      String? title, 
      String? description, 
      String? logoPath, 
      String? type, 
      String? targetLink, 
      String? schedule,}){
    _id = id;
    _courseId = courseId;
    _subjectId = subjectId;
    _title = title;
    _description = description;
    _logoPath = logoPath;
    _type = type;
    _targetLink = targetLink;
    _schedule = schedule;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _courseId = json['course_id'] != null ? Course_id.fromJson(json['courseId']) : null;
    _subjectId = json['subject_id'] != null ? Subject_id.fromJson(json['subjectId']) : null;
    _title = json['title'];
    _description = json['description'];
    _logoPath = json['logo_path'];
    _type = json['type'];
    _targetLink = json['target_link'];
    _schedule = json['schedule'];
  }
  String? _id;
  Course_id? _courseId;
  Subject_id? _subjectId;
  String? _title;
  String? _description;
  String? _logoPath;
  String? _type;
  String? _targetLink;
  String? _schedule;

  String? get id => _id;
  Course_id? get courseId => _courseId;
  Subject_id? get subjectId => _subjectId;
  String? get title => _title;
  String? get description => _description;
  String? get logoPath => _logoPath;
  String? get type => _type;
  String? get targetLink => _targetLink;
  String? get schedule => _schedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_courseId != null) {
      map['course_id'] = _courseId?.toJson();
    }
    if (_subjectId != null) {
      map['subject_id'] = _subjectId?.toJson();
    }
    map['title'] = _title;
    map['description'] = _description;
    map['logo_path'] = _logoPath;
    map['type'] = _type;
    map['target_link'] = _targetLink;
    map['schedule'] = _schedule;
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

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"

Course_id course_idFromJson(String str) => Course_id.fromJson(json.decode(str));
String course_idToJson(Course_id data) => json.encode(data.toJson());
class Course_id {
  Course_id({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Course_id.fromJson(dynamic json) {
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