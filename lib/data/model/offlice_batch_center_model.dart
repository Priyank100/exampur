import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61dd6d0de3530aed60ffc81f","name":"Patna Center 1","city":"Patna","country":"India","pincode":"851130","state":"Bihar"},{"_id":"61dd6e69e3530aed60ffc820","name":"Patna Center 2","city":"Patna","country":"India","pincode":"851132","state":"Bihar"},{"_id":"61dd6e7fe3530aed60ffc821","name":"Meerut Center 1","city":"Meerut","country":"India","pincode":"250001","state":"Uttar Pradesh"},{"_id":"61dd6e9ee3530aed60ffc822","name":"Meerut Center 2","city":"Meerut","country":"India","pincode":"250001","state":"Uttar Pradesh"}]
/// totalCount : 4

OffliceBatchCenterModel offliceBatchCenterModelFromJson(String str) => OffliceBatchCenterModel.fromJson(json.decode(str));
String offliceBatchCenterModelToJson(OffliceBatchCenterModel data) => json.encode(data.toJson());

class OffliceBatchCenterModel {
  OffliceBatchCenterModel({
      int? statusCode, 
      List<CenterListModel>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  OffliceBatchCenterModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CenterListModel.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<CenterListModel>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<CenterListModel>? get data => _data;
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

CenterListModel centerListModelFromJson(String str) => CenterListModel.fromJson(json.decode(str));
String centerListModelToJson(CenterListModel data) => json.encode(data.toJson());

class CenterListModel {
  CenterListModel({
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

  CenterListModel.fromJson(dynamic json) {
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