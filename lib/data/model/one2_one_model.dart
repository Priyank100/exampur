import 'dart:convert';
/// statusCode : 200
/// courses : [{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","banner_path":"banner_path_1.jpg","logo_path":"logo_path_1.jpg","description":"Description for Course 1","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}},{"_id":"61c98f4f3a7d50ce67803ee8","title":"Course 2","banner_path":"https://downloadexampur.appx.co.in/paid_course/0.0618913895695287761640973487144.jpeg","logo_path":"https://downloadexampur.appx.co.in/paid_course/0.9844409933133141640973457488.png","description":"Description for Course 2","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","amount":1999,"flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}}]
/// totalCount : 2

One2OneModel one2OneModelFromJson(String str) => One2OneModel.fromJson(json.decode(str));
String one2OneModelToJson(One2OneModel data) => json.encode(data.toJson());
class One2OneModel {
  One2OneModel({
      int? statusCode, 
      List<Courses>? courses, 
      int? totalCount,}){
    _statusCode = statusCode;
    _courses = courses;
    _totalCount = totalCount;
}

  One2OneModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['courses'] != null) {
      _courses = [];
      json['courses'].forEach((v) {
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
      map['courses'] = _courses?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// banner_path : "banner_path_1.jpg"
/// logo_path : "logo_path_1.jpg"
/// description : "Description for Course 1"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// amount : 1999
/// flag : "New"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// category : {"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}

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
      Category? category,}){
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
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
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
  Category? _category;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  int? get amount => _amount;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  Category? get category => _category;

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
      map['category'] = _category?.toJson();
    }
    return map;
  }

}

/// _id : "61d2cc8c1cea2fdab6e9cb07"
/// name : "RAJASTHAN SPECIAL"

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