import 'dart:convert';
/// id : 3
/// name : "UP LEKHPAL मुख्य परीक्षा 2022"
/// slug : "up-lekhpal-mukhya-pariksha-2022"
/// order : 0
/// active : true
/// created : "2022-04-22T11:49:01.896257"
/// updated : "2022-04-22T11:52:19.930688"

FreeVideoModel freevideomodelFromJson(String str) => FreeVideoModel.fromJson(json.decode(str));
String freevideomodelToJson(FreeVideoModel data) => json.encode(data.toJson());
class FreeVideoModel {
  FreeVideoModel({
    int? id,
    String? name,
    String? slug,
    int? order,
    bool? active,
    String? created,
    String? updated,}){
    _id = id;
    _name = name;
    _slug = slug;
    _order = order;
    _active = active;
    _created = created;
    _updated = updated;
  }

  FreeVideoModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _order = json['order'];
    _active = json['active'];
    _created = json['created'];
    _updated = json['updated'];
  }
  int? _id;
  String? _name;
  String? _slug;
  int? _order;
  bool? _active;
  String? _created;
  String? _updated;
  FreeVideoModel copyWith({  int? id,
    String? name,
    String? slug,
    int? order,
    bool? active,
    String? created,
    String? updated,
  }) => FreeVideoModel(  id: id ?? _id,
    name: name ?? _name,
    slug: slug ?? _slug,
    order: order ?? _order,
    active: active ?? _active,
    created: created ?? _created,
    updated: updated ?? _updated,
  );
  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  int? get order => _order;
  bool? get active => _active;
  String? get created => _created;
  String? get updated => _updated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['order'] = _order;
    map['active'] = _active;
    map['created'] = _created;
    map['updated'] = _updated;
    return map;
  }

}