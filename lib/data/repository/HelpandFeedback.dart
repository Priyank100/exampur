import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class HelpandFeedbackRepo {
  final DioClient dioClient;

  HelpandFeedbackRepo({required this.dioClient});

  Future<ApiResponse> helpandfeedback(HelpandFeedbackModel helpandfeedbacklBody) async {
    try {
      Response response = await dioClient.post(
        API.HelpFeedback_URL,
        data: helpandfeedbacklBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }}