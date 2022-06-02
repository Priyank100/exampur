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
    this.email,
    this.password,
  });

  String? phoneExt;
  String? phone;
  String? email;
  String? password;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    phoneExt: json["phone_ext"],
    phone: json["phone"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone_ext": phoneExt,
    "phone": phone,
    "email": email,
    "password": password,
  };
}
