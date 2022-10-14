import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'app_constants.dart';

class AnalyticsConstants {
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
  static String prebookClick            = 'PreBookClicked';

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
}