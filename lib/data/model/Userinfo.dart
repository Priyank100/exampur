
import 'dart:convert';

class UserInfo {
  UserInfo({
    this.phoneExt,
    this.phone,
    this.firstName,
    this.lastName,
    this.language,
    this.emailId,
    this.city,
    this.state,
    this.country,
    this.emailConf,
    this.phoneConf,
  });

  String? phoneExt;
  String? phone;
  String? firstName;
  String? lastName;
  String? language;
  String? emailId;
  String? city;
  String? state;
  String? country;
  bool? emailConf;
  bool? phoneConf;

  UserInfo.fromJson(Map<String, dynamic> json) {
    phoneExt = json[''];
    firstName = json['first_name'];
    lastName = json['lastName'];
    language = json['language'];
    emailId = json['emailId'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    emailConf = json['emailConf'];
    phoneConf = json['phoneConf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneExt'] = this.phoneExt;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['language'] = this.language;
    data['emailId'] = this.emailId;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['emailConf'] = this.emailConf;
    data['phoneConf'] = this.phoneConf;
    return data;
  }
}