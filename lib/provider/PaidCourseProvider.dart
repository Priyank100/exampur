import 'dart:convert';

import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/data/model/CoursesModel.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/books_model.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/model/e_books_model.dart';
import 'package:exampur_mobile/data/repository/Books_EBooks_repo.dart';
import 'package:exampur_mobile/data/repository/paid_course_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';

class PaidCoursesProvider extends ChangeNotifier {
  final PaidCoursesRepo paidcoursesRepo;

  PaidCoursesProvider({required this.paidcoursesRepo});

  PaidCourseModel _paidcourseModel = PaidCourseModel();
  PaidCourseModel get paidcourseModel => _paidcourseModel;

  PaidCourseTab _paidcoursetabModel = PaidCourseTab();
  PaidCourseTab get paidcoursetabModel => _paidcoursetabModel;


  Future<List<Courses>?> getPaidCourseList(BuildContext context) async {
    ApiResponse apiResponse = await paidcoursesRepo.paid_coursesRepo();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _paidcourseModel = PaidCourseModel.fromJson(json.decode(apiResponse.response.toString()));
      return _paidcourseModel.courses;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  Future<List<Data>?> getPaidCourseTabList(BuildContext context) async {
    ApiResponse apiResponse = await paidcoursesRepo.paid_courses_Tab();
    if (apiResponse.response == null) {
      ApiChecker.checkApi(context, apiResponse);
    } else if (apiResponse.response!.statusCode == 200) {
      AppConstants.printLog(apiResponse.response);
      _paidcoursetabModel = PaidCourseTab.fromJson(json.decode(apiResponse.response.toString()));
      return _paidcoursetabModel.data;

    } else {
      AppConstants.printLog("init address fail");
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

}