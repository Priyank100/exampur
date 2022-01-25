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

  //coupon
  static const String CouponCode_URL = BASE_URL2 +'promo_code/';

  //demo
  static const String Demo_URL =BASE_URL3 +'courses/demo/10/';

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
      duration: Duration(milliseconds: 700),
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
  static Color grey500 = Colors.grey[500]!;
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

class StringConstant {

  static String appTutorial= 'app_tutorial';
  static String allFieldsMandatory= 'all_fields_mandatory';
  static String applyCoupon= 'apply_coupon';
  static String address= 'address';
  static String add= 'add';
  static String apply= 'apply';

  static String books= 'books';
  static String buy= 'buy';
  static String buyCourse= 'buy_course';

  static String currentAffairs= 'current_affairs';
  static String chooseCategory= 'choose_category';
  static String city= 'city';
  static String confirmPassword= 'confirm_password';
  static String changePassword= 'change_password';
  static String currentPassword= 'current_password';
  static String continueToBuyCourse= 'continue_to_buy_course';
  static String calculate= 'calculate';

  static String downloads= 'downloads';
  static String dailyQuiz= 'daily_quiz';
  static String demo= 'demo';
  static String demo_classes= 'demo_classes';

  static String email= 'email';
  static String exampurOne2one= 'exampur_one2one';
  static String eligibilityCalculator= 'eligibility_calculator';
  static String enterFirstName= 'enter_first_name';
  static String enterYourLastName= 'enter_your_last_name';
  static String enterPhoneNumber= 'enter_phone_number';
  static String enterLandmark= 'enter_landmark';
  static String enterAddress= 'enter_address';
  static String enterCity= 'enter_city';
  static String enterState= 'enter_state';
  static String enterPinCode= 'enter_pin_code';

  static String freeCourses= 'free_courses';
  static String firstName= 'first_name';

  static String hello= 'hello';
  static String home= 'home';
  static String homePage= 'home_page';
  static String help= 'help';
  static String helpAndFeedback= 'help_and_feedback';

  static String issueSubmittedSuccessfully= 'issue_submitted_successfully';

  static String lastName= 'last_name';
  static String logOut= 'log_out';
  static String landmarkTehsil= 'landmark_tehsil';
  static String languagePreferences= 'language_preferences';

  static String paidCourse= 'paid_course';
  static String pleaseChooseTheCategory= 'please_choose_the_category';
  static String phoneNumber= 'phone_number';
  static String pinCode= 'pin_code';
  static String provideFurtherDetailsForDeliveryOfCourses= 'provide_further_details_for_delivery_of_courses';
  static String preference= 'preference';

  static String name= 'name';
  static String newPassword= 'new_password';
  static String newBatch= 'new_batch';

  static String testCourses= 'test_courses';

  static String offlineBatches= 'offline_batches';

  static String jobAlerts= 'job_alerts';

  static String submitIssue= 'submit_issue';
  static String studyMaterials= 'study_materials';
  static String serverError= 'server_error';
  static String settings= 'settings';
  static String shareNow= 'share_now';
  static String selectCategories= 'select_categories';
  static String searchCategory= 'search_category';
  static String state= 'state';
  static String selectLanguage= 'select_language';
  static String security= 'security';
  static String saveProfile= 'save_profile';
  static String saveTheCourse= 'save_the_course';
  static String share= 'share';
  static String skip= 'skip';

  static String watchAppTutorial= 'watch_app_tutorial';
  static String writeAboutTheProblem= 'write_about_the_problem';
  static String watch= 'watch';

  static String myPurchase= 'my_purchase';
  static String myTimetable= 'my_timetable';
  static String myCourses= 'my_courses';

  static String rateUs= 'rate_us';
  static String recorded= 'recorded';

  static String general= 'general';

  static String userName= 'user_name';

  static String viewDetails= 'view_details';
  static String viewAll= 'view_all';

}