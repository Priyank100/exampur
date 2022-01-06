import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const String BASE_URL =  'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';
  // static const String BASE_URL2 = 'https://auth.exampur.xyz/';
  static const String BASE_URL2 = 'https://auth.exampur.work/';
  // static const String BASE_URL3 = 'https://static.exampur.xyz/';
  static const String BASE_URL3 = 'https://static.exampur.work/';

  static const String User_URL            = 'user';
  static const String Login_URL           = BASE_URL2 + 'auth/login';
  static const String Valid_Token_URL     = BASE_URL2 + 'user';
  static const String Update_User_URL     = BASE_URL2 + 'user';
  static const String Change_Password_URL = BASE_URL2 + 'auth/changePassword';

  static const String homeBanner_URL      = BASE_URL3 + 'banners';

  static const String Choose_category_URL = BASE_URL3 + 'category/all';
  static const String Update_Choose_category_URL = BASE_URL3 + 'user/updateCategory';

  //Book/E-Book
  static const String Books_URL           = BASE_URL3 + 'books/printed/10/0';
  static const String E_Books_URL         = BASE_URL3 + 'books/ebook/10/0';

//PaidCourse/PaidcourseTab
  static const String PaidCoursesTab_URL      = BASE_URL3 + 'category/course_paid';
  static const String PaidCoursesDetail_URL   = BASE_URL3 + 'courses/paid/61cad845da1d8532b6f33fd1/10/0';

  static const String Courses_URL         = BASE_URL3 + 'courses/free/5/0';


  static const String One2One_URL         = BASE_URL3 + 'courses/onetoone/10/0';



  static const String Terms_and_Conditions ='https://exampur.com/';



  // sharePreference
  static const String TOKEN = 'Token';
  static const String USER = 'user';
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';

  static const String USER_DATA = 'user_data';

  static bool isPrint = true;
  static bool isAuth = false;
  static String SELECT_CATEGORY_LENGTH = 'category_length';


  static String Mobile_number = '9873111552';
  static String playStoreAppUrl = 'https://play.google.com/store/apps/details?id=com.edudrive.exampur';
  static String androidId = 'com.edudrive.exampur';
  static String iosId = '';

  static String shareAppContent = 'Hey check out EXAMPUR App at: ' + playStoreAppUrl;

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

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Hindi', countryCode: 'SA', languageCode: 'ar'),
  ];
}