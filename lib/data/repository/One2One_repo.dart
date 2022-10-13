import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';



import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class One2OneRepo {
  final DioClient dioClient;


  One2OneRepo({required this.dioClient});

  Future<ApiResponse> one2oneRepo(int pageNo) async {
    try {
      int currentPage = 1;
      String url = API.One2One_URL+pageNo.toString();
      // AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}