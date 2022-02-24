import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"621537cc5cc7a038b4ad701a","subject_id":{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"},"title":"Test Material 3","video_link":"https://www.youtube.com/watch?v=HSbI22nVE1Y","doc_path":"course_material/621537cc5cc7a038b4ad701a/oIgQmjsJ-test-upload-docx","pdf_path":"course_material/621537cc5cc7a038b4ad701a/DgfZscxI-test-upload-pdf"},{"_id":"62153546c6b7f639eb1ccbfb","subject_id":{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"},"title":"Test Material 2","video_link":"https://www.youtube.com/watch?v=YfO28Ihehbk","doc_path":"course_material/62153546c6b7f639eb1ccbfb/7W5teBnz-test-upload-docx"},{"_id":"621534e0c6b7f639eb1ccbee","subject_id":{"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"},"title":"Test Material 1","video_link":"https://www.youtube.com/watch?v=HSbI22nVE1Y"}]

MyCourseMaterialModel myCourseMaterialModelFromJson(String str) => MyCourseMaterialModel.fromJson(json.decode(str));
String myCourseMaterialModelToJson(MyCourseMaterialModel data) => json.encode(data.toJson());
class MyCourseMaterialModel {
  MyCourseMaterialModel({
      int? statusCode, 
      List<MaterialData>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  MyCourseMaterialModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MaterialData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<MaterialData>? _data;

  int? get statusCode => _statusCode;
  List<MaterialData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "621537cc5cc7a038b4ad701a"
/// subject_id : {"_id":"61da9cb904d40f7873b61f2e","title":"First Subject"}
/// title : "Test Material 3"
/// video_link : "https://www.youtube.com/watch?v=HSbI22nVE1Y"
/// doc_path : "course_material/621537cc5cc7a038b4ad701a/oIgQmjsJ-test-upload-docx"
/// pdf_path : "course_material/621537cc5cc7a038b4ad701a/DgfZscxI-test-upload-pdf"

MaterialData dataFromJson(String str) => MaterialData.fromJson(json.decode(str));
String dataToJson(MaterialData data) => json.encode(data.toJson());
class MaterialData {
  MaterialData({
    String? id,
    SubjectId? subjectId,
    String? title,
    String? videoLink,
    String? docPath,
    String? pdfPath,}){
    _id = id;
    _subjectId = subjectId;
    _title = title;
    _videoLink = videoLink;
    _docPath = docPath;
    _pdfPath = pdfPath;
}

  MaterialData.fromJson(dynamic json) {
    _id = json['_id'];
    _subjectId = json['subject_id'] != null ? SubjectId.fromJson(json['subject_id']) : null;
    _title = json['title'];
    _videoLink = json['video_link'];
    _docPath = json['doc_path'];
    _pdfPath = json['pdf_path'];
  }
  String? _id;
  SubjectId? _subjectId;
  String? _title;
  String? _videoLink;
  String? _docPath;
  String? _pdfPath;

  String? get id => _id;
  SubjectId? get subjectId => _subjectId;
  String? get title => _title;
  String? get videoLink => _videoLink;
  String? get docPath => _docPath;
  String? get pdfPath => _pdfPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_subjectId != null) {
      map['subject_id'] = _subjectId?.toJson();
    }
    map['title'] = _title;
    map['video_link'] = _videoLink;
    map['doc_path'] = _docPath;
    map['pdf_path'] = _pdfPath;
    return map;
  }

}

/// _id : "61da9cb904d40f7873b61f2e"
/// title : "First Subject"

SubjectId subject_idFromJson(String str) => SubjectId.fromJson(json.decode(str));
String subject_idToJson(SubjectId data) => json.encode(data.toJson());

class SubjectId {
  SubjectId({
      String? id, 
      String? title,}){
    _sid = id;
    _title = title;
}

  SubjectId.fromJson(dynamic json) {
    _sid = json['_id'];
    _title = json['title'];
  }
  String? _sid;
  String? _title;

  String? get id => _sid;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _sid;
    map['title'] = _title;
    return map;
  }

}