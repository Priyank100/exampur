import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61f38d26ff571ca4eb098952","title":"UPSC Calendar 2022 Releases"}]
/// totalCount : 1

JobAlertListModel jobAlertListModelFromJson(String str) => JobAlertListModel.fromJson(json.decode(str));
String jobAlertListModelToJson(JobAlertListModel data) => json.encode(data.toJson());

class JobAlertListModel {
  JobAlertListModel({
      int? statusCode, 
      List<ListData>? data,
      int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
}

  JobAlertListModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ListData.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<ListData>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<ListData>? get data => _data;
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

/// _id : "61f38d26ff571ca4eb098952"
/// title : "UPSC Calendar 2022 Releases"

ListData dataFromJson(String str) => ListData.fromJson(json.decode(str));
String dataToJson(ListData data) => json.encode(data.toJson());

class ListData {
  ListData({
      String? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  ListData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
  }
  String? _id;
  String? _title;

  String? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    return map;
  }

}