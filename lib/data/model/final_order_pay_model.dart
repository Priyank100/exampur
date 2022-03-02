import 'dart:convert';
/// statusCode : 200
/// data : {"order_id":"621f19ca2e6fcd72e107b2e3","order_no":"OaZi1646205385XPcr","date":"02-03-2022","payment_transaction_id":"pay_J28QoAvbRgCCxv","amount":1999,"promo_code":null,"final_amount":1999,"status":"Paid","product":{"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}}

FinalOrderPayModel finalOrderPayModelFromJson(String str) => FinalOrderPayModel.fromJson(json.decode(str));
String finalOrderPayModelToJson(FinalOrderPayModel data) => json.encode(data.toJson());
class FinalOrderPayModel {
  FinalOrderPayModel({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  FinalOrderPayModel.fromJson(dynamic json) {
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

/// order_id : "621f19ca2e6fcd72e107b2e3"
/// order_no : "OaZi1646205385XPcr"
/// date : "02-03-2022"
/// payment_transaction_id : "pay_J28QoAvbRgCCxv"
/// amount : 1999
/// promo_code : null
/// final_amount : 1999
/// status : "Paid"
/// product : {"type":"Course","_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? orderId, 
      String? orderNo, 
      String? date, 
      String? paymentTransactionId, 
      int? amount, 
      dynamic promoCode, 
      int? finalAmount, 
      String? status, 
      Product? product,}){
    _orderId = orderId;
    _orderNo = orderNo;
    _date = date;
    _paymentTransactionId = paymentTransactionId;
    _amount = amount;
    _promoCode = promoCode;
    _finalAmount = finalAmount;
    _status = status;
    _product = product;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderNo = json['order_no'];
    _date = json['date'];
    _paymentTransactionId = json['payment_transaction_id'];
    _amount = json['amount'];
    _promoCode = json['promo_code'];
    _finalAmount = json['final_amount'];
    _status = json['status'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  String? _orderId;
  String? _orderNo;
  String? _date;
  String? _paymentTransactionId;
  int? _amount;
  dynamic _promoCode;
  int? _finalAmount;
  String? _status;
  Product? _product;

  String? get orderId => _orderId;
  String? get orderNo => _orderNo;
  String? get date => _date;
  String? get paymentTransactionId => _paymentTransactionId;
  int? get amount => _amount;
  dynamic get promoCode => _promoCode;
  int? get finalAmount => _finalAmount;
  String? get status => _status;
  Product? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_no'] = _orderNo;
    map['date'] = _date;
    map['payment_transaction_id'] = _paymentTransactionId;
    map['amount'] = _amount;
    map['promo_code'] = _promoCode;
    map['final_amount'] = _finalAmount;
    map['status'] = _status;
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