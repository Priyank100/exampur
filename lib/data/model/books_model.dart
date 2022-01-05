import 'dart:convert';
/// statusCode : 200
/// books : [{"_id":"61cdb58dec27a072279e1aab","title":"Book 3","banner_path":"https://downloadexampur.appx.co.in/product/0.65025852576535971619088364704.jpg","logo_path":"https://exampur.com/assets/images/logo/exampur-logo.png","description":"Description for Book 3","amount":0,"category":"Test Category","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"exam_category":null},{"_id":"61cdb59cec27a072279e1aac","title":"Book 4","banner_path":"https://downloadexampur.appx.co.in/product/0.65025852576535971619088364704.jpg","logo_path":"https://exampur.com/assets/images/logo/exampur-logo.png","description":"Description for Book 3","amount":399,"category":"Test Category","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"exam_category":null},{"_id":"61cdb5b6ec27a072279e1aad","title":"Book 3","banner_path":"https://downloadexampur.appx.co.in/product/0.65025852576535971619088364704.jpg","logo_path":"https://exampur.com/assets/images/logo/exampur-logo.png","description":"Description for Book 3","amount":499,"category":"Test Category","flag":"Featured","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"exam_category":null}]
/// totalCount : 3

BooksModel booksModelFromJson(String str) => BooksModel.fromJson(json.decode(str));
String booksModelToJson(BooksModel data) => json.encode(data.toJson());

class BooksModel {
  BooksModel({
      int? statusCode, 
      List<Books>? books, 
      int? totalCount,}){
    _statusCode = statusCode;
    _books = books;
    _totalCount = totalCount;
}

  BooksModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['books'] != null) {
      _books = [];
      json['books'].forEach((v) {
        _books?.add(Books.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Books>? _books;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Books>? get books => _books;
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

/// _id : "61cdb58dec27a072279e1aab"
/// title : "Book 3"
/// banner_path : "https://downloadexampur.appx.co.in/product/0.65025852576535971619088364704.jpg"
/// logo_path : "https://exampur.com/assets/images/logo/exampur-logo.png"
/// description : "Description for Book 3"
/// amount : 0
/// category : "Test Category"
/// flag : "New"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// exam_category : null

Books booksFromJson(String str) => Books.fromJson(json.decode(str));
String booksToJson(Books data) => json.encode(data.toJson());
class Books {
  Books({
      String? id, 
      String? title, 
      String? bannerPath, 
      String? logoPath, 
      String? description, 
      int? amount, 
      String? category, 
      String? flag, 
      List<Macro>? macro, 
      dynamic examCategory,}){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _amount = amount;
    _category = category;
    _flag = flag;
    _macro = macro;
    _examCategory = examCategory;
}

  Books.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _amount = json['amount'];
    _category = json['category'];
    _flag = json['flag'];
    if (json['macro'] != null) {
      _macro = [];
      json['macro'].forEach((v) {
        _macro?.add(Macro.fromJson(v));
      });
    }
    _examCategory = json['exam_category'];
  }
  String? _id;
  String? _title;
  String? _bannerPath;
  String? _logoPath;
  String? _description;
  int? _amount;
  String? _category;
  String? _flag;
  List<Macro>? _macro;
  dynamic _examCategory;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  int? get amount => _amount;
  String? get category => _category;
  String? get flag => _flag;
  List<Macro>? get macro => _macro;
  dynamic get examCategory => _examCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['amount'] = _amount;
    map['category'] = _category;
    map['flag'] = _flag;
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    map['exam_category'] = _examCategory;
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