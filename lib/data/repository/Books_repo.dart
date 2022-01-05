import 'package:dio/dio.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/data/datasource/remote/exception/api_error_handler.dart';
import 'package:exampur_mobile/data/model/loginmodel.dart';
import 'package:exampur_mobile/data/model/response/Base/api_response.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BooksRepo {
  final DioClient dioClient;


  BooksRepo({required this.dioClient});

  Future<ApiResponse> eBooksRepo(int page, String search) async {
    try {
      int currentPage = 1;
      final url = 'https://static.exampur.work/books/ebook/search?query=$search&per_page=10&page=$page';
      AppConstants.printLog(url);
      final response = await dioClient.get("https://static.exampur.work/books/ebook/10/0");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  }