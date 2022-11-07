// To parse this JSON data, do
//
//     final userInformationModel = userInformationModelFromJson(jsonString);

import 'dart:convert';

class MoEngageUserModel {
  MoEngageUserModel({
    this.statusCode,
    this.data,
  });

  int? statusCode;
  UserDetail? data;


  MoEngageUserModel._privateConstructor();
  static final MoEngageUserModel _instance = MoEngageUserModel._privateConstructor();
  static MoEngageUserModel get instance => _instance;

  factory MoEngageUserModel.fromJson(Map<String, dynamic> json) => MoEngageUserModel(
    statusCode: json["statusCode"],
    data: UserDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data!.toJson(),
  };
}

class UserDetail {
  UserDetail({
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
    this.countCategories
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
  int? countCategories;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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
    countCategories: json["count_categories"] ?? 0,
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
    "count_categories": countCategories,
  };
}