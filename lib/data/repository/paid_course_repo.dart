import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class PaidCoursesRepo {
  final DioClient dioClient;


  PaidCoursesRepo ({required this.dioClient});

  Future<ApiResponse> paid_courses_Tab() async {
    try {
      const url = '${AppConstants.PaidCoursesTab_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> paid_coursesRepo(String id) async {
    try {
      String url = AppConstants.PaidCoursesDetail_URL.replaceAll('PAID_COURSE_ID', id);
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> free_courses_Tab() async {
    try {
      const url = '${AppConstants.FreeCoursesTab_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> free_coursesRepo(String id) async {
    try {
      String url = AppConstants.FreeCoursesDetail_URL.replaceAll('FREE_COURSE_ID', id);
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}