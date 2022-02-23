import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class MyCourseRepo {
  final DioClient dioClient;

  MyCourseRepo({required this.dioClient});

  Future<ApiResponse> myCourseData(String token) async {
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_URL;
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}