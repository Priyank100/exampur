import 'dart:convert';
/// statusCode : 200
/// data : {"order_id":"61fa769102ada41f40916e5f","date":"02-02-2022","payment_transaction_id":"pay_Ir8cRS3fLkVw5W","course_title":"Course 1","amount":1999,"promo_code":null,"final_amount":1999,"billing_address":"hfgj","billing_city":"meerut","billing_state":"Chandigarh","billing_country":"India","billing_pincode":98866,"status":"Paid"}

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

/// order_id : "61fa769102ada41f40916e5f"
/// date : "02-02-2022"
/// payment_transaction_id : "pay_Ir8cRS3fLkVw5W"
/// course_title : "Course 1"
/// amount : 1999
/// promo_code : null
/// final_amount : 1999
/// billing_address : "hfgj"
/// billing_city : "meerut"
/// billing_state : "Chandigarh"
/// billing_country : "India"
/// billing_pincode : 98866
/// status : "Paid"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? orderId, 
      String? date, 
      String? paymentTransactionId, 
      String? courseTitle, 
      String? bookTitle,
      int? amount,
      dynamic promoCode, 
      int? finalAmount, 
      String? billingAddress, 
      String? billingCity, 
      String? billingState, 
      String? billingCountry, 
      int? billingPincode, 
      String? status,}){
    _orderId = orderId;
    _date = date;
    _paymentTransactionId = paymentTransactionId;
    _courseTitle = courseTitle;
    _bookTitle = bookTitle;
    _amount = amount;
    _promoCode = promoCode;
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
    _date = json['date'];
    _paymentTransactionId = json['payment_transaction_id'];
    _courseTitle = json['course_title'];
    _bookTitle = json['book_title'];
    _amount = json['amount'];
    _promoCode = json['promo_code'];
    _finalAmount = json['final_amount'];
    _billingAddress = json['billing_address'];
    _billingCity = json['billing_city'];
    _billingState = json['billing_state'];
    _billingCountry = json['billing_country'];
    _billingPincode = json['billing_pincode'];
    _status = json['status'];
  }
  String? _orderId;
  String? _date;
  String? _paymentTransactionId;
  String? _courseTitle;
  String? _bookTitle;
  int? _amount;
  dynamic _promoCode;
  int? _finalAmount;
  String? _billingAddress;
  String? _billingCity;
  String? _billingState;
  String? _billingCountry;
  int? _billingPincode;
  String? _status;

  String? get orderId => _orderId;
  String? get date => _date;
  String? get paymentTransactionId => _paymentTransactionId;
  String? get courseTitle => _courseTitle;
  String? get bookTitle => _bookTitle;
  int? get amount => _amount;
  dynamic get promoCode => _promoCode;
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
    map['date'] = _date;
    map['payment_transaction_id'] = _paymentTransactionId;
    map['course_title'] = _courseTitle;
    map['book_title'] = _bookTitle;
    map['amount'] = _amount;
    map['promo_code'] = _promoCode;
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