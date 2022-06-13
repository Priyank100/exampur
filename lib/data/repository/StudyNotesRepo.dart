import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class StudyNotesRepo {
  final DioClient dioClient;

  StudyNotesRepo({required this.dioClient});

  Future<ApiResponse> studynotes(String url) async {
    try {
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> studyNotesSubject(String url,String courseId) async {
    try {
      String urls = url.replaceAll('COURSE_ID', courseId);
      final response = await dioClient.get(urls);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}