import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/api.dart';

class FreeVideosRepo {
  final DioClient dioClient;

  FreeVideosRepo({required this.dioClient});

  Future<ApiResponse> freeVideostab() async {
    try {
      final response = await dioClient.get(API.freeVideotabUrl);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> freeVideosList(String channelId) async {
    try {
      String urls = API.freeVideoListUrl.replaceAll('CHANNELID', channelId);
      final response = await dioClient.get(urls);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> freeVideosPlayList(String playlistId) async {
    try {
      String urls = API.freeVideoPlaylistUrl.replaceAll('PLAYLISTID', playlistId);
      final response = await dioClient.get(urls);
      print(">>>>>>>>>>>"+response.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}