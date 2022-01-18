import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/order_details.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class CheckOrderRepo {
  final DioClient dioClient;

  CheckOrderRepo({required this.dioClient});

  Future<ApiResponse> checkorderrepo(OrderDetails orderdetails) async {
    try {
      Response response = await dioClient.post(
        AppConstants.order_course,
        data: orderdetails.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }}