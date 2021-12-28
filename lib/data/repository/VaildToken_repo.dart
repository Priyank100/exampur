import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class ValidTokenRepo {
  final DioClient dioClient;



  ValidTokenRepo({required this.dioClient});

  Future<ApiResponse> checkVaildToken() async {
    String token = await SharedPref.getSharedPref(AppConstants.TOKEN);
    try {
      Map<String, dynamic> header = {
        "appAuthToken": token,
      };
      final url = '${AppConstants.Valid_Token_URL}';
      final response = await dioClient.get(url, );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}