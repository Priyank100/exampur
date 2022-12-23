import 'dart:io';
import 'package:dio/dio.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/api.dart';
import 'logging_incepactor.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  Dio dio=Dio();
  String token = '';

  DioClient(this.baseUrl, Dio dioC, {required this.loggingInterceptor, required this.sharedPreferences}) {
    token = sharedPreferences.getString(SharedPref.TOKEN)?? "no_token";
    AppConstants.printLog("NNNN $token");

    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'appAuthToken': '$token',
        "app-version":AppConstants.versionCode
      };
    dio.interceptors.add(loggingInterceptor);
  }

  // added appVersion in query param
  Future<Response> get(String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var sym = uri.contains(API.BASE_URL2) || uri.contains('courses/paid') ? uri.contains('?') ? "&" : "?" : "";
      String url = uri.contains(API.BASE_URL2) || uri.contains('courses/paid') ? '${uri}${sym}appVersion=${AppConstants.versionCode}' : uri;
      AppConstants.printLog("URL> ${url.toString()}");
     // Fluttertoast.showToast(msg: url);
      var response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      // Fluttertoast.showToast(msg: '${url}\n${response.data.toString()}');
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  // added appVersion in query param
  Future<Response> post(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var sym = uri.contains(API.BASE_URL2) ? uri.contains('?') ? "&" : "?" : "";
      String url = uri.contains(API.BASE_URL2) ? '${uri}${sym}appVersion=${AppConstants.versionCode}' : uri;
      AppConstants.printLog("URL> ${url.toString()}");
      AppConstants.printLog("Param> ${data.toString()}");
      // Fluttertoast.showToast(msg: data.toString());
      var response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // Fluttertoast.showToast(msg: '${url}\n${response.data.toString()}');
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  // added appVersion in query param
  Future<Response> put(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var sym = uri.contains(API.BASE_URL2) ? uri.contains('?') ? "&" : "?" : "";
      String url = uri.contains(API.BASE_URL2) ? '${uri}${sym}appVersion=${AppConstants.versionCode}' : uri;
      AppConstants.printLog("URL> ${url.toString()}");
      AppConstants.printLog("Param> ${data.toString()}");
      var response = await dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      // Fluttertoast.showToast(msg: '${url}\n${response.data.toString()}');
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      // Fluttertoast.showToast(msg: '${uri}\n${response.data.toString()}');
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
