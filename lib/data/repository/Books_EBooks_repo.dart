import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class BooksEBooksRepo {
  final DioClient dioClient;

  BooksEBooksRepo({required this.dioClient});

  Future<ApiResponse> books(int pageNo,) async {
    try {
      String url = API.Books_URL+ pageNo.toString() +'?category='+ AppConstants.encodeCategory();
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> eBooks(int pageNo) async {
    try {
      final url = API.E_Books_URL+pageNo.toString();
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}