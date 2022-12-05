import 'dart:async';
import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Service {

  // added appVersion in query param
  static Future<http.Response> post(String uri, {var body, encoding, myHeader}) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    var postBody = json.encode(body);

    var sym = uri.contains(API.BASE_URL2) ? uri.contains('?') ? "&" : "?" : "";
    String url = uri.contains(API.BASE_URL2) ? '${uri}${sym}appVersion=${AppConstants.versionCode}' : uri;
    AppConstants.printLog(url + " Param- " + postBody);
    // Fluttertoast.showToast(msg: postBody.toString());
    Map<String, String> header = {
      "appAuthToken": token,
      "Content-Type": "application/json",
      "app-version":AppConstants.versionCode
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

  // added appVersion in query param
  static Future<http.Response> get(String uri) async {
    var sym = uri.contains(API.BASE_URL2) ? uri.contains('?') ? "&" : "?" : "";
    String url = uri.contains(API.BASE_URL2) ? '${uri}${sym}appVersion=${AppConstants.versionCode}' : uri;
    AppConstants.printLog('URL> $url');
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    // Fluttertoast.showToast(msg: url);
    AppConstants.printLog(token);
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'appAuthToken': token,
      "app-version":AppConstants.versionCode
    });
    AppConstants.printLog('Response> ${response.body.toString()}');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load API');
    }
  }
}

