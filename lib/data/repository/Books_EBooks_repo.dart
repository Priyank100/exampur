import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class BooksEBooksRepo {
  final DioClient dioClient;

  BooksEBooksRepo({required this.dioClient});

  Future<ApiResponse> books() async {
    try {
      String url = API.Books_URL;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> eBooks() async {
    try {
      final url = API.E_Books_URL;
      final response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}