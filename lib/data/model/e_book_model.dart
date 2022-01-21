import 'dart:convert';
/// statusCode : 200
/// books : [{"_id":"61e11b35ced0818afc943381","category":["61d2cc701cea2fdab6e9cb06","61d2cc8c1cea2fdab6e9cb07"],"title":"First Book","description":"First Book Description","amount":199,"flag":"Best Seller","macro":[],"logo_path":"book/1VU8cdQI-RAJASTHAN-SPECIAL.png","banner_path":"book/236071dE-banner_course_2.jpeg"}]
/// totalCount : 1

EBookModel e_book_modelFromJson(String str) => EBookModel.fromJson(json.decode(str));
String e_book_modelToJson(EBookModel data) => json.encode(data.toJson());
class EBookModel {
  EBookModel({
      int? statusCode, 
      List<EBooks>? books,
      int? totalCount,}){
    _statusCode = statusCode;
    _books = books;
    _totalCount = totalCount;
}

  EBookModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['books'] != null) {
      _books = [];
      json['books'].forEach((v) {
        _books?.add(EBooks.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<EBooks>? _books;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<EBooks>? get books => _books;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_books != null) {
      map['books'] = _books?.map((v) => v.toJson()).toList();
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

EBooks booksFromJson(String str) => EBooks.fromJson(json.decode(str));
String booksToJson(EBooks data) => json.encode(data.toJson());
class EBooks {
  EBooks({
      String? id, 
      List<String>? category, 
      String? title, 
      String? description, 
      int? amount, 
      String? flag, 
      List<Macro>? macro,
      String? logoPath, 
      String? bannerPath,}){
    _id = id;
    _category = category;
    _title = title;
    _description = description;
    _amount = amount;
    _flag = flag;
    _macro = macro;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
}

  EBooks.fromJson(dynamic json) {
    _id = json['_id'];
    _category = json['category'] != null ? json['category'].cast<String>() : [];
    _title = json['title'];
    _description = json['description'];
    _amount = json['amount'];
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
  int? _amount;
  String? _flag;
  List<Macro>? _macro;
  String? _logoPath;
  String? _bannerPath;

  String? get id => _id;
  List<String>? get category => _category;
  String? get title => _title;
  String? get description => _description;
  int? get amount => _amount;
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
    map['amount'] = _amount;
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