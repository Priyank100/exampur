// // // import 'dart:convert';
// // // /// alert_category_id : "61efe8001dbf84752e75035c"
// // // /// category : ["61d2cc701cea2fdab6e9cb06","61d2cc8c1cea2fdab6e9cb07"]
// // // /// limit : 10
// // // /// skip : 0
// // //
// // // JobAlertPostApi jobAlertPostApiFromJson(String str) => JobAlertPostApi.fromJson(json.decode(str));
// // // String jobAlertPostApiToJson(JobAlertPostApi data) => json.encode(data.toJson());
// // // class JobAlertPostApi {
// // //   JobAlertPostApi({
// // //       String? alertCategoryId,
// // //       List<String>? category,
// // //       int? limit,
// // //       int? skip,}){
// // //     _alertCategoryId = alertCategoryId;
// // //     _category = category;
// // //     _limit = limit;
// // //     _skip = skip;
// // // }
// // //
// // //   JobAlertPostApi.fromJson(dynamic json) {
// // //     _alertCategoryId = json['alert_category_id'];
// // //     _category = json['category'] != null ? json['category'].cast<String>() : [];
// // //     _limit = json['limit'];
// // //     _skip = json['skip'];
// // //   }
// // //   String? _alertCategoryId;
// // //   List<String>? _category;
// // //   int? _limit;
// // //   int? _skip;
// // //
// // //   String? get alertCategoryId => _alertCategoryId;
// // //   List<String>? get category => _category;
// // //   int? get limit => _limit;
// // //   int? get skip => _skip;
// // //
// // //
// // //
// // //   Map<String, dynamic> toJson() {
// // //     final map = <String, dynamic>{};
// // //     map['alert_category_id'] = _alertCategoryId;
// // //     map['category'] = _category;
// // //     map['limit'] = _limit;
// // //     map['skip'] = _skip;
// // //     return map;
// // //   }
// // //
// // // }
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// import 'dart:convert';
// import 'dart:core';
//
// import 'dart:core';
//
// JobAlertPostApi jobAlertPostApiFromJson(String str) => JobAlertPostApi.fromJson(json.decode(str));
// String jobAlertPostApiToJson(JobAlertPostApi data) => json.encode(data.toJson());
//
// class JobAlertPostApi {
//   JobAlertPostApi({
//     this.alertCategoryId,
//     this.category,
//     this.limit,
//     this.skip
//   });
//
//   String? alertCategoryId;
//   List<String>? category;
//   int? limit;
//   int? skip;
//
//   factory JobAlertPostApi.fromJson(Map<String, dynamic> json) => JobAlertPostApi(
//     alertCategoryId: json["alertCategoryId"],
//     category = json['category'] != null ? json['category'].cast<String>() : [],
//     limit: json["limit"],
//       skip:json["skip"]
//   );
//
//   Map<String, dynamic> toJson() => {
//     "alertCategoryId":alertCategoryId,
//     "category": category,
//     "limit": limit,
//     "skip":skip
//   };
// }
