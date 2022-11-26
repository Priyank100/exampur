import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class NewMyCourseRepo {
  final DioClient dioClient;
  NewMyCourseRepo ({required this.dioClient});

  Future<ApiResponse> myCourseTimelineRepo(String courseId, String activeBtn) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = activeBtn=='L' ? API.newMyCourseTimelineLive_URL + courseId : API.newMyCourseTimelineUpcoming_URL + courseId;
      final response = await dioClient.get(url,options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> myCourseTimelineStreamRepo(String courseId,String token) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.newMyCourseTimelineShareStream_URL+'/'+courseId;
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> subjectListRepo(String courseId) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.newMyCourseSubjects_URL + '${courseId}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> chapterListRepo(String subjectId, String courseId) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.newMyCourseChapters_URL + '${subjectId}/${courseId}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> topicListRepo(String subjectId, String courseId,String chapterName) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.newMyCourseTopics_URL + '${subjectId}/${courseId}/${chapterName.replaceAll("/","")}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}