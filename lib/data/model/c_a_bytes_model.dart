import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"6200c06e8d1e8ecd8b80bd5e","title":"Sixth CA Byte","image_path":"ca_byte/RwljsIri-HARYANA-SPECIAL.jpg"},{"_id":"6200c0538d1e8ecd8b80bd4c","title":"Fifth CA Byte","image_path":"ca_byte/Nd8w82jL-j2KO4s9N-POLICE-EXAMS.png"},{"_id":"6200c0458d1e8ecd8b80bd3a","title":"Fourth CA Byte","image_path":"ca_byte/UWuSjofP-banner_exampur.jpg"},{"_id":"6200c0378d1e8ecd8b80bd28","title":"Third CA Byte","image_path":"ca_byte/t3DV5O4q-banner_course_2.jpeg"},{"_id":"6200c00d8d1e8ecd8b80bd16","title":"Second CA Byte","image_path":"ca_byte/4fAzmtQb-banner_course_2.jpeg"},{"_id":"6200bfee8d1e8ecd8b80bd04","title":"First CA Byte","image_path":"ca_byte/qjfajGpJ-banner_exampur.jpg"}]
/// totalCount : 6

CABytesModel cABytesModelFromJson(String str) => CABytesModel.fromJson(json.decode(str));
String cABytesModelToJson(CABytesModel data) => json.encode(data.toJson());
class CABytesModel {
  CABytesModel({
      int? statusCode, 
      List<Data>? data, 
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  CABytesModel.fromJson(dynamic json) {
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

/// _id : "6200c06e8d1e8ecd8b80bd5e"
/// title : "Sixth CA Byte"
/// image_path : "ca_byte/RwljsIri-HARYANA-SPECIAL.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? imagePath,}){
    _id = id;
    _title = title;
    _imagePath = imagePath;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _imagePath = json['image_path'];
  }
  String? _id;
  String? _title;
  String? _imagePath;

  String? get id => _id;
  String? get title => _title;
  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['image_path'] = _imagePath;
    return map;
  }

}