import 'dart:convert';
/// statusCode : 200
/// courses : [{"_id":"61c98f583a7d50ce67803ee9","title":"Course 3","banner_path":"banner_path_1.jpg","logo_path":"logo_path_1.jpg","description":"Description for Course 3","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]},{"_id":"61c98f613a7d50ce67803eea","title":"Course 4","banner_path":"banner_path_1.jpg","logo_path":"logo_path_1.jpg","description":"Description for Course 4","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]}]
/// totalCount : 2

PaidCourseModel paidCourseModelFromJson(String str) => PaidCourseModel.fromJson(json.decode(str));
String paidCourseModelToJson(PaidCourseModel data) => json.encode(data.toJson());
class PaidCourseModel {
  PaidCourseModel({
      int? statusCode,
      List<Courses>? courses,
      int? totalCount,}){
    _statusCode = statusCode;
    _courses = courses;
    _totalCount = totalCount;
}

  PaidCourseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _courses = [];
      json['data'].forEach((v) {
        _courses?.add(Courses.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Courses>? _courses;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Courses>? get courses => _courses;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_courses != null) {
      map['data'] = _courses?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61c98f583a7d50ce67803ee9"
/// title : "Course 3"
/// banner_path : "banner_path_1.jpg"
/// logo_path : "logo_path_1.jpg"
/// description : "Description for Course 3"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// amount : 1999
/// flag : "New"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]

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
      int? amount,
      String? flag,
      List<Macro>? macro,}){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _videoPath = videoPath;
    _amount = amount;
    _flag = flag;
    _macro = macro;
}

  Courses.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _videoPath = json['video_path'];
    _amount = json['amount'];
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  String? _bannerPath;
  String? _logoPath;
  String? _description;
  String? _videoPath;
  int? _amount;
  String? _flag;
  List<Macro>? _macro;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  int? get amount => _amount;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['video_path'] = _videoPath;
    map['amount'] = _amount;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
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