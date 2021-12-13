// To parse this JSON data, do
//
//     final offlineCenter = offlineCenterFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<OfflineCenter> offlineCenterFromJson(String str) => List<OfflineCenter>.from(json.decode(str).map((x) => OfflineCenter.fromJson(x)));

String offlineCenterToJson(List<OfflineCenter> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfflineCenter {
  OfflineCenter({
    required this.name,
    required this.description,
    required this.phoneExt,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
  });

  String name;
  String description;
  String phoneExt;
  String phone;
  String address;
  String city;
  String state;
  String pincode;
  String country;

  factory OfflineCenter.fromJson(Map<String, dynamic> json) => OfflineCenter(
    name: json["name"] == null ? "" : json["name"],
    description: json["description"] == null ? "" : json["description"],
    phoneExt: json["phone_ext"] == null ? "" : json["phone_ext"],
    phone: json["phone"] == null ? "" : json["phone"],
    address: json["address"] == null ? "" : json["address"],
    city: json["city"] == null ? "" : json["city"],
    state: json["state"] == null ? "" : json["state"],
    pincode: json["pincode"] == null ? "" : json["pincode"],
    country: json["country"] == null ? "" : json["country"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "phone_ext": phoneExt == null ? null : phoneExt,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "pincode": pincode == null ? null : pincode,
    "country": country == null ? null : country,
  };
}
