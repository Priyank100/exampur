import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class FreeVideosRepo {
  final DioClient dioClient;

  FreeVideosRepo({required this.dioClient});

  Future<ApiResponse> freeVideos(String url) async {
    try {
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> freeVideosList(String url,String subjectId) async {
    try {
      String urls = url.replaceAll('Subject_Id', subjectId);
      final response = await dioClient.get(urls);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}