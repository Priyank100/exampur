// To parse this JSON data, do
//
//     final userInformationModel = userInformationModelFromJson(jsonString);

class UserInformationModel {
  UserInformationModel({
    this.statusCode,
    this.data,
    this.config
  });

  int? statusCode;
  Data? data;
  Config? config;

  factory UserInformationModel.fromJson(Map<String, dynamic> json) => UserInformationModel(
    statusCode: json["statusCode"],
    data: Data.fromJson(json["data"]),
    config: json["config"] == null ? Config(isMaintenance: false, isMandatoryUpdate: false) : Config.fromJson(json["config"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": data!.toJson(),
    "config": config!.toJson(),
  };
}

class Data {
  Data({
    this.phoneExt,
    this.phone,
    this.firstName,
    this.lastName,
    this.language,
    // this.emailId,
    // this.city,
    // this.state,
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
  // String? emailId;
  // String? city;
  // String? state;
  String? country;
  bool? phoneConf;
  String? authToken;
  int? countCategories;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneExt: json["phone_ext"],
    phone: json["phone"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    language: json["language"],
    // emailId: json["email_id"],
    // city: json["city"],
    // state: json["state"],
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
    // "email_id": emailId,
    // "city": city,
    // "state": state,
    "country": country,
    "phone_conf": phoneConf,
    "authToken": authToken,
    "count_categories": countCategories,
  };
}

class Config {
  Config({
    this.isMaintenance,
    this.isMandatoryUpdate,
    this.courseDemoPercent
  });

  bool? isMaintenance;
  bool? isMandatoryUpdate;
  String? courseDemoPercent;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
    isMaintenance: json["is_maintanance"] ?? false,
    isMandatoryUpdate: json["is_mandatory_update"] ?? false,
    courseDemoPercent: json["course_demo_percent"] == null ? '0' : json["course_demo_percent"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "is_maintanance": isMaintenance,
    "is_mandatory_update": isMandatoryUpdate,
    "course_demo_percent": courseDemoPercent,
  };
}