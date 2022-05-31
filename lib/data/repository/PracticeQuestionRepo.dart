import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';


class PracticeQuestionRepo {
  final DioClient dioClient;

  PracticeQuestionRepo({required this.dioClient});

  Future<ApiResponse> parcticequestion() async {
    try {
      String url = API.practiceQuestionCategoriesUrl;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> practiceQuestionList(String url) async {
    try {
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}