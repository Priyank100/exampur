import 'dart:convert';
/// statusCode : 200
/// courses : [{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","banner_path":"course/12JNP4Uo-banner_course_2.jpeg","logo_path":"course/4tr0oUkb-logo_course_2.png","description":"Description for Course 1","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":[{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61cad845da1d8532b6f33fd1","name":"HARYANA SPECIAL"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}]},{"_id":"61c98f4f3a7d50ce67803ee8","title":"Course 2","banner_path":"course/wHJS3Pso-banner_course_2.jpeg","logo_path":"course/zmJdXCAY-logo_course_2.png","description":"Description for Course 2","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":[{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"},{"_id":"61d2cca81cea2fdab6e9cb08","name":"POLICE EXAMS"}]}]
/// totalCount : 2

One2OneModels one2OneModelsFromJson(String str) => One2OneModels.fromJson(json.decode(str));
String one2OneModelsToJson(One2OneModels data) => json.encode(data.toJson());
class One2OneModels {
  One2OneModels({
      int? statusCode, 
      List<Courses>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  One2OneModels.fromJson(dynamic json) {
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
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"
/// logo_path : "course/4tr0oUkb-logo_course_2.png"
/// description : "Description for Course 1"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// amount : 1999
/// flag : "New"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// category : [{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61cad845da1d8532b6f33fd1","name":"HARYANA SPECIAL"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}]

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
      List<Macro>? macro, 
      List<Category>? category,}){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _videoPath = videoPath;
    _amount = amount;
    _flag = flag;
    _macro = macro;
    _category = category;
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
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
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
  List<Category>? _category;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  int? get amount => _amount;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  List<Category>? get category => _category;

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
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
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