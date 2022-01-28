import 'dart:convert';
/// statusCode : 200
/// data : {"_id":"61f38d26ff571ca4eb098952","title":"UPSC Calendar 2022 Releases","description":"PGgxPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvaDE+DQo8cD48L3A+DQo8aDI+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9oMj4NCjxwPjwvcD4NCjxoMz5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2gzPg0KPHA+PC9wPg0KPGg0PlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvaDQ+DQo8cD48L3A+DQo8aDU+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9oNT4NCjxwPjwvcD4NCjxoNj5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2g2Pg0KPGg2PjwvaDY+DQo8aDY+PC9oNj4NCjx1bD48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48L3VsPg0KPHA+PC9wPg0KPG9sPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjwvb2w+DQo8cD48L3A+DQo8cD48ZGVsPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvZGVsPjwvcD4NCjxwPjxlbT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2VtPjwvcD4NCjxwPjxlbT48c3Ryb25nPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvc3Ryb25nPjwvZW0+PC9wPg0KPHA+PHN0cm9uZz5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L3N0cm9uZz48L3A+"}

JobAlertsDetailModel jobAlertsDetailModelFromJson(String str) => JobAlertsDetailModel.fromJson(json.decode(str));
String jobAlertsDetailModelToJson(JobAlertsDetailModel data) => json.encode(data.toJson());

class JobAlertsDetailModel {
  JobAlertsDetailModel({
      int? statusCode,
    DetailsData? data,}){
    _statusCode = statusCode;
    _data = data;
}

  JobAlertsDetailModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _data = json['data'] != null ? DetailsData.fromJson(json['data']) : null;
  }
  int? _statusCode;
  DetailsData? _data;

  int? get statusCode => _statusCode;
  DetailsData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// _id : "61f38d26ff571ca4eb098952"
/// title : "UPSC Calendar 2022 Releases"
/// description : "PGgxPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvaDE+DQo8cD48L3A+DQo8aDI+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9oMj4NCjxwPjwvcD4NCjxoMz5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2gzPg0KPHA+PC9wPg0KPGg0PlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvaDQ+DQo8cD48L3A+DQo8aDU+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9oNT4NCjxwPjwvcD4NCjxoNj5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2g2Pg0KPGg2PjwvaDY+DQo8aDY+PC9oNj4NCjx1bD48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48bGk+VVBTQyBDYWxlbmRhciAyMDIyIFJlbGVhc2VzPC9saT48L3VsPg0KPHA+PC9wPg0KPG9sPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjxsaT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2xpPjwvb2w+DQo8cD48L3A+DQo8cD48ZGVsPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvZGVsPjwvcD4NCjxwPjxlbT5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L2VtPjwvcD4NCjxwPjxlbT48c3Ryb25nPlVQU0MgQ2FsZW5kYXIgMjAyMiBSZWxlYXNlczwvc3Ryb25nPjwvZW0+PC9wPg0KPHA+PHN0cm9uZz5VUFNDIENhbGVuZGFyIDIwMjIgUmVsZWFzZXM8L3N0cm9uZz48L3A+"

DetailsData dataFromJson(String str) => DetailsData.fromJson(json.decode(str));
String dataToJson(DetailsData data) => json.encode(data.toJson());
class DetailsData {
  DetailsData({
      String? id, 
      String? title, 
      String? description,}){
    _id = id;
    _title = title;
    _description = description;
}

  DetailsData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _description = json['description'];
  }
  String? _id;
  String? _title;
  String? _description;

  String? get id => _id;
  String? get title => _title;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    return map;
  }

}