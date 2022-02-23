import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class MyCourseRepo {
  final DioClient dioClient;

  MyCourseRepo({required this.dioClient});

  // Future<ApiResponse> myCourse() async {
  //   try {
  //     String url = API.mypurchase;
  //     final response = await dioClient.get(url);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }


}