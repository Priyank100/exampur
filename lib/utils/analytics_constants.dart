import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';

import 'app_constants.dart';

class AnalyticsConstants {
  static MoEngageFlutter _moengagePlugin = MoEngageFlutter();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static String splashScreen              = 'Splash_Screen';
  static String loginScreen               = 'Login_Screen';
  static String bannerCourseClick         = 'Banner_Course_Clicked';
  static String bannerBookClick           = 'Banner_Book_Clicked';
  static String bannerExternalLinksClick  = 'Banner_External_Link_Clicked';
  static String paidCourseClick           = 'Paid_Course_Clicked';
  static String freeCourseClick           = 'Free_Course_Clicked';
  static String booksClick                = 'Books_Clicked';
  static String testSeriesClick           = 'Test_Series_Clicked';
  static String dailyQuizClick            = 'Daily_Quiz_Clicked';
  static String currentAffairsClick       = 'Current_Affairs_Clicked';
  static String sideBarClick              = 'Side_Bar_Clicked';
  static String logoutClick               = 'Logout_Clicked';
  static String demoClick                 = 'Demo_Clicked';
  static String myCoursesClick            = 'My_Courses_Clicked';
  static String downloadsClick            = 'Downloads_Clicked';

  static void sendAnalyticsEvent(String clickName) async {
    await analytics.logEvent(
      name: clickName,
    );
  }

  static AppsflyerSdk? appsflyerSdk;
  static void initAppFlyer() {
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: 'fTnrQRnV94zciX3oyNoNu',
      appId: 'com.edudrive.exampur',
      showDebug: true,
    );
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    appsflyerSdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
  }

  static void logEvent(String eventName, Map? eventValues) async {
    bool? result;
    try {
      result = await appsflyerSdk!.logEvent(eventName, eventValues);
      AppConstants.printLog("anchal+$result");
      AppConstants.printLog(eventName);
    } on Exception catch (e) {
      AppConstants.printLog("Error: $e");
    }
  }

  static void moEngageInitialize(){
    _moengagePlugin.initialise();
    // _moengagePlugin.setUniqueId('UAIIRLJXLAVMA3I6TOFYHV8P');
  }

  static void trackEventMoEngage(String eventName, Map<String, String> map) {
    var properties = MoEProperties();
    for(var entry in map.entries) {
      properties.addAttribute(entry.key, entry.value);
    }
   _moengagePlugin.trackEvent(eventName, properties);
     AppConstants.printLog(properties.generalAttributes);
    // AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Moengage');
  }

  static String Login_page    = 'Login_page';
  static String Click_Submit    = 'Click_Submit';
  static String Home_Page    = 'Home_Page';
  static String Click_Forgot_Password_Login    = 'Click_Forgot_Password_Login';
  static String Click_Call_Us_Login    = 'Click_Call_Us_Login';
  static String Error_Invalid_Mobile    = 'Error_Invalid_Mobile';
  static String Error_Incorrect_Password    = 'Error_Incorrect_Password';
  static String Sign_Up    = 'Sign_Up';
  static String Click_Register    = 'Click_Register';
  static String Signup_OTP_Page    = 'Signup_OTP_Page';
  static String Click_Skip_OTP    = 'Click_Skip_OTP';
  static String Click_Login_New_Register    = 'Click_Login_New_Register';
  static String Error_Invalid_OTP    = 'Error_Invalid_OTP';
  static String Click_Banner_Home    = 'Click_Banner_Home';
  static String Click_Paid_Courses    = 'Click_Paid_Courses';
  static String Click_Books    = 'Click_Books';
  static String Click_Test_Series    = 'Click_Test_Series';
  static String Click_Quiz    = 'Click_Quiz';
  static String Click_Study_Material    = 'Click_Study_Material';
  static String Click_Job_Alerts    = 'Click_Job_Alerts';
  static String Click_Current_Affairs    = 'Click_Current_Affairs';
  static String Click_Previous_Year_PDF    = 'Click_Previous_Year_PDF';
  static String Click_Practice_Questions    = 'Click_Practice_Questions';
  static String Click_Live_Test    = 'Click_Live_Test';
  static String Click_Translate_English    = 'Click_Translate_English';
  static String Click_My_Courses    = 'Click_My_Courses';
  static String Click_Watch_Now    = 'Click_Watch_Now';



}