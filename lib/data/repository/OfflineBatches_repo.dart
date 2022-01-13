import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OfflineBatchesRepo {
  final DioClient dioClient;


  OfflineBatchesRepo ({required this.dioClient});

  Future<ApiResponse> offlineBatchCenterRepo() async {
    try {
      int currentPage = 1;
      const url = AppConstants.offline_batches;
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> offlineBatchCenterCoursesRepo(String id) async {
    try {
      String url = AppConstants.offline_batches_center.replaceAll('CENTER_ID', id);
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}