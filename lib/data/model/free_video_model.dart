import 'dart:convert';
/// name : "UP LEKHPAL मुख्य परीक्षा 2022"
/// slug : "up-lekhpal-mukhya-pariksha-2022"

FreeVideoModel freeVideoModelFromJson(String str) => FreeVideoModel.fromJson(json.decode(str));
String freeVideoModelToJson(FreeVideoModel data) => json.encode(data.toJson());
class FreeVideoModel {
  FreeVideoModel({
      String? name, 
      String? slug,}){
    _name = name;
    _slug = slug;
}

  FreeVideoModel.fromJson(dynamic json) {
    _name = json['name'];
    _slug = json['slug'];
  }
  String? _name;
  String? _slug;
FreeVideoModel copyWith({  String? name,
  String? slug,
}) => FreeVideoModel(  name: name ?? _name,
  slug: slug ?? _slug,
);
  String? get name => _name;
  String? get slug => _slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['slug'] = _slug;
    return map;
  }

}