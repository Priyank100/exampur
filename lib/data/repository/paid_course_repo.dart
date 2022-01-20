import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class PaidCoursesRepo {
  final DioClient dioClient;


  PaidCoursesRepo ({required this.dioClient});

  Future<ApiResponse> paid_courses_Tab() async {
    try {
      const url = '${API.PaidCoursesTab_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> paid_coursesRepo(String id, int pageNo) async {
    try {
      String url = API.PaidCoursesList_URL.replaceAll('PAID_COURSE_ID', id) + pageNo.toString();
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> free_courses_Tab() async {
    try {
      const url = '${API.FreeCoursesTab_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> free_coursesRepo(String id, int pageNo) async {
    try {
      String url = API.FreeCoursesList_URL.replaceAll('FREE_COURSE_ID', id) + pageNo.toString();
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}