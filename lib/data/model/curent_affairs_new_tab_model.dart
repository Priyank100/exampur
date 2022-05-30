import 'dart:convert';
/// id : 1
/// title_eng : "DAILY CURRENT AFFAIRS"
/// title_hindi : "दैनिक करंट अफेयर्स"
/// slug : "news"
/// order : 0
/// active : true
/// created : "2021-10-18T16:38:59.493444"
/// updated : "2021-12-21T16:49:45.689061"
/// main_category : 1

CurentAffairsNewTabModel curentAffairsNewTabModelFromJson(String str) => CurentAffairsNewTabModel.fromJson(json.decode(str));
String curentAffairsNewTabModelToJson(CurentAffairsNewTabModel data) => json.encode(data.toJson());

class CurentAffairsNewTabModel {
  CurentAffairsNewTabModel({
      int? id, 
      String? titleEng, 
      String? titleHindi, 
      String? slug, 
      int? order, 
      bool? active, 
      String? created, 
      String? updated, 
      int? mainCategory,}){
    _id = id;
    _titleEng = titleEng;
    _titleHindi = titleHindi;
    _slug = slug;
    _order = order;
    _active = active;
    _created = created;
    _updated = updated;
    _mainCategory = mainCategory;
}

  CurentAffairsNewTabModel.fromJson(dynamic json) {
    _id = json['id'];
    _titleEng = json['title_eng'];
    _titleHindi = json['title_hindi'];
    _slug = json['slug'];
    _order = json['order'];
    _active = json['active'];
    _created = json['created'];
    _updated = json['updated'];
    _mainCategory = json['main_category'];
  }
  int? _id;
  String? _titleEng;
  String? _titleHindi;
  String? _slug;
  int? _order;
  bool? _active;
  String? _created;
  String? _updated;
  int? _mainCategory;

  int? get id => _id;
  String? get titleEng => _titleEng;
  String? get titleHindi => _titleHindi;
  String? get slug => _slug;
  int? get order => _order;
  bool? get active => _active;
  String? get created => _created;
  String? get updated => _updated;
  int? get mainCategory => _mainCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title_eng'] = _titleEng;
    map['title_hindi'] = _titleHindi;
    map['slug'] = _slug;
    map['order'] = _order;
    map['active'] = _active;
    map['created'] = _created;
    map['updated'] = _updated;
    map['main_category'] = _mainCategory;
    return map;
  }

}