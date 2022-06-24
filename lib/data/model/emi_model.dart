import 'dart:convert';
/// statusCode : 200
/// data : {"order_no":"SdoS1655965465KVRG","amount":416,"payment_source":"Razorpay","payment_order_id":"order_JkptswbjLfulvX","description":"Payment for Course: undefined","status":"EMI"}

EmiModel emiModelFromJson(String str) => EmiModel.fromJson(json.decode(str));
String emiModelToJson(EmiModel data) => json.encode(data.toJson());
class EmiModel {
  EmiModel({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  EmiModel.fromJson(dynamic json) {
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

/// order_no : "SdoS1655965465KVRG"
/// amount : 416
/// payment_source : "Razorpay"
/// payment_order_id : "order_JkptswbjLfulvX"
/// description : "Payment for Course: undefined"
/// status : "EMI"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? orderNo, 
      int? amount, 
      String? paymentSource, 
      String? paymentOrderId, 
      String? description, 
      String? status,}){
    _orderNo = orderNo;
    _amount = amount;
    _paymentSource = paymentSource;
    _paymentOrderId = paymentOrderId;
    _description = description;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _orderNo = json['order_no'];
    _amount = json['amount'];
    _paymentSource = json['payment_source'];
    _paymentOrderId = json['payment_order_id'];
    _description = json['description'];
    _status = json['status'];
  }
  String? _orderNo;
  int? _amount;
  String? _paymentSource;
  String? _paymentOrderId;
  String? _description;
  String? _status;

  String? get orderNo => _orderNo;
  int? get amount => _amount;
  String? get paymentSource => _paymentSource;
  String? get paymentOrderId => _paymentOrderId;
  String? get description => _description;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_no'] = _orderNo;
    map['amount'] = _amount;
    map['payment_source'] = _paymentSource;
    map['payment_order_id'] = _paymentOrderId;
    map['description'] = _description;
    map['status'] = _status;
    return map;
  }

}