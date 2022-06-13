import 'dart:convert';
/// subject_id : 2
/// name : "Maths"
/// slug : "up-lekhpal-2022-maths"
/// order : 1
/// chapter : [{"id":5,"name":"demo chapter 1","slug":"up-lekhpal-2022maths-demo-chapter-1","order":0,"created":"2022-06-03T15:09:08.448","updated":"2022-06-03T15:09:08.448","video_content":[{"id":4,"title":"demo mathematics video","slug":"up-lekhpal-2022mathsdemo-chapter-1-demo-mathematics-video","video_url":"y8wae3aVr7k","pdf_url":null,"test_url":null,"order":0,"created":"2022-06-03T15:12:06.135","updated":"2022-06-03T16:37:44.609"}]}]

FreeVideoContentModel freeVideoContentModelFromJson(String str) => FreeVideoContentModel.fromJson(json.decode(str));
String freeVideoContentModelToJson(FreeVideoContentModel data) => json.encode(data.toJson());
class FreeVideoContentModel {
  FreeVideoContentModel({
      int? subjectId, 
      String? name, 
      String? slug, 
      int? order, 
      List<Chapter>? chapter,}){
    _subjectId = subjectId;
    _name = name;
    _slug = slug;
    _order = order;
    _chapter = chapter;
}

  FreeVideoContentModel.fromJson(dynamic json) {
    _subjectId = json['subject_id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    if (json['chapter'] != null) {
      _chapter = [];
      json['chapter'].forEach((v) {
        _chapter?.add(Chapter.fromJson(v));
      });
    }
  }
  int? _subjectId;
  String? _name;
  String? _slug;
  int? _order;
  List<Chapter>? _chapter;
FreeVideoContentModel copyWith({  int? subjectId,
  String? name,
  String? slug,
  int? order,
  List<Chapter>? chapter,
}) => FreeVideoContentModel(  subjectId: subjectId ?? _subjectId,
  name: name ?? _name,
  slug: slug ?? _slug,
  order: order ?? _order,
  chapter: chapter ?? _chapter,
);
  int? get subjectId => _subjectId;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  List<Chapter>? get chapter => _chapter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subject_id'] = _subjectId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    if (_chapter != null) {
      map['chapter'] = _chapter?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 5
/// name : "demo chapter 1"
/// slug : "up-lekhpal-2022maths-demo-chapter-1"
/// order : 0
/// created : "2022-06-03T15:09:08.448"
/// updated : "2022-06-03T15:09:08.448"
/// video_content : [{"id":4,"title":"demo mathematics video","slug":"up-lekhpal-2022mathsdemo-chapter-1-demo-mathematics-video","video_url":"y8wae3aVr7k","pdf_url":null,"test_url":null,"order":0,"created":"2022-06-03T15:12:06.135","updated":"2022-06-03T16:37:44.609"}]

Chapter chapterFromJson(String str) => Chapter.fromJson(json.decode(str));
String chapterToJson(Chapter data) => json.encode(data.toJson());
class Chapter {
  Chapter({
      int? id, 
      String? name, 
      String? slug, 
      int? order, 
      String? created, 
      String? updated, 
      List<VideoContent>? videoContent,}){
    _id = id;
    _name = name;
    _slug = slug;
    _order = order;
    _created = created;
    _updated = updated;
    _videoContent = videoContent;
}

  Chapter.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    _created = json['created'];
    _updated = json['updated'];
    if (json['video_content'] != null) {
      _videoContent = [];
      json['video_content'].forEach((v) {
        _videoContent?.add(VideoContent.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _slug;
  int? _order;
  String? _created;
  String? _updated;
  List<VideoContent>? _videoContent;
Chapter copyWith({  int? id,
  String? name,
  String? slug,
  int? order,
  String? created,
  String? updated,
  List<VideoContent>? videoContent,
}) => Chapter(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  order: order ?? _order,
  created: created ?? _created,
  updated: updated ?? _updated,
  videoContent: videoContent ?? _videoContent,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  String? get created => _created;
  String? get updated => _updated;
  List<VideoContent>? get videoContent => _videoContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    map['created'] = _created;
    map['updated'] = _updated;
    if (_videoContent != null) {
      map['video_content'] = _videoContent?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// title : "demo mathematics video"
/// slug : "up-lekhpal-2022mathsdemo-chapter-1-demo-mathematics-video"
/// video_url : "y8wae3aVr7k"
/// pdf_url : null
/// test_url : null
/// order : 0
/// created : "2022-06-03T15:12:06.135"
/// updated : "2022-06-03T16:37:44.609"

VideoContent videoContentFromJson(String str) => VideoContent.fromJson(json.decode(str));
String videoContentToJson(VideoContent data) => json.encode(data.toJson());
class VideoContent {
  VideoContent({
      int? id, 
      String? title, 
      String? slug, 
      String? videoUrl, 
      dynamic pdfUrl, 
      dynamic testUrl, 
      int? order, 
      String? created, 
      String? updated,}){
    _id = id;
    _title = title;
    _slug = slug;
    _videoUrl = videoUrl;
    _pdfUrl = pdfUrl;
    _testUrl = testUrl;
    _order = order;
    _created = created;
    _updated = updated;
}

  VideoContent.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _videoUrl = json['video_url'];
    _pdfUrl = json['pdf_url'];
    _testUrl = json['test_url'];
    _order = json['order'];
    _created = json['created'];
    _updated = json['updated'];
  }
  int? _id;
  String? _title;
  String? _slug;
  String? _videoUrl;
  dynamic _pdfUrl;
  dynamic _testUrl;
  int? _order;
  String? _created;
  String? _updated;
VideoContent copyWith({  int? id,
  String? title,
  String? slug,
  String? videoUrl,
  dynamic pdfUrl,
  dynamic testUrl,
  int? order,
  String? created,
  String? updated,
}) => VideoContent(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  videoUrl: videoUrl ?? _videoUrl,
  pdfUrl: pdfUrl ?? _pdfUrl,
  testUrl: testUrl ?? _testUrl,
  order: order ?? _order,
  created: created ?? _created,
  updated: updated ?? _updated,
);
  int? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get videoUrl => _videoUrl;
  dynamic get pdfUrl => _pdfUrl;
  dynamic get testUrl => _testUrl;
  int? get order => _order;
  String? get created => _created;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['video_url'] = _videoUrl;
    map['pdf_url'] = _pdfUrl;
    map['test_url'] = _testUrl;
    map['order'] = _order;
    map['created'] = _created;
    map['updated'] = _updated;
    return map;
  }

}