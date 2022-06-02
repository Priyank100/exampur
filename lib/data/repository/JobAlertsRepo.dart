import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class JobAlertsRepo {
  final DioClient dioClient;

  JobAlertsRepo ({required this.dioClient});

  Future<ApiResponse> jobAlertsTab() async {
    try {
      const url = '${API.job_alerts_tab_URL}';
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> jobAlertsList(String alertCatId, String encodeCat, int pageNo) async {
    try {
      final response = await dioClient.get(
        API.job_alerts_list_URL.replaceAll('ALERT_CATEGORY_ID', alertCatId).replaceAll('ENCODE_CATEGORY', encodeCat) + pageNo.toString()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> jobAlertsDetails(String id) async {
    try {
      String url = API.job_alerts_details_URL.replaceAll('ALERT_ID', id);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Job Notification
  Future<ApiResponse> jobNotificationsCourseAndTag(String url) async {
    try {
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> jobNotificationsData(String tagSlug, String courseId) async {
    try {
      String url = API.jobNotificationListingUrl.replaceAll('TAG_SLUG', tagSlug).replaceAll('COURSE_ID', courseId);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> jobNotificationsDetail(String notificationId) async {
    try {
      String url = API.jobNotificationDetailUrl + notificationId;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}