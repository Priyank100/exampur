// To parse this JSON data, do
//
//     final userInformationModel = userInformationModelFromJson(jsonString);

import 'dart:convert';

class UserInformationModel {
  UserInformationModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  Data? data;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) => UserInformationModel(
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.phoneExt,
    this.phone,
    this.firstName,
    this.lastName,
    this.language,
    this.emailId,
    this.city,
    this.state,
    this.country,
    this.phoneConf,
    this.authToken,
  });

  int? phoneExt;
  int? phone;
  String? firstName;
  String? lastName;
  String? language;
  String? emailId;
  String? city;
  String? state;
  String? country;
  bool? phoneConf;
  String? authToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneExt: json["phone_ext"],
    phone: json["phone"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    language: json["language"],
    emailId: json["email_id"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    phoneConf: json["phone_conf"],
    authToken: json["authToken"],
  );

  Map<String, dynamic> toJson() => {
    "phone_ext": phoneExt,
    "phone": phone,
    "first_name": firstName,
    "last_name": lastName,
    "language": language,
    "email_id": emailId,
    "city": city,
    "state": state,
    "country": country,
    "phone_conf": phoneConf,
    "authToken": authToken,
  };
}