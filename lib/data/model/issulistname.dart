import 'dart:convert';
/// issue : [{"name":"Select issue"},{"name":"App Crashing"},{"name":"Exam Guidance"},{"name":"Study Help"},{"name":"Purchase help"},{"name":"Other"}]

Issulistname issulistnameFromJson(String str) => Issulistname.fromJson(json.decode(str));
String issulistnameToJson(Issulistname data) => json.encode(data.toJson());
class Issulistname {
  Issulistname({
      List<Issue>? issue,}){
    _issue = issue;
}

  Issulistname.fromJson(dynamic json) {
    if (json['issue'] != null) {
      _issue = [];
      json['issue'].forEach((v) {
        _issue?.add(Issue.fromJson(v));
      });
    }
  }
  List<Issue>? _issue;

  List<Issue>? get issue => _issue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_issue != null) {
      map['issue'] = _issue?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Select issue"

Issue issueFromJson(String str) => Issue.fromJson(json.decode(str));
String issueToJson(Issue data) => json.encode(data.toJson());
class Issue {
  Issue({
      String? name,}){
    _name = name;
}

  Issue.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}