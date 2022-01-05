import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;

  AuthRepo({required this.dioClient});

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await dioClient.post(
        AppConstants.Login_URL,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> registerUser(CreateUserModel registerModel) async {
    try {
      Response response = await dioClient.post(
        AppConstants.Valid_Token_URL,
        data: registerModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(CreateUserModel updateprofileBody) async {
    try {
      Response response = await dioClient.put(
        AppConstants.Update_User_URL,
        data: updateprofileBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> checkVaildToken() async {
    String token = await SharedPref.getSharedPref(AppConstants.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      final url = '${AppConstants.Valid_Token_URL}';
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> changePassword(param) async {
    try {
      Response response = await dioClient.post(
        AppConstants.Change_Password_URL,
        data: param,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}