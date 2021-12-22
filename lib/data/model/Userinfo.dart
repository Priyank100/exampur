import 'dart:convert';


class UserInfo {
  UserInfo({
    this.phone_ext,
    this.phone,
    this.first_name,
    this.last_name,
    this.language,
    this.email_id,
    this.city,
    this.state,
    this.country,
    this.email_conf,
    this.phone_conf,
  });

  String? phone_ext;
  String? phone;
  String? first_name;
  String? last_name;
  String? language;
  String? email_id;
  String? city;
  String? state;
  String? country;
  bool? email_conf;
  bool? phone_conf;

  UserInfo.fromJson(Map<String, dynamic> json) {
    phone_ext = json['phone_ext'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    language = json['language'];
    email_id = json['email_id'];
    phone = json['phone'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    email_conf = json['email_conf'];
    phone_conf = json['phone_conf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_ext'] = this.phone_ext;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['language'] = this.language;
    data['email_id'] = this.email_id;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['email_conf'] = this.email_conf;
    data['phone_conf'] = this.phone_conf;
    return data;
  }
}