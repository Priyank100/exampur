import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/cupertino.dart';

class AppConstants {
  static const String BASE_URL = 'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';
  static const String User_URL = 'user';

  static const String BASE_URL2 = 'https://auth.exampur.xyz/';


  static const String Login_URL = BASE_URL2 + 'auth/login';
  static const String Valid_Token_URL = BASE_URL2 + 'user';

  static const String homeBanner_URL = BASE_URL + 'banners';

  // sharePreference
  static const String TOKEN = 'Token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';

  static bool isPrint = true;

  static void printLog(message) {
    if(isPrint)
      print(message);
    else
      print('Exampur');
  }


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Hindi', countryCode: 'SA', languageCode: 'ar'),
  ];
}