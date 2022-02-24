import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject","description":"First Subject Description - Hello World","logo_path":"course_subject/VyJW2LP9-RAJASTHAN-SPECIAL.png"}]

MyCourseSubjectModel myCourseSubjectModelFromJson(String str) => MyCourseSubjectModel.fromJson(json.decode(str));
String myCourseSubjectModelToJson(MyCourseSubjectModel data) => json.encode(data.toJson());
class MyCourseSubjectModel {
  MyCourseSubjectModel({
      int? statusCode, 
      List<SubjectData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseSubjectModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SubjectData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<SubjectData>? _data;

  int? get statusCode => _statusCode;
  List<SubjectData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "61da9cb904d40f7873b61f2e"
/// title : "First Subject"
/// description : "First Subject Description - Hello World"
/// logo_path : "course_subject/VyJW2LP9-RAJASTHAN-SPECIAL.png"

SubjectData dataFromJson(String str) => SubjectData.fromJson(json.decode(str));
String dataToJson(SubjectData data) => json.encode(data.toJson());
class SubjectData {
  SubjectData({
      String? id, 
      String? title, 
      String? description, 
      String? logoPath,}){
    _id = id;
    _title = title;
    _description = description;
    _logoPath = logoPath;
}

  SubjectData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _logoPath = json['logo_path'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _logoPath;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get logoPath => _logoPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['logo_path'] = _logoPath;
    return map;
  }

}