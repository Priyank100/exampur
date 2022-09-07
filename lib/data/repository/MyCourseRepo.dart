import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
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

  Future<ApiResponse> subjectData(String courseId,) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_subject_URL + '${courseId}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> materialData(String subjectId, String courseId,String chapterName) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_material_URL + '${subjectId}/${courseId}/${chapterName.replaceAll("/","")}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> chapterData(String subjectId, String courseId,) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_chapter_URL + '${subjectId}/${courseId}';
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> myCourseTimelineData(String courseId,String activeBtn) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = activeBtn=='L' ?
      API.myCourse_timeline_live_URL+'/'+courseId : API.myCourse_timeline_upcoming_URL+'/'+courseId;

      final response = await dioClient.get(url,options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> myCourseTimelineshareStreamToMobile(String courseId,String token) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_timelineshareStream_URL+'/'+courseId;
      AppConstants.printLog(url);
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> myCourseNotificationData(String courseId) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      String url = API.myCourse_notification_URL+'/'+courseId;
      final response = await dioClient.get(url, options: Options(headers: header));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}