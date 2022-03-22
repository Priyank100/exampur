import 'dart:convert';
/// statusCode : 200
/// data : ["Ch 1","Ch 2","Ch1"]

TeacherChapterModel teacherChapterModelFromJson(String str) => TeacherChapterModel.fromJson(json.decode(str));
String teacherChapterModelToJson(TeacherChapterModel data) => json.encode(data.toJson());
class TeacherChapterModel {
  TeacherChapterModel({
      int? statusCode, 
      List<String>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  TeacherChapterModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? json['data'].cast<String>() : [];
  }
  int? _statusCode;
  List<String>? _data;

  int? get statusCode => _statusCode;
  List<String>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['data'] = _data;
    return map;
  }

}