import 'dart:convert';
/// statusCode : 200
/// data : [{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"},{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"},{"_id":"61c98d223a7d50ce67803edb","title":"Course 1","logo_path":"course/DGUKTpZX-logo_exampur.png","banner_path":"course/12JNP4Uo-banner_course_2.jpeg"}]

MyCourseListModel myCourseListModelFromJson(String str) => MyCourseListModel.fromJson(json.decode(str));
String myCourseListModelToJson(MyCourseListModel data) => json.encode(data.toJson());
class MyCourseListModel {
  MyCourseListModel({
      int? statusCode,
      List<CourseData>? data,
  }){
    _statusCode = statusCode;
    _data = data;
  }

  MyCourseListModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CourseData.fromJson(v));
      });
    }
  }
  int? _statusCode;
  List<CourseData>? _data;


  int? get statusCode => _statusCode;
  List<CourseData>? get data => _data;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "61c98d223a7d50ce67803edb"
/// title : "Course 1"
/// logo_path : "course/DGUKTpZX-logo_exampur.png"
/// banner_path : "course/12JNP4Uo-banner_course_2.jpeg"
/// "status": "EMI",
//  "validity_till": "2022-06-25T08:07:08.133Z",
//  "final_amount": 1,

CourseData dataFromJson(String str) => CourseData.fromJson(json.decode(str));
String dataToJson(CourseData data) => json.encode(data.toJson());
class CourseData {
  CourseData({
      String? id,
      String? title,
      String? logoPath,
      String? bannerPath,
      List<Category>? category,
    String? status,
    String? validityTill,
    String? finalAmount,
    String? testSeriesLink,
    EmiPlans? emiPlans
  }){
    _id = id;
    _title = title;
    _logoPath = logoPath;
    _bannerPath = bannerPath;
    _category = category;
    _status = status;
    _validityTill = validityTill;
    _finalAmount = finalAmount;
    _testSeriesLink = testSeriesLink;
    _emiPlans = emiPlans;
}

  CourseData.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _logoPath = json['logo_path'];
    _bannerPath = json['banner_path'];
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category!.add(Category.fromJson(v));
      });
    }
    _status = json['status']??'';
    _validityTill = json['validity_till']??'';
    _finalAmount = json['final_amount']==null?'':json['final_amount'].toString();
    _testSeriesLink = json['test_series_link']==null?'':json['test_series_link'].toString();
    _emiPlans = json['emi_plans'] != null ? EmiPlans.fromJson(json['emi_plans']) : null;
  }
  String? _id;
  String? _title;
  String? _logoPath;
  String? _bannerPath;
  List<Category>? _category;
  String? _status;
  String? _validityTill;
  String? _finalAmount;
  String? _testSeriesLink;
  EmiPlans? _emiPlans;

  String? get id => _id;
  String? get title => _title;
  String? get logoPath => _logoPath;
  String? get bannerPath => _bannerPath;
  List<Category>? get category => _category;
  String? get status => _status;
  String? get validityTill => _validityTill;
  String? get finalAmount => _finalAmount;
  String? get testSeriesLink => _testSeriesLink;
  EmiPlans? get emiPlans => _emiPlans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['logo_path'] = _logoPath;
    map['banner_path'] = _bannerPath;
    if (_category != null) {
      map['category'] = _category!.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['validity_till'] = _validityTill;
    map['final_amount'] = _finalAmount;
    map['test_series_link'] = _testSeriesLink;
    if (_emiPlans != null) {
      map['emi_plans'] = _emiPlans?.toJson();
    }
    return map;
  }

}

/// _id : "624d21298e64bc5e0e75f32f"
/// name : "ALL EXAMS"

class Category {
  Category({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  Category.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;

  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}


// "title": "pay in 6 months easy emi",
// "emi_paid_every": 1,
// "cost_per_emi": 1,
// "_id": "62b6c22ce657080aeeea9009"
EmiPlans emiPlansFromJson(String str) => EmiPlans.fromJson(json.decode(str));
String emiPlansToJson(EmiPlans data) => json.encode(data.toJson());
class EmiPlans {
  EmiPlans({
    String? title,
    String? emiPaidEvery,
    String? costPerEmi,
    String? id,
  }){
    _title = title;
    _emiPaidEvery = emiPaidEvery;
    _costPerEmi = costPerEmi;
    _id = id;
  }

  EmiPlans.fromJson(dynamic json) {
    _title = json['title']==null?'':json['title'].toString();
    _emiPaidEvery = json['emi_paid_every']==null?'':json['emi_paid_every'].toString();
    _costPerEmi = json['cost_per_emi']==null?'':json['cost_per_emi'].toString();
    _id = json['_id']==null?'':json['_id'].toString();
  }
  String? _title;
  String? _emiPaidEvery;
  String? _costPerEmi;
  String? _id;

  String? get title => _title;
  String? get emiPaidEvery => _emiPaidEvery;
  String? get costPerEmi => _costPerEmi;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['emi_paid_every'] = _emiPaidEvery;
    map['cost_per_emi'] = _costPerEmi;
    map['_id'] = _id;
    return map;
  }

}