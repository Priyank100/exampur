import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"},{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"},{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}]

MyCourseListModel myCourseListModelFromJson(String str) => MyCourseListModel.fromJson(json.decode(str));
String myCourseListModelToJson(MyCourseListModel data) => json.encode(data.toJson());
class MyCourseListModel {
  MyCourseListModel({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseListModel.fromJson(dynamic json) {
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

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// logo_path : "course/DGUKTpZX-logo_exampur.png"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? logoPath, 
      String? bannerPath,}){
    _id = id;
    _title = title;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
    _bannerPath = json['banner_path'];
  }
  String? _id;
  String? _title;
  String? _logoPath;
  String? _bannerPath;

  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;
  String? get bannerPath => _bannerPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    map['banner_path'] = _bannerPath;
    return map;
  }

}