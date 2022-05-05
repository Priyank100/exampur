
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';

import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class DailyQuizRepo {
  final DioClient dioClient;

  DailyQuizRepo({required this.dioClient});

  Future<ApiResponse> dailyQuiz(int pageNo) async {
    try {
      String url = API.dailyQuiz_URL+pageNo.toString();
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}