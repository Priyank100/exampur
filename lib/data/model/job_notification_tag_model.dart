import 'dart:convert';
/// id : 4
/// name : "Latest Jobs"
/// slug : "latest-jobs"
/// order : 1
/// active : true
/// created : "2021-12-16T14:17:32.417437"
/// updated : "2022-03-24T11:28:17.715642"

JobNotificationTagModel jobNotificationTagModelFromJson(String str) => JobNotificationTagModel.fromJson(json.decode(str));
String jobNotificationTagModelToJson(JobNotificationTagModel data) => json.encode(data.toJson());

class JobNotificationTagModel {
  JobNotificationTagModel({
      int? id, 
      String? name, 
      String? slug, 
      int? order, 
      bool? active, 
      String? created, 
      String? updated,}){
    _id = id;
    _name = name;
    _slug = slug;
    _order = order;
    _active = active;
    _created = created;
    _updated = updated;
}

  JobNotificationTagModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    _active = json['active'];
    _created = json['created'];
    _updated = json['updated'];
  }
  int? _id;
  String? _name;
  String? _slug;
  int? _order;
  bool? _active;
  String? _created;
  String? _updated;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  bool? get active => _active;
  String? get created => _created;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    map['active'] = _active;
    map['created'] = _created;
    map['updated'] = _updated;
    return map;
  }

}