import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'images.dart';

class API {

  static const String BASE_URL = 'https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io/';

  // static const String BASE_URL2 = 'https://auth.exampur.xyz/';
  static const String BASE_URL2 = 'https://auth.exampur.work/';

  // static const String BASE_URL3 = 'https://static.exampur.xyz/';
  static const String BASE_URL3 = 'https://static.exampur.work/';


  static const String BANNER_BASE_URL = 'https://static.exampur.work/get_cdn';

  //Auth
  static const String Login_URL = BASE_URL2 + 'auth/login';
  static const String Valid_Token_URL = BASE_URL2 + 'user';
  static const String Update_User_URL = BASE_URL2 + 'user';
  static const String Change_Password_URL = BASE_URL2 + 'auth/changePassword';
  static const String Send_OTP_URL = BASE_URL2 + 'otp';
  static const String Reset_Password_URL = BASE_URL2 + 'auth/resetPassword';
  static const String Verify_OTP_URL = BASE_URL2 + 'auth/verification';

  //HomeBanner
  static const String homeBanner_URL = BASE_URL3 + 'banners';

  //Category
  static const String Choose_category_URL = BASE_URL3 + 'category/all';
  static const String Update_Choose_category_URL = BASE_URL2 + 'user/updateCategory';
  static const String Select_Choose_category_URL = BASE_URL2 + 'user/getCategory';

  //Book/E-Book
  static const String Books_URL = BASE_URL3 + 'books/printed/10/0';
  static const String E_Books_URL = BASE_URL3 + 'books/ebook/10/0';

  //PaidCourse
  static const String PaidCoursesTab_URL = BASE_URL3 + 'category/course_paid';
  static const String PaidCoursesList_URL = BASE_URL3 + 'courses/paid/' + 'PAID_COURSE_ID' + '/10/';

  //FreeCourse
  static const String FreeCoursesTab_URL = BASE_URL3 + 'category/course_free';
  static const String FreeCoursesList_URL = BASE_URL3 + 'courses/free/' + 'FREE_COURSE_ID' + '/10/';

//one2one
  static const String One2One_URL = BASE_URL3 + 'courses/onetoone/10/';
  static const String TermsConditions_URL = 'https://exampur.com/';

  //offlineBatches
  static const String offline_batches = BASE_URL3 + 'offline_centers/findall/10/';
  static const String offline_batches_center = BASE_URL3 + 'offline_centers/findone/' + 'CENTER_ID' + '/10/';
  static const String offline_batches_course = BASE_URL3 + 'offline_centers/course/' + 'COURSE_ID';

//appTutorial
  static const String AppTutorial_URL = BASE_URL3 + 'tutorials/app';

  //helpandffedback
  static const String HelpFeedback_URL = BASE_URL2 + 'ticket/create';

  //order_course
  static const String order_course    = BASE_URL2 + 'order_course/create';
  static const String finalize_order  = BASE_URL2 + 'order_course/finalize';

}

class Keys {
  static const String Rozar_pay_key = 'rzp_test_tnxy74fGchHvRY';
}

class SharedPrefConstants {
  static const String TOKEN = 'Token';
  static const String BANNER_BASE_SP = 'Banner_Base';
  static const String USER_DATA = 'user_data';
  static const String USER_paymentdata = 'user_payment';
  static const String CATEGORY_LENGTH = 'category_length';
}

class AppConstants {

  static bool isPrint = true;
  static bool isAuth = false;
  static String BANNER_BASE = '';

  static String defaultCountry = 'India';

  static String Mobile_number = '9873111552';
  static String playStoreAppUrl = 'https://play.google.com/store/apps/details?id=com.edudrive.exampur';
  static String androidId = 'com.edudrive.exampur';
  static String iosId = '';

  static String shareAppContent = 'Hey check out EXAMPUR App at: ' +
      playStoreAppUrl;

  static void printLog(message) {
    if (isPrint)
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

  static void shareData({String? assetImagePath, required String message}) {
    if (assetImagePath == null || assetImagePath.isEmpty) {
      Share.share(message);
    } else {
      Share.shareFiles(['${assetImagePath}'], text: message);
      //Share.shareFiles(['assets/images/baws.png'], text: 'Great picture');
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

  static void showAlertDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: new Column(
        children: [
          Container(padding: EdgeInsets.all(8),
              child: Text("Message", style: TextStyle(fontSize: 16))),
          Container(padding: EdgeInsets.all(8), child: Text(message)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 10), child: Text("Loading...")),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Widget image(String imagePath, {height, width, boxfit}) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: boxfit,
      imageUrl: imagePath,
      placeholder: (context, url) => new Image.asset(Images.no_image),
      errorWidget: (context, url, error) => new Image.asset(Images.no_image),
    );
  }

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

}

class AppColors {

  static const Color amber = Colors.amber;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color white24 = Colors.white24;
  static const Color white38 = Colors.white38;
  static const Color white54 = Colors.white54;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color yellow = Colors.yellow;
  static const Color blue = Colors.blue;
  static const Color orange = Colors.orange;
  static const Color cyan = Colors.cyan;
  static const Color blueGrey = Colors.blueGrey;
  static const Color grey = Colors.grey;
  static const Color transparent = Colors.transparent;

  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey600 = Colors.grey[600]!;

  static Color brown400 = Colors.brown[400]!;

  static Color blue300 = Colors.blue[300]!;

  static const Color dark = Color(0xFFd19d0f);
  static const Color jobAlert = Color(0xFF14739c);
  static const Color darkOrange = Color(0xFFf76d02);
  static const Color quiz = Color(0xFF0582f7);
  static const Color affairs = Color(0xFF7790a6);
  static const Color freeCourses = Color(0xFFf23587);
  static const Color one2one = Color(0xFF069413);
  static const Color book = Color(0xFF0b8f8d);
  static const Color paidCourses = Color(0xFFa807a8);
  static const Color series = Color(0xFFd44242);
}