import 'dart:convert';
/// id : 20
/// name : "Russia-Ukraine"
/// slug : "russia-ukraine"

CurrentAffairsNewTagListModel currentAffairsNewTagListModelFromJson(String str) => CurrentAffairsNewTagListModel.fromJson(json.decode(str));
String currentAffairsNewTagListModelToJson(CurrentAffairsNewTagListModel data) => json.encode(data.toJson());

class CurrentAffairsNewTagListModel {
  CurrentAffairsNewTagListModel({
      int? id, 
      String? name, 
      String? slug,}){
    _id = id;
    _name = name;
    _slug = slug;
}

  CurrentAffairsNewTagListModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
  }
  int? _id;
  String? _name;
  String? _slug;

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