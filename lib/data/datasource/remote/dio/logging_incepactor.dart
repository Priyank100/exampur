import 'package:dio/dio.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    AppConstants.printLog("--> ${options.method} ${options.path}");
    AppConstants.printLog("Headers: ${options.headers.toString()}");
    AppConstants.printLog("<-- END HTTP");

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    AppConstants.printLog(
        "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");

    String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        AppConstants.printLog(
            responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      AppConstants.printLog(response.data);
    }

    AppConstants.printLog("<-- END HTTP");

    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if(err.response == null)
      {
        AppConstants.printLog(err.message);
      }
    else {
      AppConstants.printLog(
          "ERROR[${err.response!.statusCode}] => PATH: ${err.requestOptions
              .path}");
    }
    return super.onError(err, handler);
  }
}