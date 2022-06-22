import 'dart:convert';

/// _id : "6254b5cc526cbd38aa7a34e4"
/// category : ["624d21298e64bc5e0e75f32f","624d21298e64bc5e0e75f32e"]
/// title : "HARYANA CET 11 PRACTICE SET"
/// description : "HARYANA CET 11 PRACTICE SET"
/// sort_weightage : -121
/// regular_price : 99
/// sale_price : 99
/// is_ebook : false
/// flag : "N/A"
/// status : "Published"
/// macro : []
/// created_at : "2022-04-11T23:12:12.075Z"
/// updated_at : "2022-04-11T23:12:12.075Z"
/// datetime_old : "2022-03-22 19:39:38"
/// banner_path : "normalData/book/DATE_11042022__product/0.056957376546582281647958163555.png"
/// old_id : "117"

UpsellBook upsellBookFromJson(String str) => UpsellBook.fromJson(json.decode(str));
String upsellBookToJson(UpsellBook data) => json.encode(data.toJson());
class UpsellBook {
  UpsellBook({
    String? id,
    List<String>? category,
    String? title,
    String? description,
    int? sortWeightage,
    int? regularPrice,
    int? salePrice,
    bool? isEbook,
    String? flag,
    String? status,
    List<dynamic>? macro,
    String? createdAt,
    String? updatedAt,
    String? datetimeOld,
    String? bannerPath,
    String? oldId,}){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _sortWeightage = sortWeightage;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _isEbook = isEbook;
    _flag = flag;
    _status = status;
    _macro = macro;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _datetimeOld = datetimeOld;
    _bannerPath = bannerPath;
    _oldId = oldId;
  }

  UpsellBook.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? json['category'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _sortWeightage = json['sort_weightage'];
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    _isEbook = json['is_ebook'];
    _flag = json['flag'];
    _status = json['status'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _datetimeOld = json['datetime_old'];
    _bannerPath = json['banner_path'];
    _oldId = json['old_id'];
  }
  String? _id;
  List<String>? _category;
  String? _title;
  String? _description;
  int? _sortWeightage;
  int? _regularPrice;
  int? _salePrice;
  bool? _isEbook;
  String? _flag;
  String? _status;
  List<dynamic>? _macro;
  String? _createdAt;
  String? _updatedAt;
  String? _datetimeOld;
  String? _bannerPath;
  String? _oldId;

  String? get id => _id;
  List<String>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  int? get sortWeightage => _sortWeightage;
  int? get regularPrice => _regularPrice;
  int? get salePrice => _salePrice;
  bool? get isEbook => _isEbook;
  String? get flag => _flag;
  String? get status => _status;
  List<dynamic>? get macro => _macro;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get datetimeOld => _datetimeOld;
  String? get bannerPath => _bannerPath;
  String? get oldId => _oldId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category'] = _category;
    map['title'] = _title;
    map['description'] = _description;
    map['sort_weightage'] = _sortWeightage;
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['is_ebook'] = _isEbook;
    map['flag'] = _flag;
    map['status'] = _status;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['datetime_old'] = _datetimeOld;
    map['banner_path'] = _bannerPath;
    map['old_id'] = _oldId;
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