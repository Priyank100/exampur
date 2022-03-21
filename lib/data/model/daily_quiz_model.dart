import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"62370b4e6716a433bd114f0d","quiz_title":"adfs","quiz_duration":10,"quiz_instruction":"dfs","status":"Published"},{"_id":"6238034e9e0b33068018d3ca","quiz_title":"test12","quiz_duration":13,"quiz_instruction":"play safely","status":"Published"}]

DailyQuizModel dailyQuizModelFromJson(String str) => DailyQuizModel.fromJson(json.decode(str));
String dailyQuizModelToJson(DailyQuizModel data) => json.encode(data.toJson());
class DailyQuizModel {
  DailyQuizModel({
      int? statusCode, 
      List<Data>? data,}){
    _statusCode = statusCode;
    _data = data;
}

  DailyQuizModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<Data>? _data;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "62370b4e6716a433bd114f0d"
/// quiz_title : "adfs"
/// quiz_duration : 10
/// quiz_instruction : "dfs"
/// status : "Published"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? quizTitle, 
      int? quizDuration, 
      String? quizInstruction, 
      String? status,}){
    _id = id;
    _quizTitle = quizTitle;
    _quizDuration = quizDuration;
    _quizInstruction = quizInstruction;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _quizTitle = json['quiz_title'];
    _quizDuration = json['quiz_duration'];
    _quizInstruction = json['quiz_instruction'];
    _status = json['status'];
  }
  String? _id;
  String? _quizTitle;
  int? _quizDuration;
  String? _quizInstruction;
  String? _status;

  String? get id => _id;
  String? get quizTitle => _quizTitle;
  int? get quizDuration => _quizDuration;
  String? get quizInstruction => _quizInstruction;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['quiz_title'] = _quizTitle;
    map['quiz_duration'] = _quizDuration;
    map['quiz_instruction'] = _quizInstruction;
    map['status'] = _status;
    return map;
  }

}