import 'dart:convert';
/// count : 1
/// next : "null"
/// previous : "null"
/// tag_name : "Latest Jobs"
/// tag_id : 4
/// tag_slug : "latest-jobs"
/// course : [{"id":8,"name":"RAILWAY EXAMS","slug":"railway-exams"}]
/// notification : [{"id":32,"title":"रेलवे भर्ती बोर्ड (आरआरबी) एनटीपीसी 2021-2022","name":"Notification CBT-1 Hindi","slug":"rrb-ntpc-2021","updated":"2022-03-11T14:56:18.067"}]

JobNotificationListModel jobNotificationListModelFromJson(String str) => JobNotificationListModel.fromJson(json.decode(str));
String jobNotificationListModelToJson(JobNotificationListModel data) => json.encode(data.toJson());

class JobNotificationListModel {
  JobNotificationListModel({
      int? count, 
      String? next, 
      String? previous, 
      String? tagName, 
      int? tagId, 
      String? tagSlug, 
      List<Course>? course, 
      List<Notification>? notification,}){
    _count = count;
    _next = next;
    _previous = previous;
    _tagName = tagName;
    _tagId = tagId;
    _tagSlug = tagSlug;
    _course = course;
    _notification = notification;
}

  JobNotificationListModel.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    _tagName = json['tag_name'];
    _tagId = json['tag_id'];
    _tagSlug = json['tag_slug'];
    if (json['course'] != null) {
      _course = [];
      json['course'].forEach((v) {
        _course?.add(Course.fromJson(v));
      });
    }
    if (json['notification'] != null) {
      _notification = [];
      json['notification'].forEach((v) {
        _notification?.add(Notification.fromJson(v));
      });
    }
  }
  int? _count;
  String? _next;
  String? _previous;
  String? _tagName;
  int? _tagId;
  String? _tagSlug;
  List<Course>? _course;
  List<Notification>? _notification;

  int? get count => _count;
  String? get next => _next;
  String? get previous => _previous;
  String? get tagName => _tagName;
  int? get tagId => _tagId;
  String? get tagSlug => _tagSlug;
  List<Course>? get course => _course;
  List<Notification>? get notification => _notification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    map['tag_name'] = _tagName;
    map['tag_id'] = _tagId;
    map['tag_slug'] = _tagSlug;
    if (_course != null) {
      map['course'] = _course?.map((v) => v.toJson()).toList();
    }
    if (_notification != null) {
      map['notification'] = _notification?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 32
/// title : "रेलवे भर्ती बोर्ड (आरआरबी) एनटीपीसी 2021-2022"
/// name : "Notification CBT-1 Hindi"
/// slug : "rrb-ntpc-2021"
/// updated : "2022-03-11T14:56:18.067"

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));
String notificationToJson(Notification data) => json.encode(data.toJson());
class Notification {
  Notification({
      int? id, 
      String? title, 
      String? name, 
      String? slug, 
      String? updated,}){
    _id = id;
    _title = title;
    _name = name;
    _slug = slug;
    _updated = updated;
}

  Notification.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _name = json['name'];
    _slug = json['slug'];
    _updated = json['updated'];
  }
  int? _id;
  String? _title;
  String? _name;
  String? _slug;
  String? _updated;

  int? get id => _id;
  String? get title => _title;
  String? get name => _name;
  String? get slug => _slug;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['name'] = _name;
    map['slug'] = _slug;
    map['updated'] = _updated;
    return map;
  }

}

/// id : 8
/// name : "RAILWAY EXAMS"
/// slug : "railway-exams"

Course courseFromJson(String str) => Course.fromJson(json.decode(str));
String courseToJson(Course data) => json.encode(data.toJson());
class Course {
  Course({
      int? id, 
      String? name, 
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  Course.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
  int? _id;
  String? _name;
  String? _slug;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}