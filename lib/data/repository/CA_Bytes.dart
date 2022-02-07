import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class CaBytesRepo {
  final DioClient dioClient;

  CaBytesRepo ({required this.dioClient});

  Future<ApiResponse> caBytes(int pageNo) async {
    try {
      String url = API.ca_bytes_url+pageNo.toString();
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}