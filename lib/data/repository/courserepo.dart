import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CoursesRepo {
  final DioClient dioClient;


  CoursesRepo ({required this.dioClient});

  Future<ApiResponse> coursesRepo() async {
    try {
      int currentPage = 1;
      const url = '${API.Courses_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}