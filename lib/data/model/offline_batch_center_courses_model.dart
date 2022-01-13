import 'dart:convert';
/// statusCode : 200
/// centerDetails : {"_id":"61dd6d0de3530aed60ffc81f","description":"Patna Center Description","name":"Patna Center 1","phone":9099998988,"phone_ext":91,"address":"Hello Address Testing, Area...","city":"Patna","country":"India","pincode":"851130","state":"Bihar"}
/// data : [{"_id":"61c98d223a7d50ce67803edb","title":"Offline Course 1","logo_path":"course/4tr0oUkb-logo_course_2.png"},{"_id":"61de86f31869ec951c95d1dc","title":"Offline Course 2","logo_path":"course/4tr0oUkb-logo_course_2.png"},{"_id":"61de87231869ec951c95d1dd","title":"Offline Course 3","logo_path":"course/4tr0oUkb-logo_course_2.png"}]
/// totalCount : 3

OfflineBatchCenterCoursesModel offlineBatchCenterCoursesModelFromJson(String str) => OfflineBatchCenterCoursesModel.fromJson(json.decode(str));
String offlineBatchCenterCoursesModelToJson(OfflineBatchCenterCoursesModel data) => json.encode(data.toJson());

class OfflineBatchCenterCoursesModel {
  OfflineBatchCenterCoursesModel({
      int? statusCode, 
      CenterDetails? centerDetails, 
      List<CenterCoursesListModel>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _centerDetails = centerDetails;
    _data = data;
    _totalCount = totalCount;
}

  OfflineBatchCenterCoursesModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _centerDetails = json['centerDetails'] != null ? CenterDetails.fromJson(json['centerDetails']) : null;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CenterCoursesListModel.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  CenterDetails? _centerDetails;
  List<CenterCoursesListModel>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  CenterDetails? get centerDetails => _centerDetails;
  List<CenterCoursesListModel>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_centerDetails != null) {
      map['centerDetails'] = _centerDetails?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Offline Course 1"
/// logo_path : "course/4tr0oUkb-logo_course_2.png"

CenterCoursesListModel centerCoursesListModelFromJson(String str) => CenterCoursesListModel.fromJson(json.decode(str));
String centerCoursesListModelToJson(CenterCoursesListModel data) => json.encode(data.toJson());

class CenterCoursesListModel {
  CenterCoursesListModel({
      String? id, 
      String? title, 
      String? logoPath,}){
    _id = id;
    _title = title;
    _logoPath = logoPath;
}

  CenterCoursesListModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
  }
  String? _id;
  String? _title;
  String? _logoPath;

  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    return map;
  }

}

/// _id : "61dd6d0de3530aed60ffc81f"
/// description : "Patna Center Description"
/// name : "Patna Center 1"
/// phone : 9099998988
/// phone_ext : 91
/// address : "Hello Address Testing, Area..."
/// city : "Patna"
/// country : "India"
/// pincode : "851130"
/// state : "Bihar"

CenterDetails centerDetailsFromJson(String str) => CenterDetails.fromJson(json.decode(str));
String centerDetailsToJson(CenterDetails data) => json.encode(data.toJson());

class CenterDetails {
  CenterDetails({
      String? id, 
      String? description, 
      String? name, 
      int? phone, 
      int? phoneExt, 
      String? address, 
      String? city, 
      String? country, 
      String? pincode, 
      String? state,}){
    _id = id;
    _description = description;
    _name = name;
    _phone = phone;
    _phoneExt = phoneExt;
    _address = address;
    _city = city;
    _country = country;
    _pincode = pincode;
    _state = state;
}

  CenterDetails.fromJson(dynamic json) {
    _id = json['_id'];
    _description = json['description'];
    _name = json['name'];
    _phone = json['phone'];
    _phoneExt = json['phone_ext'];
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _pincode = json['pincode'];
    _state = json['state'];
  }
  String? _id;
  String? _description;
  String? _name;
  int? _phone;
  int? _phoneExt;
  String? _address;
  String? _city;
  String? _country;
  String? _pincode;
  String? _state;

  String? get id => _id;
  String? get description => _description;
  String? get name => _name;
  int? get phone => _phone;
  int? get phoneExt => _phoneExt;
  String? get address => _address;
  String? get city => _city;
  String? get country => _country;
  String? get pincode => _pincode;
  String? get state => _state;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['description'] = _description;
    map['name'] = _name;
    map['phone'] = _phone;
    map['phone_ext'] = _phoneExt;
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['pincode'] = _pincode;
    map['state'] = _state;
    return map;
  }

}