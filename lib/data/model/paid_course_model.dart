import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","banner_path":"course/12JNP4Uo-banner_course_2.jpeg","logo_path":"course/DGUKTpZX-logo_exampur.png","description":"Description for Course 1","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","flag":"Featured","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"regular_price":1999,"sale_price":1999},{"_id":"61c98f683a7d50ce67803eeb","title":"Course 5","banner_path":"course/fjLMxz7U-banner_course_2.jpeg","logo_path":"course/Pa2eiWbA-logo_course_2.png","description":"Description for Course 5","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"regular_price":2999,"sale_price":1999},{"_id":"61c98fa03a7d50ce67803ef4","title":"Course 14","banner_path":"course/ZWLN6V9a-banner_course_2.jpeg","logo_path":"course/lgjvYIge-logo_course_2.png","description":"Description for Course 14","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"regular_price":1990,"sale_price":1990},{"_id":"61c98fa63a7d50ce67803ef5","title":"Course 15","banner_path":"course/hVYftcnm-banner_course_2.jpeg","logo_path":"course/0GGCf5qj-logo_course_2.png","description":"Description for Course 15","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"regular_price":1880,"sale_price":1880}]
/// totalCount : 4

PaidCourseModel paidCourseModelFromJson(String str) => PaidCourseModel.fromJson(json.decode(str));
String paidCourseModelToJson(PaidCourseModel data) => json.encode(data.toJson());
class PaidCourseModel {
  PaidCourseModel({
    int? statusCode,
    List<Courses>? data,
    int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
  }

  PaidCourseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Courses.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Courses>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Courses>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['courses'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}
/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"
/// logo_path : "course/DGUKTpZX-logo_exampur.png"
/// description : "Description for Course 1"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// flag : "Featured"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// regular_price : 1999
/// sale_price : 1999

Courses coursesFromJson(String str) => Courses.fromJson(json.decode(str));
String coursesToJson(Courses data) => json.encode(data.toJson());
class Courses {
  Courses({
    String? id,
    String? title,
    String? bannerPath,
    String? logoPath,
    String? description,
    String? videoPath,
    String? flag,
    List<Macro>? macro,
    int? regularPrice,
    int? salePrice,}){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _videoPath = videoPath;
    _flag = flag;
    _macro = macro;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
  }

  Courses.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _videoPath = json['video_path'];
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
  }
  String? _id;
  String? _title;
  String? _bannerPath;
  String? _logoPath;
  String? _description;
  String? _videoPath;
  String? _flag;
  List<Macro>? _macro;
  int? _regularPrice;
  int? _salePrice;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  int? get regularPrice => _regularPrice;
  int? get salePrice => _salePrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['video_path'] = _videoPath;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    return map;
  }

}

/// icon : "right-tik"
/// title : "Feature 1"

Macro macroFromJson(String str) => Macro.fromJson(json.decode(str));
String macroToJson(Macro data) => json.encode(data.toJson());
class Macro {
  Macro({
    String? icon,
    String? title,}){
    _icon = icon;
    _title = title;
  }

  Macro.fromJson(dynamic json) {
    _icon = json['icon'];
    _title = json['title'];
  }
  String? _icon;
  String? _title;

  String? get icon => _icon;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = _icon;
    map['title'] = _title;
    return map;
  }

}