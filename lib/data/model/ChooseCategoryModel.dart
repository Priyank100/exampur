// // To parse this JSON data, do
// //
// //     final categoriesModel = categoriesModelFromJson(jsonString);
//
// import 'dart:convert';
//
// CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));
//
// String categoriesModelToJson(CategoriesModel data) => json.encode(data.toJson());
//
// class CategoriesModel {
//   CategoriesModel({
//     this.statusCode,
//     this.categories,
//     this.totalCount,
//   });
//
//   int? statusCode;
//   List<Category>? categories;
//   int? totalCount;
//
//   factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
//     statusCode: json["statusCode"],
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     totalCount: json["totalCount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "statusCode": statusCode,
//     "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
//     "totalCount": totalCount,
//   };
// }
//
// class Category {
//   Category({
//     this.id,
//     this.logoPath,
//     this.description,
//     this.name,
//     this.sorting,
//   });
//
//   String? id;
//   String? logoPath;
//   String? description;
//   String? name;
//   int? sorting;
//   bool isSelected=false;
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["_id"],
//     logoPath: json["logo_path"],
//     description: json["description"],
//     name: json["name"],
//     sorting: json["sorting"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "logo_path": logoPath,
//     "description": description,
//     "name": name,
//     "sorting": sorting,
//   };
// }
import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61d2cca81cea2fdab6e9cb08","logo_path":"https://downloadexampur.appx.co.in/appcategories/0.76474404258184861617893303609.png","description":"UPSI, DP,CONSTABLE,SSC GD, UPSSSC,VDO","name":"POLICE EXAMS","sorting":1},{"_id":"61d2cc701cea2fdab6e9cb06","logo_path":"https://downloadexampur.appx.co.in/appcategories/0.386633061797949431618553350980.jpg","description":"ALL EXAMS","name":"ALL EXAMS","sorting":5},{"_id":"61d2cc8c1cea2fdab6e9cb07","logo_path":"https://downloadexampur.appx.co.in/appcategories/0.4226459320090271618471913636.png","description":"REET, RAS,RPSC,JA,ASO,","name":"RAJASTHAN SPECIAL","sorting":11},{"_id":"61cad845da1d8532b6f33fd1","logo_path":"https://downloadexampur.appx.co.in/appcategories/0.61908432935990331626543302041.jpg","description":"Haryana exams, HSSC,HPSC","name":"HARYANA SPECIAL","sorting":16}]
/// totalCount : 4

ChooseCategory chooseCategoryFromJson(String str) => ChooseCategory.fromJson(json.decode(str));
String chooseCategoryToJson(ChooseCategory data) => json.encode(data.toJson());
class ChooseCategory {
  ChooseCategory({
    int? statusCode,
    List<Data>? data,
    int? totalCount,}){
    _statusCode = statusCode;
    _data = data;
    _totalCount = totalCount;
  }

  ChooseCategory.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }
  int? _statusCode;
  List<Data>? _data;
  int? _totalCount;

  int? get statusCode => _statusCode;
  List<Data>? get data => _data;
  int? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }

}

/// _id : "61d2cca81cea2fdab6e9cb08"
/// logo_path : "https://downloadexampur.appx.co.in/appcategories/0.76474404258184861617893303609.png"
/// description : "UPSI, DP,CONSTABLE,SSC GD, UPSSSC,VDO"
/// name : "POLICE EXAMS"
/// sorting : 1

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? id,
    String? logoPath,
    String? description,
    String? name,
    int? sorting,}){
    _id = id;
    _logoPath = logoPath;
    _description = description;
    _name = name;
    _sorting = sorting;

  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _logoPath = json['logo_path'];
    _description = json['description'];
    _name = json['name'];
    _sorting = json['sorting'];
  }
  String? _id;
  String? _logoPath;
  String? _description;
  String? _name;
  int? _sorting;
  bool isSelected=false;

  String? get id => _id;
  String? get logoPath => _logoPath;
  String? get description => _description;
  String? get name => _name;
  int? get sorting => _sorting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['logo_path'] = _logoPath;
    map['description'] = _description;
    map['name'] = _name;
    map['sorting'] = _sorting;
    return map;
  }

}