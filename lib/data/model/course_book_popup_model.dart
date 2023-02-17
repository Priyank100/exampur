import 'dart:convert';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'e_book_model.dart';

class CourseBookPopupModel {
  String dataType;
  String uniqueId;
  List<PaidCourseData>? course;
  List<BookEbook>? book;
  CourseBookPopupModel({required this.dataType, required this.uniqueId, this.course, this.book});

  factory CourseBookPopupModel.fromJson(Map<String, dynamic> jsonData) {
    return CourseBookPopupModel(
      dataType: jsonData['data_type'],
      uniqueId: jsonData['unique_id'],
      course: jsonData["course"] == null ? null : List<PaidCourseData>.from(jsonData["course"].map((x) => PaidCourseData.fromJson(x))),
      book: jsonData["book"] == null ? null : List<BookEbook>.from(jsonData["book"].map((x) => BookEbook.fromJson(x))),
    );
  }

  static Map<String, dynamic> toMap(CourseBookPopupModel model) => {
    'data_type': model.dataType,
    'unique_id': model.uniqueId,
    'course': model.course,
    'book': model.book
  };

  static String encode(List<CourseBookPopupModel> list) => json.encode(
    list
        .map<Map<String, dynamic>>((model) => CourseBookPopupModel.toMap(model))
        .toList(),
  );

  static List<CourseBookPopupModel> decode(String models) =>
      (json.decode(models) as List<dynamic>)
          .map<CourseBookPopupModel>((item) => CourseBookPopupModel.fromJson(item))
          .toList();
}