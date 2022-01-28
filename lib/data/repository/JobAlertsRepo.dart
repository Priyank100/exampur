import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/job_alert_list_body_model.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

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

  Future<ApiResponse> jobAlertsList(JobAlertListBodyModel bodyModel) async {
    try {
      final response = await dioClient.post(
        API.job_alerts_list_URL,
        data: bodyModel.toJson(),
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

}