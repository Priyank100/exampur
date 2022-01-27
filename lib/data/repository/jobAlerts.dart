import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/job_alert_post_api.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class JobAlertsRepo {
  final DioClient dioClient;


  JobAlertsRepo ({required this.dioClient});

  Future<ApiResponse> job_alerts_Tab() async {
    try {
      const url = '${API.job_alerts_tab_URL}';
      AppConstants.printLog(url);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }


  }

  // Future<ApiResponse> jobalertpost(JobAlertPostApi jobAlertPostApi) async {
  //   try {
  //     Response response = await dioClient.post(
  //       API.HelpFeedback_URL,
  //       data: jobAlertPostApi.toJson(),
  //     );
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
}