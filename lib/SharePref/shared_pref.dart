import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  static Future saveSharedPref(String key, String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    // String encodeValue = base64.encode(utf8.encode(value));
    // prefs.setString(key, encodeValue);
  }

  static Future<String> getSharedPref(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString(key) != null) {
      return prefs.getString(key).toString();
    } else {
      return 'null';
    }
  }

  static Future clearSharedPref(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

}