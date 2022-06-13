import 'dart:convert';
/// id : 2
/// name : "English"
/// slug : "english"
/// subject : [{"id":2,"name":"Error Handling","slug":"error-handling","is_active":true,"order":0,"created":"2022-04-25T16:26:16.086","content":[{"id":1,"title":"Error nd non Error","slug":"error-nd-non-error","order":0,"is_active":true}]}]

StudyNotesChaperModel studyNotesChaperModelFromJson(String str) => StudyNotesChaperModel.fromJson(json.decode(str));
String studyNotesChaperModelToJson(StudyNotesChaperModel data) => json.encode(data.toJson());
class StudyNotesChaperModel {
  StudyNotesChaperModel({
      int? id, 
      String? name, 
      String? slug, 
      List<Subject>? subject,}){
    _id = id;
    _name = name;
    _slug = slug;
    _subject = subject;
}

  StudyNotesChaperModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
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
  List<Subject>? _subject;
StudyNotesChaperModel copyWith({  int? id,
  String? name,
  String? slug,
  List<Subject>? subject,
}) => StudyNotesChaperModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  subject: subject ?? _subject,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  List<Subject>? get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    if (_subject != null) {
      map['subject'] = _subject?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// name : "Error Handling"
/// slug : "error-handling"
/// is_active : true
/// order : 0
/// created : "2022-04-25T16:26:16.086"
/// content : [{"id":1,"title":"Error nd non Error","slug":"error-nd-non-error","order":0,"is_active":true}]

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));
String subjectToJson(Subject data) => json.encode(data.toJson());
class Subject {
  Subject({
      int? id, 
      String? name, 
      String? slug, 
      bool? isActive, 
      int? order, 
      String? created, 
      List<Content>? content,}){
    _id = id;
    _name = name;
    _slug = slug;
    _isActive = isActive;
    _order = order;
    _created = created;
    _content = content;
}

  Subject.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _isActive = json['is_active'];
    _order = json['order'];
    _created = json['created'];
    if (json['content'] != null) {
      _content = [];
      json['content'].forEach((v) {
        _content?.add(Content.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _slug;
  bool? _isActive;
  int? _order;
  String? _created;
  List<Content>? _content;
Subject copyWith({  int? id,
  String? name,
  String? slug,
  bool? isActive,
  int? order,
  String? created,
  List<Content>? content,
}) => Subject(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  isActive: isActive ?? _isActive,
  order: order ?? _order,
  created: created ?? _created,
  content: content ?? _content,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  bool? get isActive => _isActive;
  int? get order => _order;
  String? get created => _created;
  List<Content>? get content => _content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['is_active'] = _isActive;
    map['order'] = _order;
    map['created'] = _created;
    if (_content != null) {
      map['content'] = _content?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "Error nd non Error"
/// slug : "error-nd-non-error"
/// order : 0
/// is_active : true

Content contentFromJson(String str) => Content.fromJson(json.decode(str));
String contentToJson(Content data) => json.encode(data.toJson());
class Content {
  Content({
      int? id, 
      String? title, 
      String? slug, 
      int? order, 
      bool? isActive,}){
    _id = id;
    _title = title;
    _slug = slug;
    _order = order;
    _isActive = isActive;
}

  Content.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _order = json['order'];
    _isActive = json['is_active'];
  }
  int? _id;
  String? _title;
  String? _slug;
  int? _order;
  bool? _isActive;
Content copyWith({  int? id,
  String? title,
  String? slug,
  int? order,
  bool? isActive,
}) => Content(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  order: order ?? _order,
  isActive: isActive ?? _isActive,
);
  int? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  int? get order => _order;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['order'] = _order;
    map['is_active'] = _isActive;
    return map;
  }

}