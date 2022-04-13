import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class MyPurchaseRepo {
  final DioClient dioClient;

  MyPurchaseRepo({required this.dioClient});

  Future<ApiResponse> mypurchase(String token) async {

    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.mypurchase;
      final response = await dioClient.get(url,options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Map<String, dynamic> header = {
            "appAuthToken": token,
          };
          String url = API.mypurchase_2;
          final response = await dioClient.get(url,options: Options(headers: header));
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }
    }
  }

  Future<ApiResponse> myinvoice(String token,String id,String type,) async {
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myinvoice+id+'/'+type;
      final response = await dioClient.get(url,options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      ApiResponse response = ApiResponse.withError(ApiErrorHandler.getMessage(e));
      if(response.error.toString().substring(response.error.toString().length-3) == '429') {
        try {
          Map<String, dynamic> header = {
            "appAuthToken": token,
          };
          String url = API.myinvoice_2;
          final response = await dioClient.get(url,options: Options(headers: header));
          return ApiResponse.withSuccess(response);
        } catch (e) {
          return ApiResponse.withError(ApiErrorHandler.getMessage(e));
        }

      } else {
        return ApiResponse.withError(ApiErrorHandler.getMessage(e));
      }}
  }
  }