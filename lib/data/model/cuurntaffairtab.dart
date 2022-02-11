import 'dart:convert';
/// currentaffairs : [{"id":"0","name":"Videos"},{"id":"1","name":"Contents"}]

Cuurntaffairtab cuurntaffairtabFromJson(String str) => Cuurntaffairtab.fromJson(json.decode(str));
String cuurntaffairtabToJson(Cuurntaffairtab data) => json.encode(data.toJson());
class Cuurntaffairtab {
  Cuurntaffairtab({
      List<Currentaffairs>? currentaffairs,}){
    _currentaffairs = currentaffairs;
}

  Cuurntaffairtab.fromJson(dynamic json) {
    if (json['currentaffairs'] != null) {
      _currentaffairs = [];
      json['currentaffairs'].forEach((v) {
        _currentaffairs?.add(Currentaffairs.fromJson(v));
      });
    }
  }
  List<Currentaffairs>? _currentaffairs;

  List<Currentaffairs>? get currentaffairs => _currentaffairs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_currentaffairs != null) {
      map['currentaffairs'] = _currentaffairs?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "0"
/// name : "Videos"

Currentaffairs currentaffairsFromJson(String str) => Currentaffairs.fromJson(json.decode(str));
String currentaffairsToJson(Currentaffairs data) => json.encode(data.toJson());
class Currentaffairs {
  Currentaffairs({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Currentaffairs.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}