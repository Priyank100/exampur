import 'dart:convert';
/// statusCode : 200
/// data : {"promo_code":"GET10OFF","type":"percentage","value":10,"amount":1999,"discount":199.9,"final_amount":1799.1}

Promo_code promo_codeFromJson(String str) => Promo_code.fromJson(json.decode(str));
String promo_codeToJson(Promo_code data) => json.encode(data.toJson());
class Promo_code {
  Promo_code({
      int? statusCode, 
      Data? data,}){
    _statusCode = statusCode;
    _data = data;
}

  Promo_code.fromJson(dynamic json) {
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

/// promo_code : "GET10OFF"
/// type : "percentage"
/// value : 10
/// amount : 1999
/// discount : 199.9
/// final_amount : 1799.1

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? promoCode, 
      String? type, 
      int? value, 
      int? amount, 
      double? discount, 
      double? finalAmount,}){
    _promoCode = promoCode;
    _type = type;
    _value = value;
    _amount = amount;
    _discount = discount;
    _finalAmount = finalAmount;
}

  Data.fromJson(dynamic json) {
    _promoCode = json['promo_code'];
    _type = json['type'];
    _value = json['value'];
    _amount = json['amount'];
    _discount = json['discount'];
    _finalAmount = json['final_amount'];
  }
  String? _promoCode;
  String? _type;
  int? _value;
  int? _amount;
  double? _discount;
  double? _finalAmount;

  String? get promoCode => _promoCode;
  String? get type => _type;
  int? get value => _value;
  int? get amount => _amount;
  double? get discount => _discount;
  double? get finalAmount => _finalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['promo_code'] = _promoCode;
    map['type'] = _type;
    map['value'] = _value;
    map['amount'] = _amount;
    map['discount'] = _discount;
    map['final_amount'] = _finalAmount;
    return map;
  }

}