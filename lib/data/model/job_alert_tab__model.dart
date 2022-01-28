import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61efe8001dbf84752e75035c","name":"Admit Card"},{"_id":"61efe7e51dbf84752e75034b","name":"Results"},{"_id":"61efe7c11dbf84752e750332","name":"Vacancy"}]

Job_alert_tab_Model job_alert_tab_ModelFromJson(String str) => Job_alert_tab_Model.fromJson(json.decode(str));
String job_alert_tab_ModelToJson(Job_alert_tab_Model data) => json.encode(data.toJson());
class Job_alert_tab_Model {
  Job_alert_tab_Model({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  Job_alert_tab_Model.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Data>? _data;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "61efe8001dbf84752e75035c"
/// name : "Admit Card"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}