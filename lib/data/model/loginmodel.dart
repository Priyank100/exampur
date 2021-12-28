// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.phoneExt,
    this.phone,
    this.password,
  });

  String? phoneExt;
  String? phone;
  String? password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    phoneExt: json["phone_ext"],
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone_ext": phoneExt,
    "phone": phone,
    "password": password,
  };
}
