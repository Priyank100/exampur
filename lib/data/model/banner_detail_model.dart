import 'dart:convert';

import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/data/model/upsell_book.dart';
/// statusCode : 200
/// data : {"_id":"61c98f8c3a7d50ce67803ef0","title":"Course 10","banner_path":"course/Sg0lFoGd-banner_course_2.jpeg","logo_path":"course/CnFUqrw1-logo_course_2.png","description":"Description for Course 10","video_path":"https://www.youtube.com/watch?v=ZoOwI3P5POo","flag":"New","macro":[{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}],"category":[{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}],"regular_price":2999,"sale_price":999}

BannerDetailModel bannerdetailmodelFromJson(String str) => BannerDetailModel.fromJson(json.decode(str));
String bannerdetailmodelToJson(BannerDetailModel data) => json.encode(data.toJson());

class BannerDetailModel {
  BannerDetailModel({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  BannerDetailModel.fromJson(dynamic json) {
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

/// _id : "61c98f8c3a7d50ce67803ef0"
/// title : "Course 10"
/// banner_path : "course/Sg0lFoGd-banner_course_2.jpeg"
/// logo_path : "course/CnFUqrw1-logo_course_2.png"
/// description : "Description for Course 10"
/// video_path : "https://www.youtube.com/watch?v=ZoOwI3P5POo"
/// flag : "New"
/// macro : [{"icon":"right-tik","title":"Feature 1"},{"icon":"right-tik","title":"Feature 2"}]
/// category : [{"_id":"61d2cc701cea2fdab6e9cb06","name":"ALL EXAMS"},{"_id":"61d2cc8c1cea2fdab6e9cb07","name":"RAJASTHAN SPECIAL"}]
/// regular_price : 2999
/// sale_price : 999

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
      String? flag,
    List<UpsellBook>? upsellBook,
    List<Macro>? macro,
      List<Category>? category, 
      int? regularPrice, 
      int? salePrice,
    String? pdfPath,
    String? status,
    PreBookDetail? preBookDetail,
  }){
    _id = id;
    _title = title;
    _bannerPath = bannerPath;
    _logoPath = logoPath;
    _description = description;
    _videoPath = videoPath;
    _flag = flag;
    _upsellBook = upsellBook;
    _macro = macro;
    _category = category;
    _regularPrice = regularPrice;
    _salePrice = salePrice;
    _pdfPath = pdfPath;
    _status = status;
    _preBookDetail = preBookDetail;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _bannerPath = json['banner_path'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _videoPath = json['video_path'];
    _flag = json['flag'];
    if (json['upsell_book'] != null) {
      _upsellBook = [];
      json['upsell_book'].forEach((v) {
        _upsellBook?.add(UpsellBook.fromJson(v));
      });
    }
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
    _regularPrice = json['regular_price'];
    _salePrice = json['sale_price'];
    _pdfPath = json['pdf_path'];
    _status = json['status'] ?? 'Published';
    _preBookDetail = json['prebook_details'] == null ? null : PreBookDetail.fromJson(json["prebook_details"]);
  }
  String? _id;
  String? _title;
  String? _bannerPath;
  String? _logoPath;
  String? _description;
  String? _videoPath;
  String? _flag;
  List<UpsellBook>? _upsellBook;
  List<Macro>? _macro;
  List<Category>? _category;
  int? _regularPrice;
  int? _salePrice;
  String? _pdfPath;
  String? _status;
  PreBookDetail? _preBookDetail;

  String? get id => _id;
  String? get title => _title;
  String? get bannerPath => _bannerPath;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get videoPath => _videoPath;
  String? get flag => _flag;
  List<UpsellBook>? get upsellBook => _upsellBook;
  List<Macro>? get macro => _macro;
  List<Category>? get category => _category;
  int? get regularPrice => _regularPrice;
  int? get salePrice => _salePrice;
  String? get pdfPath => _pdfPath;
  String? get status => _status;
  PreBookDetail? get preBookDetail => _preBookDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['banner_path'] = _bannerPath;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['video_path'] = _videoPath;
    map['flag'] = _flag;
    if (_upsellBook != null) {
      map['upsell_book'] = _upsellBook?.map((v) => v.toJson()).toList();
    }
    if (_macro != null) {
      map['macro'] = _macro?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    map['regular_price'] = _regularPrice;
    map['sale_price'] = _salePrice;
    map['pdf_path'] = _pdfPath;
    map['status'] = _status;
    map['prebook_details'] = _preBookDetail;
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