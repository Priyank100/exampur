import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61dd6d0de3530aed60ffc81f","name":"Patna Center 1","city":"Patna","country":"India","pincode":"851130","state":"Bihar"},{"_id":"61dd6e69e3530aed60ffc820","name":"Patna Center 2","city":"Patna","country":"India","pincode":"851132","state":"Bihar"},{"_id":"61dd6e7fe3530aed60ffc821","name":"Meerut Center 1","city":"Meerut","country":"India","pincode":"250001","state":"Uttar Pradesh"},{"_id":"61dd6e9ee3530aed60ffc822","name":"Meerut Center 2","city":"Meerut","country":"India","pincode":"250001","state":"Uttar Pradesh"}]
/// totalCount : 4

OfflineBatchModel offlineBatchesModelFromJson(String str) => OfflineBatchModel.fromJson(json.decode(str));
String offlineBatchesModelToJson(OfflineBatchModel data) => json.encode(data.toJson());
class OfflineBatchModel {
  OfflineBatchModel({
      int? statusCode, 
      List<Data>? data, 
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  OfflineBatchModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Data>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61dd6d0de3530aed60ffc81f"
/// name : "Patna Center 1"
/// city : "Patna"
/// country : "India"
/// pincode : "851130"
/// state : "Bihar"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name, 
      String? city, 
      String? country, 
      String? pincode, 
      String? state,}){
    _id = id;
    _name = name;
    _city = city;
    _country = country;
    _pincode = pincode;
    _state = state;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _city = json['city'];
    _country = json['country'];
    _pincode = json['pincode'];
    _state = json['state'];
  }
  String? _id;
  String? _name;
  String? _city;
  String? _country;
  String? _pincode;
  String? _state;

  String? get id => _id;
  String? get name => _name;
  String? get city => _city;
  String? get country => _country;
  String? get pincode => _pincode;
  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['city'] = _city;
    map['country'] = _country;
    map['pincode'] = _pincode;
    map['state'] = _state;
    return map;
  }

}