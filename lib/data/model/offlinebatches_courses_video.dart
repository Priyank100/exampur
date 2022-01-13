import 'dart:convert';
/// statusCode : 200
/// data : {"_id":"61de86f31869ec951c95d1dc","title":"Offline Course 2","banner_path":"course/12JNP4Uo-banner_course_2.jpeg","logo_path":"course/4tr0oUkb-logo_course_2.png","description":"Description for Course 2","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"is_emi":false,"is_demo":false,"flag":"Featured","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},"center_id":{"_id":"61dd6d0de3530aed60ffc81f","name":"Patna Center 1","city":"Patna"},"month_duration":6}

OfflinebatchesCoursesVideo offlinebatchesCoursesVideoFromJson(String str) => OfflinebatchesCoursesVideo.fromJson(json.decode(str));
String offlinebatchesCoursesVideoToJson(OfflinebatchesCoursesVideo data) => json.encode(data.toJson());
class OfflinebatchesCoursesVideo {
  OfflinebatchesCoursesVideo({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  OfflinebatchesCoursesVideo.fromJson(dynamic json) {
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

/// _id : "61de86f31869ec951c95d1dc"
/// title : "Offline Course 2"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"
/// logo_path : "course/4tr0oUkb-logo_course_2.png"
/// description : "Description for Course 2"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// amount : 1999
/// is_emi : false
/// is_demo : false
/// flag : "Featured"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// category : {"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"}
/// center_id : {"_id":"61dd6d0de3530aed60ffc81f","name":"Patna Center 1","city":"Patna"}
/// month_duration : 6

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? bannerPath, 
      String? logoPath, 
      String? description, 
      String? videoPath, 
      int? amount, 
      bool? isEmi, 
      bool? isDemo, 
      String? flag, 
      List<Macro>? macro, 
      Category? category, 
      Center_id? centerId, 
      int? monthDuration,}){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _videoPath = videoPath;
    _amount = amount;
    _isEmi = isEmi;
    _isDemo = isDemo;
    _flag = flag;
    _macro = macro;
    _category = category;
    _centerId = centerId;
    _monthDuration = monthDuration;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _videoPath = json['video_path'];
    _amount = json['amount'];
    _isEmi = json['is_emi'];
    _isDemo = json['is_demo'];
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _centerId = json['center_id'] != null ? Center_id.fromJson(json['centerId']) : null;
    _monthDuration = json['month_duration'];
  }
  String? _id;
  String? _title;
  String? _bannerPath;
  String? _logoPath;
  String? _description;
  String? _videoPath;
  int? _amount;
  bool? _isEmi;
  bool? _isDemo;
  String? _flag;
  List<Macro>? _macro;
  Category? _category;
  Center_id? _centerId;
  int? _monthDuration;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  int? get amount => _amount;
  bool? get isEmi => _isEmi;
  bool? get isDemo => _isDemo;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  Category? get category => _category;
  Center_id? get centerId => _centerId;
  int? get monthDuration => _monthDuration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['video_path'] = _videoPath;
    map['amount'] = _amount;
    map['is_emi'] = _isEmi;
    map['is_demo'] = _isDemo;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_centerId != null) {
      map['center_id'] = _centerId?.toJson();
    }
    map['month_duration'] = _monthDuration;
    return map;
  }

}

/// _id : "61dd6d0de3530aed60ffc81f"
/// name : "Patna Center 1"
/// city : "Patna"

Center_id center_idFromJson(String str) => Center_id.fromJson(json.decode(str));
String center_idToJson(Center_id data) => json.encode(data.toJson());
class Center_id {
  Center_id({
      String? id, 
      String? name, 
      String? city,}){
    _id = id;
    _name = name;
    _city = city;
}

  Center_id.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _city = json['city'];
  }
  String? _id;
  String? _name;
  String? _city;

  String? get id => _id;
  String? get name => _name;
  String? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['city'] = _city;
    return map;
  }

}

/// _id : "61d2cc701cea2fdab6e9cb06"
/// name : "ALL EXAMS"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
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