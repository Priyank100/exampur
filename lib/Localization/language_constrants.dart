import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'app_localization.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String HINDI = 'hi';

Future<Locale> setLocale(String languageCode) async {
  // SharedPreferences _prefs = await SharedPreferences.getInstance();
  // await _prefs.setString(LAGUAGE_CODE, languageCode);
  await SharedPref.saveSharedPref(SharedPref.LANG_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  // SharedPreferences _prefs = await SharedPreferences.getInstance();
  // String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  String langC = await SharedPref.getSharedPref(SharedPref.LANG_CODE);
  String languageCode = langC == null || langC == 'null' ? "en" : langC;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case HINDI:
      return Locale(HINDI, "IN");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key);
}