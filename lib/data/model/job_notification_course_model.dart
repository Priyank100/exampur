import 'dart:convert';
/// id : 17
/// name : "DSSSB-not in use"
/// description : ""
/// order : 0
/// is_active : false

JobNotificationCourseModel jobNotificationCourseModelFromJson(String str) => JobNotificationCourseModel.fromJson(json.decode(str));
String jobNotificationCourseModelToJson(JobNotificationCourseModel data) => json.encode(data.toJson());

class JobNotificationCourseModel {
  JobNotificationCourseModel({
      int? id, 
      String? name, 
      String? description, 
      int? order, 
      bool? isActive,}){
    _id = id;
    _name = name;
    _description = description;
    _order = order;
    _isActive = isActive;
}

  JobNotificationCourseModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _order = json['order'];
    _isActive = json['is_active'];
  }
  int? _id;
  String? _name;
  String? _description;
  int? _order;
  bool? _isActive;

  int? get id => _id;
  String? get name => _name;
  String? get description => _description;
  int? get order => _order;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['order'] = _order;
    map['is_active'] = _isActive;
    return map;
  }

}