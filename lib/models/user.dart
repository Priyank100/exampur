// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.phoneExt,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.language,
    required this.emailId,
    required this.city,
    required this.state,
    required this.country,
    required this.emailConf,
    required this.phoneConf,
  });

  String phoneExt;
  String phone;
  String firstName;
  String lastName;
  String language;
  String emailId;
  String city;
  String state;
  String country;
  bool emailConf;
  bool phoneConf;

  factory User.fromJson(Map<String, dynamic> json) => User(
        phoneExt: json["phone_ext"] == null ? "" : json["phone_ext"],
        phone: json["phone"] == null ? "" : json["phone"],
        firstName: json["first_name"] == null ? "" : json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        language: json["language"] == null ? "" : json["language"],
        emailId: json["email_id"] == null ? "" : json["email_id"],
        city: json["city"] == null ? "" : json["city"],
        state: json["state"] == null ? "" : json["state"],
        country: json["country"] == null ? "" : json["country"],
        emailConf: json["email_conf"] == null ? "" : json["email_conf"],
        phoneConf: json["phone_conf"] == null ? "" : json["phone_conf"],
      );

  Map<String, dynamic> toJson() => {
        "phone_ext": phoneExt == null ? null : phoneExt,
        "phone": phone == null ? null : phone,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "language": language == null ? null : language,
        "email_id": emailId == null ? null : emailId,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "email_conf": emailConf == null ? null : emailConf,
        "phone_conf": phoneConf == null ? null : phoneConf,
      };
}

class UserList {
  final List<User> userList;

  UserList({required this.userList});
}
