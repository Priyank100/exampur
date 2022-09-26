import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"620e926277751ef02cb8c0e7","category":[{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61cad845da1d8532b6f33fd1","name":"HARYANA SPECIAL"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}],"title":"Book 1","description":"Demo B 1","regular_price":1,"sale_price":1,"flag":"New","macro":[],"banner_path":"book/zQGtizT1-Screenshot-2022-02-14-at-5-24-46-PM-png","logo_path":"book/opsTZQxm-Screenshot-2022-02-13-at-2-34-16-PM-png"}]
/// totalCount : 1

EBookModel eBookModelFromJson(String str) => EBookModel.fromJson(json.decode(str));
String eBookModelToJson(EBookModel data) => json.encode(data.toJson());
class EBookModel {
  EBookModel({
      int? statusCode, 
      List<BookEbook>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  EBookModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BookEbook.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<BookEbook>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<BookEbook>? get data => _data;
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

/// _id : "620e926277751ef02cb8c0e7"
/// category : [{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61cad845da1d8532b6f33fd1","name":"HARYANA SPECIAL"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}]
/// title : "Book 1"
/// description : "Demo B 1"
/// regular_price : 1
/// sale_price : 1
/// flag : "New"
/// macro : []
/// banner_path : "book/zQGtizT1-Screenshot-2022-02-14-at-5-24-46-PM-png"
/// logo_path : "book/opsTZQxm-Screenshot-2022-02-13-at-2-34-16-PM-png"

BookEbook dataFromJson(String str) => BookEbook.fromJson(json.decode(str));
String dataToJson(BookEbook data) => json.encode(data.toJson());
class BookEbook {
  BookEbook({
      String? id, 
      List<Category>? category, 
      String? title, 
      String? description,
      String? pdf,
      double? regularPrice,
      double? salePrice,
      String? flag, 
      List<dynamic>? macro, 
      String? bannerPath, 
      String? logoPath,
    String? status,
  }){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _pdf = pdf! ;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _flag = flag;
    _macro = macro;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _status = status ;
}

  BookEbook.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
    _title = json['title'];
    _description = json['description'];
    _pdf = json['pdf_path'];
    _regularPrice = json['regular_price'].toDouble();
    _salePrice = json['sale_price'].toDouble();
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _status = json['status']==null?'Published':json['status'].toString();
  }
  String? _id;
  List<Category>? _category;
  String? _title;
  String? _description;
  String? _pdf ;
  double? _regularPrice;
  double? _salePrice;
  String? _flag;
  List<dynamic>? _macro;
  String? _bannerPath;
  String? _logoPath;
  String? _status;

  String? get id => _id;
  List<Category>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  String? get pdf => _pdf ;
  double? get regularPrice => _regularPrice;
  double? get salePrice => _salePrice;
  String? get flag => _flag;
  List<dynamic>? get macro => _macro;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    map['title'] = _title;
    map['description'] = _description;
    map['pdf_path'] = _pdf ;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['status'] = _status;
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