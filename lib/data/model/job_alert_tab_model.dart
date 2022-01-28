import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61efe8001dbf84752e75035c","name":"Admit Card"},{"_id":"61efe7e51dbf84752e75034b","name":"Results"},{"_id":"61efe7c11dbf84752e750332","name":"Vacancy"}]

Job_alert_tab_Model job_alert_tab_ModelFromJson(String str) => Job_alert_tab_Model.fromJson(json.decode(str));
String job_alert_tab_ModelToJson(Job_alert_tab_Model data) => json.encode(data.toJson());

class Job_alert_tab_Model {
  Job_alert_tab_Model({
      int? statusCode, 
      List<TabData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  Job_alert_tab_Model.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TabData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<TabData>? _data;

  int? get statusCode => _statusCode;
  List<TabData>? get data => _data;

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

TabData dataFromJson(String str) => TabData.fromJson(json.decode(str));
String dataToJson(TabData data) => json.encode(data.toJson());
class TabData {
  TabData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  TabData.fromJson(dynamic json) {
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