import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61fa769102ada41f40916e5f","order_no":18,"amount":1999,"product":{"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}},{"_id":"61fb690002ada41f40916e8c","order_no":20,"amount":1999,"product":{"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}},{"_id":"61fcd01602ada41f40916f7e","order_no":21,"amount":1999,"product":{"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}},{"_id":"61fb66ce02ada41f40916e6e","order_no":26,"amount":1999,"product":{"type":"Book","_id":"61e11b35ced0818afc943381","title":"First EBook","logo_path":"book/6PxhY8af-logo_exampur.png","banner_path":null}}]

MyPurchaseModel myPurchaseModelFromJson(String str) => MyPurchaseModel.fromJson(json.decode(str));
String myPurchaseModelToJson(MyPurchaseModel data) => json.encode(data.toJson());
class MyPurchaseModel {
  MyPurchaseModel({
    int? statusCode,
    List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
  }

  MyPurchaseModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Data>? _data;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "61fa769102ada41f40916e5f"
/// order_no : 18
/// amount : 1999
/// product : {"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? id,
    String? orderNo,
    int? amount,
    Product? product,}){
    _id = id;
    _orderNo = orderNo;
    _amount = amount;
    _product = product;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _orderNo = json['order_no'].toString();
    _amount = json['amount'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  String? _id;
  String? _orderNo;
  int? _amount;
  Product? _product;

  String? get id => _id;
  String? get orderNo => _orderNo;
  int? get amount => _amount;
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['order_no'] = _orderNo;
    map['amount'] = _amount;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    return map;
  }

}

/// type : "Course"
/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// logo_path : "course/DGUKTpZX-logo_exampur.png"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
    String? type,
    String? id,
    String? title,
    String? logoPath,
    String? bannerPath,}){
    _type = type;
    _id = id;
    _title = title;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
  }

  Product.fromJson(dynamic json) {
    _type = json['type'];
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
    _bannerPath = json['banner_path'];
  }
  String? _type;
  String? _id;
  String? _title;
  String? _logoPath;
  String? _bannerPath;

  String? get type => _type;
  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;
  String? get bannerPath => _bannerPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    map['banner_path'] = _bannerPath;
    return map;
  }

}