import 'dart:convert';
/// states : [{"name":"Andaman and Nicobar Islands"},{"name":"Andhra Pradesh"},{"name":"Assam"},{"name":"Bihar"},{"name":"Chandigarh"},{"name":"Chhattisgarh"},{"name":"Dadra and Nagar Haveli"},{"name":"Daman and Diu"},{"name":"Delhi"},{"name":"Goa"},{"name":"Gujarat"},{"name":"Haryana"},{"name":"Himachal Pradesh"},{"name":"Jammu and Kashmir"},{"name":"Jharkhand"},{"name":"Karnataka"},{"name":"Kerala"},{"name":"Ladakh"},{"name":"Lakshadweep"},{"name":"Madhya Pradesh"},{"name":"Maharashtra"},{"name":"Manipur"},{"name":"Meghalaya"},{"name":"Mizoram"},{"name":"Nagaland"},{"name":"Odisha"},{"name":"Puducherry"},{"name":"Punjab"},{"name":"Rajasthan"},{"name":"Sikkim"},{"name":"Tamil Nadu"},{"name":"Telangana"},{"name":"Tripura"},{"name":"Uttar Pradesh"},{"name":"Uttarakhand"},{"name":"West Bengal"}]

StateJson stateJsonFromJson(String str) => StateJson.fromJson(json.decode(str));
String stateJsonToJson(StateJson data) => json.encode(data.toJson());
class StateJson {
  StateJson({
      List<States>? states,}){
    _states = states;
}

  StateJson.fromJson(dynamic json) {
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
  }
  List<States>? _states;

  List<States>? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Andaman and Nicobar Islands"

States statesFromJson(String str) => States.fromJson(json.decode(str));
String statesToJson(States data) => json.encode(data.toJson());
class States {
  States({
      String? name,}){
    _name = name;
}

  States.fromJson(dynamic json) {
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