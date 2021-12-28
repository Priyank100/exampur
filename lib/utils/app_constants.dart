import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static const String USER_DATA = 'user_data';

  static bool isPrint = true;
  static String SELECT_CATEGORY_LENGTH = 'category_length';


  static String Mobile_number = '9873111552';

  static void printLog(message) {
    if(isPrint)
      print(message);
    else
      print('Exampur');
  }
  static Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Hindi', countryCode: 'SA', languageCode: 'ar'),
  ];
}