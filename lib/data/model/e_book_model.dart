import 'dart:convert';
/// statusCode : 200
/// books : [{"_id":"61e11b35ced0818afc943381","category":["61d2cc701cea2fdab6e9cb06","61d2cc8c1cea2fdab6e9cb07"],"title":"First Book","description":"First Book Description","amount":199,"flag":"Best Seller","macro":[],"logo_path":"book/1VU8cdQI-RAJASTHAN-SPECIAL.png","banner_path":"book/236071dE-banner_course_2.jpeg"}]
/// totalCount : 1

EBookModel e_book_modelFromJson(String str) => EBookModel.fromJson(json.decode(str));
String e_book_modelToJson(EBookModel data) => json.encode(data.toJson());
class EBookModel {
  EBookModel({
      int? statusCode,
      List<Data>? data,
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
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Data>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['books'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61e11b35ced0818afc943381"
/// category : ["61d2cc701cea2fdab6e9cb06","61d2cc8c1cea2fdab6e9cb07"]
/// title : "First Book"
/// description : "First Book Description"
/// amount : 199
/// flag : "Best Seller"
/// macro : []
/// logo_path : "book/1VU8cdQI-RAJASTHAN-SPECIAL.png"
/// banner_path : "book/236071dE-banner_course_2.jpeg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id,
      List<String>? category,
      String? title,
      String? description,
      int? regular_price,
    int? sale_price,
      String? flag,
      List<Macro>? macro,
      String? logoPath,
      String? bannerPath,}){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _regular_price = regular_price;
    _flag = flag;
    _macro = macro;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? json['category'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _regular_price = json['regular_price'];
    _sale_price = json['sale_price'];
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _logoPath = json['logo_path'];
    _bannerPath = json['banner_path'];
  }
  String? _id;
  List<String>? _category;
  String? _title;
  String? _description;
  int? _regular_price;
  int? _sale_price;
  String? _flag;
  List<Macro>? _macro;
  String? _logoPath;
  String? _bannerPath;

  String? get id => _id;
  List<String>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  int? get regular_price => _regular_price;
  int? get sale_price => _sale_price;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  String? get logoPath => _logoPath;
  String? get bannerPath => _bannerPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['description'] = _description;
    map['regular_price'] = _regular_price;
    map['sale_price'] = _sale_price;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['logo_path'] = _logoPath;
    map['banner_path'] = _bannerPath;
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