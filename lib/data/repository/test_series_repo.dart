import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';



class TestSeriesRepo {
  final DioClient dioClient;

  TestSeriesRepo({required this.dioClient});

  Future<ApiResponse> liveTestSeriesData() async {
    try {
      // Map<String, dynamic> header = {
      //   "Authorization": AppConstants.testSeriesToken,
      // };
      String url = API.liveTestSeries_URL;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> myTestSeriesData() async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myTestSeries_URL;
       final response = await dioClient.get(url, options: Options(headers: header));
     // final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> allTestSeriesData() async {
    try {
      String url = API.allTestSeries_URL;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}