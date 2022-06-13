import 'dart:convert';
/// id : 2
/// name : "SSC GD"
/// slug : "ssc-gd"
/// is_active : true
/// order : 0
/// created : "2022-04-25T16:17:02.774"
/// subject : [{"id":2,"name":"English","slug":"english","is_active":true,"order":0,"created":"2022-04-25T16:18:04.458"}]

StudyNotesSubjectModel studyNotesSubjectModelFromJson(String str) => StudyNotesSubjectModel.fromJson(json.decode(str));
String studyNotesSubjectModelToJson(StudyNotesSubjectModel data) => json.encode(data.toJson());
class StudyNotesSubjectModel {
  StudyNotesSubjectModel({
      int? id, 
      String? name, 
      String? slug, 
      bool? isActive, 
      int? order, 
      String? created, 
      List<Subject>? subject,}){
    _id = id;
    _name = name;
    _slug = slug;
    _isActive = isActive;
    _order = order;
    _created = created;
    _subject = subject;
}

  StudyNotesSubjectModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _isActive = json['is_active'];
    _order = json['order'];
    _created = json['created'];
    if (json['subject'] != null) {
      _subject = [];
      json['subject'].forEach((v) {
        _subject?.add(Subject.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _slug;
  bool? _isActive;
  int? _order;
  String? _created;
  List<Subject>? _subject;
StudyNotesSubjectModel copyWith({  int? id,
  String? name,
  String? slug,
  bool? isActive,
  int? order,
  String? created,
  List<Subject>? subject,
}) => StudyNotesSubjectModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  isActive: isActive ?? _isActive,
  order: order ?? _order,
  created: created ?? _created,
  subject: subject ?? _subject,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  bool? get isActive => _isActive;
  int? get order => _order;
  String? get created => _created;
  List<Subject>? get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['is_active'] = _isActive;
    map['order'] = _order;
    map['created'] = _created;
    if (_subject != null) {
      map['subject'] = _subject?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// name : "English"
/// slug : "english"
/// is_active : true
/// order : 0
/// created : "2022-04-25T16:18:04.458"

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));
String subjectToJson(Subject data) => json.encode(data.toJson());
class Subject {
  Subject({
      int? id, 
      String? name, 
      String? slug, 
      bool? isActive, 
      int? order, 
      String? created,}){
    _id = id;
    _name = name;
    _slug = slug;
    _isActive = isActive;
    _order = order;
    _created = created;
}

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _isActive = json['is_active'];
    _order = json['order'];
    _created = json['created'];
  }
  int? _id;
  String? _name;
  String? _slug;
  bool? _isActive;
  int? _order;
  String? _created;
Subject copyWith({  int? id,
  String? name,
  String? slug,
  bool? isActive,
  int? order,
  String? created,
}) => Subject(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  isActive: isActive ?? _isActive,
  order: order ?? _order,
  created: created ?? _created,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  bool? get isActive => _isActive;
  int? get order => _order;
  String? get created => _created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['is_active'] = _isActive;
    map['order'] = _order;
    map['created'] = _created;
    return map;
  }

}