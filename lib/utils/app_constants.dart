import 'package:exampur_mobile/data/model/response/languagemodel.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const String BASE_URL =  'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';
  // static const String BASE_URL2 = 'https://auth.exampur.xyz/';
  static const String BASE_URL2 = 'https://auth.exampur.work/';
  // static const String BASE_URL3 = 'https://static.exampur.xyz/';
  static const String BASE_URL3 = 'https://static.exampur.work/';

  static const String BANNER_BASE_URL = 'https://static.exampur.work/get_cdn';

  static const String Login_URL           = BASE_URL2 + 'auth/login';
  static const String Valid_Token_URL     = BASE_URL2 + 'user';
  static const String Update_User_URL     = BASE_URL2 + 'user';
  static const String Change_Password_URL = BASE_URL2 + 'auth/changePassword';
  static const String Send_OTP_URL        = BASE_URL2 + 'otp';
  static const String Reset_Password_URL  = BASE_URL2 + 'auth/resetPassword';
  static const String Verify_OTP_URL      = BASE_URL2 + 'auth/verification';

  static const String homeBanner_URL      = BASE_URL3 + 'banners';

  static const String Choose_category_URL = BASE_URL3 + 'category/all';
  static const String Update_Choose_category_URL = BASE_URL2 + 'user/updateCategory';
  static const String Select_Choose_category_URL = BASE_URL2 + 'user/getCategory';

  //Book/E-Book
  static const String Books_URL           = BASE_URL3 + 'books/printed/10/0';
  static const String E_Books_URL         = BASE_URL3 + 'books/ebook/10/0';

  //PaidCourse
  static const String PaidCoursesTab_URL      = BASE_URL3 + 'category/course_paid';
  static const String PaidCoursesList_URL   = BASE_URL3 + 'courses/paid/' + 'PAID_COURSE_ID' + '/10/0';

  //FreeCourse
  static const String FreeCoursesTab_URL      = BASE_URL3 + 'category/course_free';
  static const String FreeCoursesList_URL   = BASE_URL3 + 'courses/free/' + 'FREE_COURSE_ID' + '/10/0';

  static const String Courses_URL         = BASE_URL3 + 'courses/free/5/0';

//one2one
  static const String One2One_URL         = BASE_URL3 + 'courses/onetoone/10/0';
  static const String Terms_and_Conditions ='https://exampur.com/';


  //offlinebatches
  static const String offline_batches         = BASE_URL3 +'offline_centers/findall/10/0';
  static const String offline_batches_center  = BASE_URL3 +'offline_centers/findone/' + 'CENTER_ID' + '/10/0';
  static const String offline_batches_course  = BASE_URL3 +'offline_centers/course/'+ 'CENTER_ID'; //set course id at last

//appTutorial
  static const String app_tutorial  = BASE_URL3 +'tutorials/app';

  // sharePreference
  static const String TOKEN = 'Token';
  static const String BANNER_BASE_SP = 'Banner_Base';
  static const String USER_DATA = 'user_data';
  static String SELECT_CATEGORY_LENGTH = 'category_length';


  static bool isPrint = true;
  static bool isAuth = false;
  static String BANNER_BASE = '';



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

  static void showBottomMessage(context, message, bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bgColor,
    ));
  }

  static void showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 10),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  // static List<LanguageModel> languages = [
  //   LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
  //   LanguageModel(imageUrl: '', languageName: 'Hindi', countryCode: 'SA', languageCode: 'ar'),
  // ];



  ///colors///////////////////////////////////////

  static const Color Dark = Color(0xFFd19d0f);
  static const Color darkblue = Color(0xFF14739c);
  static const Color darkorange = Color(0xFFf76d02);
  static const Color blue = Color(0xFF0582f7);
  static const Color greycolor = Color(0xFF7790a6);
  static const Color greencolor = Color(0xFF069413);
  static const Color pinkcolor = Color(0xFFf23587);
  static const Color bookcolor = Color(0xFF0b8f8d);
  static const Color coursescolor = Color(0xFFa807a8);
  static const Color seriescolor = Color(0xFFd44242);
}