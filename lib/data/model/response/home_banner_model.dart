import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61dbe034e57f46023edc92ac","title":"Course Promotion","image_path":"banner/banner_exampur_1.jpg","type":"Course","link":"61c98d223a7d50ce67803edb"},{"_id":"61dbe043e57f46023edc92ad","title":"Book Promotion","image_path":"banner/banner_exampur_3.jpg","type":"Book","link":"61cad845da1d8532b6f33fd1"},{"_id":"61dbe070e57f46023edc92b6","title":"Course Promotion 2","image_path":"banner/banner_exampur_3.jpg","type":"Course","link":"61c98f613a7d50ce67803eea"},{"_id":"61dbe076e57f46023edc92b7","title":"Book Promotion 2","image_path":"banner/banner_exampur_4.jpg","type":"Book","link":"61cdb58dec27a072279e1aab"}]
/// totalCount : 4

HomeBannerModel homeBannerModelFromJson(String str) => HomeBannerModel.fromJson(json.decode(str));
String homeBannerModelToJson(HomeBannerModel data) => json.encode(data.toJson());
class HomeBannerModel {
  HomeBannerModel({
      int? statusCode, 
      List<BannerData>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  HomeBannerModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerData.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<BannerData>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<BannerData>? get data => _data;
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

/// _id : "61dbe034e57f46023edc92ac"
/// title : "Course Promotion"
/// image_path : "banner/banner_exampur_1.jpg"
/// type : "Course"
/// link : "61c98d223a7d50ce67803edb"

BannerData dataFromJson(String str) => BannerData.fromJson(json.decode(str));
String dataToJson(BannerData data) => json.encode(data.toJson());
class BannerData {
  Data({
      String? id, 
      String? title, 
      String? imagePath, 
      String? type, 
      String? link,}){
    _id = id;
    _title = title;
    _imagePath = imagePath;
    _type = type;
    _link = link;
}

  BannerData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _imagePath = json['image_path'];
    _type = json['type'];
    _link = json['link'];
  }
  String? _id;
  String? _title;
  String? _imagePath;
  String? _type;
  String? _link;

  String? get id => _id;
  String? get title => _title;
  String? get imagePath => _imagePath;
  String? get type => _type;
  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['image_path'] = _imagePath;
    map['type'] = _type;
    map['link'] = _link;
    return map;
  }

}