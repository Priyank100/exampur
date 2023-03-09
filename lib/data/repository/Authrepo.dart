import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/Userinfo.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/api.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;

  AuthRepo({required this.dioClient});

  Future<ApiResponse> login(LoginModel loginBody) async {

    try {
      Response response = await dioClient.post(
        API.Login_URL,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
        Response response = await dioClient.post(
          API.Login_URL_2,
          data: loginBody.toJson(),
        );
        return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> registerUser(CreateUserModel registerModel) async {
    try {
      Response response = await dioClient.post(
        API.Valid_Token_URL,
        data: registerModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Response response = await dioClient.post(
            API.Valid_Token_URL_2,
            data: registerModel.toJson(),
          );
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> updateProfile(CreateUserModel updateProfileBody) async {
    try {
      Response response = await dioClient.put(
        API.Update_User_URL,
        data: updateProfileBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Response response = await dioClient.post(
            API.Update_User_URL_2,
            data: updateProfileBody.toJson(),
          );
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> checkValidToken(String token) async {
    // String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      final url = '${API.Valid_Token_URL}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Map<String, dynamic> header = {
            "appAuthToken": token,
          };
          final url = '${API.Valid_Token_URL_2}';
          final response = await dioClient.get(url, options: Options(headers: header));
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> changePassword(param) async {
    try {
      Response response = await dioClient.post(
        API.Change_Password_URL,
        data: param,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Response response = await dioClient.post(
            API.Change_Password_URL_2,
            data: param,
          );
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> config() async {
    try {
      final url = '${API.config_URL}';
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
