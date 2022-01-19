import 'dart:convert';
/// statusCode : 200
/// data : {"order_id":"61e7d0b2601c17cd269bef24","amount":1999,"payment_source":"Razorpay","payment_order_id":"order_IlXZt1sYDGREfk","description":"Payment for Course: Course 1","status":"Pending"}

Delivery_model delivery_modelFromJson(String str) => Delivery_model.fromJson(json.decode(str));
String delivery_modelToJson(Delivery_model data) => json.encode(data.toJson());
class Delivery_model {
  Delivery_model({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  Delivery_model.fromJson(dynamic json) {
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

/// order_id : "61e7d0b2601c17cd269bef24"
/// amount : 1999
/// payment_source : "Razorpay"
/// payment_order_id : "order_IlXZt1sYDGREfk"
/// description : "Payment for Course: Course 1"
/// status : "Pending"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? orderId, 
      int? amount, 
      String? paymentSource, 
      String? paymentOrderId, 
      String? description, 
      String? status,}){
    _orderId = orderId;
    _amount = amount;
    _paymentSource = paymentSource;
    _paymentOrderId = paymentOrderId;
    _description = description;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _amount = json['amount'];
    _paymentSource = json['payment_source'];
    _paymentOrderId = json['payment_order_id'];
    _description = json['description'];
    _status = json['status'];
  }
  String? _orderId;
  int? _amount;
  String? _paymentSource;
  String? _paymentOrderId;
  String? _description;
  String? _status;

  String? get orderId => _orderId;
  int? get amount => _amount;
  String? get paymentSource => _paymentSource;
  String? get paymentOrderId => _paymentOrderId;
  String? get description => _description;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['amount'] = _amount;
    map['payment_source'] = _paymentSource;
    map['payment_order_id'] = _paymentOrderId;
    map['description'] = _description;
    map['status'] = _status;
    return map;
  }

}