import 'dart:convert';
/// exam_id : 3
/// name : "UP LEKHPAL मुख्य परीक्षा 2022"
/// slug : "up-lekhpal-mukhya-pariksha-2022"
/// order : 0
/// subject : [{"id":1,"name":"hindi","slug":"up-lekhpal-2022-hindi","order":0,"created":"2022-04-15T11:12:10.542","updated":"2022-04-22T11:57:24.216"},{"id":2,"name":"Maths","slug":"up-lekhpal-2022-maths","order":1,"created":"2022-04-15T11:14:57.527","updated":"2022-04-22T11:57:58.543"},{"id":3,"name":"General Knowledge","slug":"up-lekhpal-2022-general-knowledge","order":2,"created":"2022-04-15T11:21:54.825","updated":"2022-04-22T11:58:44.095"},{"id":4,"name":"ग्राम्य समाज एवं विकास","slug":"up-lekhpal-2022-rural-society-and-development","order":4,"created":"2022-04-22T12:01:58.104","updated":"2022-04-22T12:01:58.104"}]

FreeVideoListModel freeVideoListModelFromJson(String str) => FreeVideoListModel.fromJson(json.decode(str));
String freeVideoListModelToJson(FreeVideoListModel data) => json.encode(data.toJson());
class FreeVideoListModel {
  FreeVideoListModel({
      int? examId, 
      String? name, 
      String? slug, 
      int? order, 
      List<Subject>? subject,}){
    _examId = examId;
    _name = name;
    _slug = slug;
    _order = order;
    _subject = subject;
}

  FreeVideoListModel.fromJson(dynamic json) {
    _examId = json['exam_id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    if (json['subject'] != null) {
      _subject = [];
      json['subject'].forEach((v) {
        _subject?.add(Subject.fromJson(v));
      });
    }
  }
  int? _examId;
  String? _name;
  String? _slug;
  int? _order;
  List<Subject>? _subject;
FreeVideoListModel copyWith({  int? examId,
  String? name,
  String? slug,
  int? order,
  List<Subject>? subject,
}) => FreeVideoListModel(  examId: examId ?? _examId,
  name: name ?? _name,
  slug: slug ?? _slug,
  order: order ?? _order,
  subject: subject ?? _subject,
);
  int? get examId => _examId;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  List<Subject>? get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['exam_id'] = _examId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    if (_subject != null) {
      map['subject'] = _subject?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "hindi"
/// slug : "up-lekhpal-2022-hindi"
/// order : 0
/// created : "2022-04-15T11:12:10.542"
/// updated : "2022-04-22T11:57:24.216"

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));
String subjectToJson(Subject data) => json.encode(data.toJson());
class Subject {
  Subject({
      int? id, 
      String? name, 
      String? slug, 
      int? order, 
      String? created, 
      String? updated,}){
    _id = id;
    _name = name;
    _slug = slug;
    _order = order;
    _created = created;
    _updated = updated;
}

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    _created = json['created'];
    _updated = json['updated'];
  }
  int? _id;
  String? _name;
  String? _slug;
  int? _order;
  String? _created;
  String? _updated;
Subject copyWith({  int? id,
  String? name,
  String? slug,
  int? order,
  String? created,
  String? updated,
}) => Subject(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  order: order ?? _order,
  created: created ?? _created,
  updated: updated ?? _updated,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  String? get created => _created;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    map['created'] = _created;
    map['updated'] = _updated;
    return map;
  }

}