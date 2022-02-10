import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61f251f82ecc34122c67404b","title":"First Content","description":"PGgxPjxzdHJvbmc+Rmlyc3QgQ29udGVudDwvc3Ryb25nPjwvaDE+DQo8cD5IZWxsbyB0aGVyZSwgdGhpcyBpcyBvdXIgZmlyc3QgY29udGVudDwvcD4=","type":"Content","target_link":null,"banner_path":"content/IgTT2wDQ-banner_exampur.jpg"},{"_id":"62020e6190ad98806b3b5959","title":"Second Content","description":"PGgxPjxzdHJvbmc+Rmlyc3QgQ29udGVudDwvc3Ryb25nPjwvaDE+DQo8cD5IZWxsbyB0aGVyZSwgdGhpcyBpcyBvdXIgZmlyc3QgY29udGVudDwvcD4=","type":"PDF","target_link":"content/lYyMqOGN-EX-Dis.pdf","banner_path":"content/IgTT2wDQ-banner_exampur.jpg"}]
/// totalCount : 2

CaSmModel caSmModelFromJson(String str) => CaSmModel.fromJson(json.decode(str));
String caSmModelToJson(CaSmModel data) => json.encode(data.toJson());

class CaSmModel {
  CaSmModel({
      int? statusCode, 
      List<Data>? data, 
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  CaSmModel.fromJson(dynamic json) {
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

/// _id : "61f251f82ecc34122c67404b"
/// title : "First Content"
/// description : "PGgxPjxzdHJvbmc+Rmlyc3QgQ29udGVudDwvc3Ryb25nPjwvaDE+DQo8cD5IZWxsbyB0aGVyZSwgdGhpcyBpcyBvdXIgZmlyc3QgY29udGVudDwvcD4="
/// type : "Content"
/// target_link : null
/// banner_path : "content/IgTT2wDQ-banner_exampur.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      String? description, 
      String? type, 
      dynamic targetLink, 
      String? bannerPath,}){
    _id = id;
    _title = title;
    _description = description;
    _type = type;
    _targetLink = targetLink;
    _bannerPath = bannerPath;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
    _type = json['type'];
    _targetLink = json['target_link'];
    _bannerPath = json['banner_path'];
  }
  String? _id;
  String? _title;
  String? _description;
  String? _type;
  dynamic _targetLink;
  String? _bannerPath;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;
  String? get type => _type;
  dynamic get targetLink => _targetLink;
  String? get bannerPath => _bannerPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['type'] = _type;
    map['target_link'] = _targetLink;
    map['banner_path'] = _bannerPath;
    return map;
  }

}