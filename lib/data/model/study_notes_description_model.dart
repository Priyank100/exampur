import 'dart:convert';
/// id : 1
/// title : "Error nd non Error"
/// slug : "error-nd-non-error"
/// order : 0
/// description : "<p>this is for testing</p><p><br></p><h3>RBI 2021:</h3><p><br></p><p dir=\"ltr\">The Reserve Bank of India (RBI) has finally published the result of the prelims exam on 21st April 2022 for the position of Assistant on its website (Opportunities @ RBI). The bank has prepared a list of qualified candidates for the RBI Assistant Exam, which includes their roll numbers. The candidates who took the RBI Assistant Exam on<strong>&nbsp; March 26 and 27, 2022, c</strong>an now download their RBI Assistant Pre Result by clicking on the RBI Assistant Result Link provided below.</p><p dir=\"ltr\">Download Link for RBI Assistant Result</p><p dir=\"ltr\">To view the notice, click here:<br>Result of online Preliminary examination held on March 26 &amp; 27, 2022 for Recruitment of Assistant- PY 2021&nbsp;</p><p dir=\"ltr\">Along with the result, Bank has also given the brief information about the Main Examination which is to be conducted on 8th May 2022.</p><p dir=\"ltr\">According to the information, the main online examination will be held on May 8, 2022 (Sunday) only for &nbsp;the candidates who have been shortlisted based on preliminary examination results. Separate Admission Letters could be obtained from the RBI website regarding the time of the Main Examination and the location of the Examinations.</p>"
/// is_active : true
/// created : "2022-04-25T16:34:50.462"

StudyNotesDescriptionModel studyNotesDescriptionModelFromJson(String str) => StudyNotesDescriptionModel.fromJson(json.decode(str));
String studyNotesDescriptionModelToJson(StudyNotesDescriptionModel data) => json.encode(data.toJson());
class StudyNotesDescriptionModel {
  StudyNotesDescriptionModel({
      int? id, 
      String? title, 
      String? slug, 
      int? order, 
      String? description, 
      bool? isActive, 
      String? created,}){
    _id = id;
    _title = title;
    _slug = slug;
    _order = order;
    _description = description;
    _isActive = isActive;
    _created = created;
}

  StudyNotesDescriptionModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _order = json['order'];
    _description = json['description'];
    _isActive = json['is_active'];
    _created = json['created'];
  }
  int? _id;
  String? _title;
  String? _slug;
  int? _order;
  String? _description;
  bool? _isActive;
  String? _created;
StudyNotesDescriptionModel copyWith({  int? id,
  String? title,
  String? slug,
  int? order,
  String? description,
  bool? isActive,
  String? created,
}) => StudyNotesDescriptionModel(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  order: order ?? _order,
  description: description ?? _description,
  isActive: isActive ?? _isActive,
  created: created ?? _created,
);
  int? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  int? get order => _order;
  String? get description => _description;
  bool? get isActive => _isActive;
  String? get created => _created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['order'] = _order;
    map['description'] = _description;
    map['is_active'] = _isActive;
    map['created'] = _created;
    return map;
  }

}