import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61dffee7ced0818afc94337a","image_path":"exam/BYpx6b61-logo_course_2.png","title":"Examपुर Application  से PDF कैसे Download करे","video_link":"https://www.youtube.com/watch?v=R2LLGd2rhvE"},{"_id":"61dfff6bced0818afc94337b","image_path":"exam/BYpx6b61-logo_course_2.png","title":"कैसे देखे EXAMPUR APP पर FREE APP FOUNDATION BATCH ?","video_link":"https://www.youtube.com/watch?v=cm3rD0CB4og"},{"_id":"61dfff6eced0818afc94337c","image_path":"exam/BYpx6b61-logo_course_2.png","title":"How To Enroll UPTET / SUPER TET Combo Batch","video_link":"https://www.youtube.com/watch?v=fTpgFrIfWQc"},{"_id":"61dfff70ced0818afc94337d","image_path":"exam/BYpx6b61-logo_course_2.png","title":"DOWNLOAD EXAMPUR OFFICIAL APP AND JOIN 👉 UP LEKHPAL 2021 BATCH","video_link":"https://www.youtube.com/watch?v=1c9GYAkX_rE"}]
/// totalCount : 4

ApppToutorial apppToutorialFromJson(String str) => ApppToutorial.fromJson(json.decode(str));
String apppToutorialToJson(ApppToutorial data) => json.encode(data.toJson());
class ApppToutorial {
  ApppToutorial({
      int? statusCode, 
      List<Data>? data, 
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  ApppToutorial.fromJson(dynamic json) {
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

/// _id : "61dffee7ced0818afc94337a"
/// image_path : "exam/BYpx6b61-logo_course_2.png"
/// title : "Examपुर Application  से PDF कैसे Download करे"
/// video_link : "https://www.youtube.com/watch?v=R2LLGd2rhvE"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? imagePath, 
      String? title, 
      String? videoLink,}){
    _id = id;
    _imagePath = imagePath;
    _title = title;
    _videoLink = videoLink;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _imagePath = json['image_path'];
    _title = json['title'];
    _videoLink = json['video_link'];
  }
  String? _id;
  String? _imagePath;
  String? _title;
  String? _videoLink;

  String? get id => _id;
  String? get imagePath => _imagePath;
  String? get title => _title;
  String? get videoLink => _videoLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image_path'] = _imagePath;
    map['title'] = _title;
    map['video_link'] = _videoLink;
    return map;
  }

}