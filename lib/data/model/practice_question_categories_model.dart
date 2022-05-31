import 'dart:convert';
/// id : 1
/// name : "Current Affairs"
/// slug : "current-affairs"
/// sub_cat : [{"id":26,"name":"JANUARY 2022","slug":"january-2022"},{"id":27,"name":"FEBRUARY 2022","slug":"february-2022"},{"id":28,"name":"MARCH 2022","slug":"march-2022"},{"id":25,"name":"APRIL 2022","slug":"april-2022"},{"id":20,"name":"May 2022","slug":"may-2022"}]

PracticeQuestionCategoriesModel practiceQuestionCategoreiesModelFromJson(String str) => PracticeQuestionCategoriesModel.fromJson(json.decode(str));
String practiceQuestionCategoriesModelToJson(PracticeQuestionCategoriesModel data) => json.encode(data.toJson());
class PracticeQuestionCategoriesModel {
  PracticeQuestionCategoriesModel({
      int? id, 
      String? name, 
      String? slug, 
      List<SubCat>? subCat,}){
    _id = id;
    _name = name;
    _slug = slug;
    _subCat = subCat;
}

  PracticeQuestionCategoriesModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    if (json['sub_cat'] != null) {
      _subCat = [];
      json['sub_cat'].forEach((v) {
        _subCat?.add(SubCat.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _slug;
  List<SubCat>? _subCat;
PracticeQuestionCategoriesModel copyWith({  int? id,
  String? name,
  String? slug,
  List<SubCat>? subCat,
}) => PracticeQuestionCategoriesModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  subCat: subCat ?? _subCat,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  List<SubCat>? get subCat => _subCat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    if (_subCat != null) {
      map['sub_cat'] = _subCat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 26
/// name : "JANUARY 2022"
/// slug : "january-2022"

SubCat subCatFromJson(String str) => SubCat.fromJson(json.decode(str));
String subCatToJson(SubCat data) => json.encode(data.toJson());
class SubCat {
  SubCat({
      int? id, 
      String? name, 
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  SubCat.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
  int? _id;
  String? _name;
  String? _slug;
SubCat copyWith({  int? id,
  String? name,
  String? slug,
}) => SubCat(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
);
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}