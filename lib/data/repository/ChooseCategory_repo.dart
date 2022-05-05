import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ChooseCategoryRepo {
  final DioClient dioClient;

  ChooseCategoryRepo({required this.dioClient});

  Future<ApiResponse> allCategory() async {
    try {

      final url =  '${API.All_category_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> selectCategory(String token) async {
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      final url =  '${API.Select_Choose_category_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Map<String, dynamic> header = {
            "appAuthToken": token,
          };
          final url =  '${API.Select_Choose_category_URL_2}';
          final response = await dioClient.get(url, options: Options(headers: header));
          AppConstants.printLog(url);
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

}