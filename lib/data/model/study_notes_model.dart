import 'dart:convert';
/// id : 2
/// name : "SSC GD"
/// slug : "ssc-gd"
/// is_active : true
/// order : 0
/// created : "2022-04-25T16:17:02.774"

StudyNotesModel studyNotesModelFromJson(String str) => StudyNotesModel.fromJson(json.decode(str));
String studyNotesModelToJson(StudyNotesModel data) => json.encode(data.toJson());
class StudyNotesModel {
  StudyNotesModel({
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

  StudyNotesModel.fromJson(dynamic json) {
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
StudyNotesModel copyWith({  int? id,
  String? name,
  String? slug,
  bool? isActive,
  int? order,
  String? created,
}) => StudyNotesModel(  id: id ?? _id,
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