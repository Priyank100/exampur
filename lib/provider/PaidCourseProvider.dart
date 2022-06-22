import 'dart:convert';
import 'package:exampur_mobile/Helper/api_checker.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_list_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/data/model/paid_course_tab.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/data/repository/paid_course_repo.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaidCoursesProvider extends ChangeNotifier {
  final PaidCoursesRepo paidcoursesRepo;
  PaidCoursesProvider({required this.paidcoursesRepo});

  PaidCourseModelNew _paidcourseModel = PaidCourseModelNew();
  PaidCourseModelNew get paidcourseModel => _paidcourseModel;

  PaidCourseTab _paidcoursetabModel = PaidCourseTab();
  PaidCourseTab get paidcoursetabModel => _paidcoursetabModel;


  Future<List<Data>?> getPaidCourseTabList(BuildContext context) async {
    ApiResponse apiResponse = await paidcoursesRepo.paid_courses_Tab();

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _paidcoursetabModel = PaidCourseTab.fromJson(
            json.decode(apiResponse.response.toString()));
        return _paidcoursetabModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  Future<List<PaidCourseData>?> getPaidCourseList(BuildContext context, String id, int pageNo) async {
    ApiResponse apiResponse = await paidcoursesRepo.paid_coursesRepo(id, pageNo);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _paidcourseModel = PaidCourseModelNew.fromJson(
            json.decode(apiResponse.response.toString()));
        return _paidcourseModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }


  Future<List<Data>?> getFreeCourseTabList(BuildContext context) async {
    ApiResponse apiResponse = await paidcoursesRepo.free_courses_Tab();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _paidcoursetabModel = PaidCourseTab.fromJson(
            json.decode(apiResponse.response.toString()));
        return _paidcoursetabModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }
  }

  Future<List<PaidCourseData>?> getFreeCourseList(BuildContext context, String id, int pageNo) async {
    ApiResponse apiResponse = await paidcoursesRepo.free_coursesRepo(id, pageNo);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var statusCode = apiResponse.response!.data['statusCode'].toString();
      if (statusCode == '200') {
        _paidcourseModel = PaidCourseModelNew.fromJson(
            json.decode(apiResponse.response.toString()));
        return _paidcourseModel.data;
      } else {
        String error = apiResponse.response!.data['data'].toString();
        AppConstants.showBottomMessage(context, error, AppColors.black);
      }
      notifyListeners();
    } else {
      AppConstants.showBottomMessage(
          context, getTranslated(context, StringConstant.serverError)!,
          AppColors.red);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ErrorScreen()
      //     )
      // );
      notifyListeners();
    }}
}