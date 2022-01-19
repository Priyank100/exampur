import 'dart:convert';
/// statusCode : 200
/// data : {"order_id":"61e80534601c17cd269bef8e","payment_transaction_id":"pay_IlbP93dm2fEh2w","amount":1999,"final_amount":1999,"billing_address":"asd","billing_city":"meerut","billing_state":"Chandigarh","billing_country":"India","billing_pincode":4561238,"status":"Paid"}

FinalOrderPayModel final_order_pay_modelFromJson(String str) => FinalOrderPayModel.fromJson(json.decode(str));
String final_order_pay_modelToJson(FinalOrderPayModel data) => json.encode(data.toJson());
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

/// order_id : "61e80534601c17cd269bef8e"
/// payment_transaction_id : "pay_IlbP93dm2fEh2w"
/// amount : 1999
/// final_amount : 1999
/// billing_address : "asd"
/// billing_city : "meerut"
/// billing_state : "Chandigarh"
/// billing_country : "India"
/// billing_pincode : 4561238
/// status : "Paid"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? orderId,
    String? paymentTransactionId,
    int? amount,
    int? finalAmount,
    String? billingAddress,
    String? billingCity,
    String? billingState,
    String? billingCountry,
    int? billingPincode,
    String? status,}){
    _orderId = orderId;
    _paymentTransactionId = paymentTransactionId;
    _amount = amount;
    _finalAmount = finalAmount;
    _billingAddress = billingAddress;
    _billingCity = billingCity;
    _billingState = billingState;
    _billingCountry = billingCountry;
    _billingPincode = billingPincode;
    _status = status;
  }

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _paymentTransactionId = json['payment_transaction_id'];
    _amount = json['amount'];
    _finalAmount = json['final_amount'];
    _billingAddress = json['billing_address'];
    _billingCity = json['billing_city'];
    _billingState = json['billing_state'];
    _billingCountry = json['billing_country'];
    _billingPincode = json['billing_pincode'];
    _status = json['status'];
  }
  String? _orderId;
  String? _paymentTransactionId;
  int? _amount;
  int? _finalAmount;
  String? _billingAddress;
  String? _billingCity;
  String? _billingState;
  String? _billingCountry;
  int? _billingPincode;
  String? _status;

  String? get orderId => _orderId;
  String? get paymentTransactionId => _paymentTransactionId;
  int? get amount => _amount;
  int? get finalAmount => _finalAmount;
  String? get billingAddress => _billingAddress;
  String? get billingCity => _billingCity;
  String? get billingState => _billingState;
  String? get billingCountry => _billingCountry;
  int? get billingPincode => _billingPincode;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['payment_transaction_id'] = _paymentTransactionId;
    map['amount'] = _amount;
    map['final_amount'] = _finalAmount;
    map['billing_address'] = _billingAddress;
    map['billing_city'] = _billingCity;
    map['billing_state'] = _billingState;
    map['billing_country'] = _billingCountry;
    map['billing_pincode'] = _billingPincode;
    map['status'] = _status;
    return map;
  }

}