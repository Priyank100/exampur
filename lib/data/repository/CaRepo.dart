import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class CaRepo {
  final DioClient dioClient;

  CaRepo({required this.dioClient});

  Future<ApiResponse> caSmVideosContents(String contentCatId, String type, String encodeCat) async {
    try {
      String url = API.ca_sm_url.replaceAll('CONTENT_CATEGORY_ID', contentCatId).
                                replaceAll('TYPE', type).
                                replaceAll('ENCODE_CATEGORY', encodeCat);
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}