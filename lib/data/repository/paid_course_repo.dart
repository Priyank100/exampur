import 'dart:convert';

import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';



class PaidCoursesRepo {
  final DioClient dioClient;


  PaidCoursesRepo ({required this.dioClient});

  Future<ApiResponse> paid_courses_Tab() async {
    try {
      var url = '${API.PaidCoursesTab_URL}';
      // AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> paid_coursesRepo(String id, int pageNo) async {
    try {
      var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
      var userMobile = jsonValue[0]['data']['phone'].toString();
      String url = API.PaidCoursesList_URL.replaceAll('PAID_COURSE_ID', id) + pageNo.toString() + '?phone=' + userMobile;
      // AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> free_courses_Tab() async {
    try {
      var url = '${API.FreeCoursesTab_URL}';
      // AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> free_coursesRepo(String id, int pageNo) async {
    try {
      String url = API.FreeCoursesList_URL.replaceAll('FREE_COURSE_ID', id) + pageNo.toString();
      // AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}