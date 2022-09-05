import 'dart:async';
import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class Service {

  static Future<http.Response> post(String url, {var body, encoding, myHeader}) async {
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    var postBody = json.encode(body);
    AppConstants.printLog(url + " Param- " + postBody);

    Map<String, String> header = {
      "appAuthToken": token,
      "Content-Type": "application/json",
      "app_version":AppConstants.versionCode
    };

    try {
      return await http
          .post(Uri.parse(url),
          body: utf8.encode(postBody),
          headers: myHeader ?? header,
          encoding: encoding)
          .then((response) {
        AppConstants.printLog("Header-  ${myHeader??header}");
        AppConstants.printLog("Response- " + response.body);
        return response;
      });
    } catch (error) {
      throw Exception('Failed to load API');
    }
  }

  static Future<http.Response> get(String url) async {
    AppConstants.printLog('URL> $url');
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    AppConstants.printLog(token);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'appAuthToken': token,
      "app_version":AppConstants.versionCode
    });
    AppConstants.printLog('Response> ${response.body.toString()}');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load API');
    }
  }
}

