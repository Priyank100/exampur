import 'dart:convert';

import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
/// statusCode : 200
/// data : [{"_id":"621539e178f845215b5a9fbd","title":"First Lecture will be available soon","image_path":"notification/0vE8liUV-ezgif-1-e89e6db6d3-jpg","action":"https://www.youtube.com/watch?v=jAOTZ03_5Zk"},{"_id":"621538c65d320df1a2a3a02d","title":"Course is starting on 1st March","action":"https://www.youtube.com/watch?v=kA_8-_W4Hpc"},{"_id":"621538865d320df1a2a3a025","title":"Second Notification - Course will start very soon","image_path":"notification/VgRn6x79-ecom-onpage-jpg","action":""},{"_id":"621538435d320df1a2a3a01d","title":"First Notification - Course will start soon","action":""}]

MyCourseNotificationModel myCourseNotificationModelFromJson(String str) => MyCourseNotificationModel.fromJson(json.decode(str));
String myCourseNotificationModelToJson(MyCourseNotificationModel data) => json.encode(data.toJson());
class MyCourseNotificationModel {
  MyCourseNotificationModel({
      int? statusCode, 
      List<NotificationData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseNotificationModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<NotificationData>? _data;

  int? get statusCode => _statusCode;
  List<NotificationData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "621539e178f845215b5a9fbd"
/// title : "First Lecture will be available soon"
/// image_path : "notification/0vE8liUV-ezgif-1-e89e6db6d3-jpg"
/// action : "https://www.youtube.com/watch?v=jAOTZ03_5Zk"

NotificationData dataFromJson(String str) => NotificationData.fromJson(json.decode(str));
String dataToJson(NotificationData data) => json.encode(data.toJson());
class NotificationData {
  NotificationData({
      String? id, 
      String? title, 
      String? imagePath, 
      String? action,}){
    _id = id;
    _title = title;
    _imagePath = imagePath;
    _action = action;
}

  NotificationData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _imagePath = json['image_path'];
    _action = json['action'];
  }
  String? _id;
  String? _title;
  String? _imagePath;
  String? _action;

  String? get id => _id;
  String? get title => _title;
  String? get imagePath => _imagePath;
  String? get action => _action;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['image_path'] = _imagePath;
    map['action'] = _action;
    return map;
  }

}