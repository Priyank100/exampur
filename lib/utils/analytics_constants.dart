import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:moengage_flutter/constants.dart';
import 'package:moengage_flutter/inapp_campaign.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';

import '../SharePref/shared_pref.dart';
import '../presentation/home/BannerBookDetailPage.dart';
import '../presentation/home/banner_link_detail_page.dart';
import '../presentation/home/books/books_ebooks.dart';
import '../presentation/home/current_affairs_new/current_affairs_tab.dart';
import '../presentation/home/job_alert_new/job_notifications.dart';
import '../presentation/home/study_material_new/study_material_new.dart';
import '../presentation/home/test_series_new/test_series_new.dart';
import 'app_constants.dart';

class AnalyticsConstants {

  static MoEngageFlutter moengagePlugin = MoEngageFlutter();
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
  late BuildContext context;
  static void onInAppClick(InAppCampaign message,context) {

    print('>>>>>>>>>>>'+ message.navigationAction!.url);// https://edudrive.page.link/course/courseId=63412111d60860384c299bd3
    List<String> actiondata = message.navigationAction!.url.split("/");
    print(actiondata[3]);

    if(actiondata[3] == 'course') {
      AppConstants.goTo(context, BannerLinkDetailPage('Course', actiondata[1],));
      // Navigator.push(context,MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
      //     builder: (_) => BannerLinkDetailPage('Course', actiondata[1],)));

    }



  }

  static void _onInAppShown(InAppCampaign message) {
    print("This is a callback on inapp shown from native to flutter. Payload " +
        message.toString());
  }

  static void _onInAppDismiss(InAppCampaign message) {
    print("This is a callback on inapp dismiss from native to flutter. Payload " +
        message.toString());
  }

  static void _onInAppCustomAction(InAppCampaign message) {
    print("This is a callback on inapp custom action from native to flutter. Payload " +
        message.toString());
  }

  static void _onInAppSelfHandle(InAppCampaign message) {
    print("This is a callback on inapp self handle from native to flutter. Payload " +
        message.toString());
  }


  static Future<void> moEngageInitialize(BuildContext context) async {
  String token =  await SharedPref.getSharedPref(SharedPref.TOKEN);
    moengagePlugin.initialise();
    moengagePlugin.showInApp();
    moengagePlugin.setUpInAppCallbacks(
        onInAppClick: (inAppCompaign) {
          List<String> actiondata = inAppCompaign.navigationAction!.url.split("/");
          // List<String> actionId = actiondata[4].split("=");
          // print('>>>>>>>>>>>>>>>>>>' + actionId[1] );
          print('%%^&&&&');
          if(actiondata[3] == 'course') {
            List<String> actionId = actiondata[4].split("=");
            print('>>>>>>>>>>>>>>>>>>' + actionId[1] );
            Navigator.of(context)
                .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
                builder: (_) => BannerLinkDetailPage('Course', actionId[1],)));
          }
          else if(actiondata[3] == "Combo Course"){
            List<String> actionId = actiondata[4].split("=");
            print('>>>>>>>>>>>>>>>>>>' + actionId[1] );
            Navigator.of(context)
                .push(MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
                builder: (_) => BannerLinkDetailPage('Combo Course', actionId[1],)));
            // AppConstants.goTo(context,
            //     BannerLinkDetailPage('Combo Course',actiondata[1],
            //     ));
          }
          else if(actiondata[3] == "Book"){
            AppConstants.goTo(context,   BannerLinkBookDetailPage('Book', actiondata[1],

            ));
          }
          else if(actiondata[3] == "studymaterial"){
            AppConstants.goTo(context,   StudyMaterialNew(0));
          }
          else if(actiondata[3] == "currentaffairs"){
            AppConstants.goTo(context,   CurrentAffairsTab());
          }
          else if(actiondata[3] == "jobalert"){
            AppConstants.goTo(context,   JobNotifications());
          }else if(actiondata[3] == "Livetest"||actiondata[3] == "quizPage" ){
            List<String> actionId = actiondata[4].split("=");
            print('>>>>>>>>>>>>>>>>>>' + actiondata.toString() );
            String url = actionId[1]+'/'+actiondata[5]+'/'+actiondata[6]+'/'+actiondata[7]+'/'+actiondata[8]+'/'+actiondata[9]+'/'+actiondata[10]+'/'+actiondata[11]+actiondata[12];
            print('anchal'+actionId[1]+'/'+actiondata[5]+'/'+actiondata[6]+'/'+actiondata[7]+'/'+actiondata[8]+'/'+actiondata[9]+'/'+actiondata[10]+'/'+actiondata[11]+actiondata[12]);
           print('priyank++++++++'+ url);
            AppConstants.goTo(context,   TestSeriesNew(url,token));
          }
        },
        onInAppShown: _onInAppShown,
        onInAppDismiss: _onInAppDismiss,
        onInAppCustomAction: _onInAppCustomAction,
        onInAppSelfHandle: _onInAppSelfHandle
    );
  // moengagePlugin.passFCMPushToken('UAIIRLJXLAVMA3I6TOFYHV8P');
    // _moengagePlugin.setUserName(AppConstants.userName);
    // _moengagePlugin.setPhoneNumber(AppConstants.userMobile);
    // _moengagePlugin.setUniqueId(AppConstants.userMobile);
  }



  static void trackEventMoEngage(String eventName, Map<String, dynamic> map) {
    // moengagePlugin.showInApp();
    var properties = MoEProperties();
    for(var entry in map.entries) {
      properties.addAttribute(entry.key, entry.value);
    }
   moengagePlugin.trackEvent(eventName, properties);
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
  static String Click_Study_Material_Pdf    = 'Click_Study_Material_Pdf';
  static String Click_Job_Alerts    = 'Click_Job_Alerts';
  static String Click_Current_Affairs    = 'Click_Current_Affairs';
  static String Click_Previous_Year_PDF    = 'Click_Previous_Year_PDF';
  static String Click_Practice_Questions    = 'Click_Practice_Questions';
  static String Click_Live_Test    = 'Click_Live_Test';
  static String Click_Translate_English    = 'Click_Translate_English';
  static String Click_Translate_Hindi    = 'Click_Translate_Hindi';
  static String Click_My_Courses    = 'Click_My_Courses';
  static String Click_Watch_Now    = 'Click_Watch_Now';
  static String Course_List    = 'Course_List';
  static String Click_Buy_Course    = 'Click_Buy_Course';
  static String Click_Share_Course    = 'Click_Share_Course';
  static String Click_View_Details_Course    = 'Click_View_Details_Course';
  static String Click_View_PDF    = 'Click_View_PDF';
  static String Coupon_Code_Successfully_Applied    = 'Coupon_Code_Successfully_Applied';
  static String Coupon_Code_Failed    = 'Coupon_Code_Failed';
  static String Click_Recommended_Book    = 'Click_Recommended_Book';
  static String Check_Out_Page    = 'Check_Out_Page';
  static String Click_Pay_Now    = 'Click_Pay_Now';
  static String Purchase_Successful    = 'Purchase_Successful';
  static String Purchase_Failed    = 'Purchase_Failed';
  static String Books_List    = 'Books_List';
  static String Click_Share_Books    = 'Click_Share_Books';
  static String Click_Buy_Book    = 'Click_Buy_Book';
  static String Click_Place_Order    = 'Click_Place_Order';
  static String Click_Confirm_Purchase_Books    = 'Click_Confirm_Purchase_Books';
  static String Current_Affairs   = 'Current_Affairs';
  static String Click_CA_Article   = 'Click_CA_Article';
  static String Click_Alerts   = 'Click_Alerts';
  static String Click_App_Tutorial_Page_Side_Nav   = 'Click_App_Tutorial_Page_Side_Nav';
  static String Click_Choose_Category_Side_Nav   = 'Click_Choose_Category_Side_Nav';
  static String Click_My_Purchase_Side_Nav   = 'Click_My_Purchase_Side_Nav';
  static String Click_Downloads_Side_Nav   = 'Click_Downloads_Side_Nav';
  static String Click_Attempted_Test_Side_Nav   = 'Click_Attempted_Test_Side_Nav';
  static String Click_Attempted_Quiz_Side_Nav   = 'Click_Attempted_Quiz_Side_Nav';
  static String Click_Saved_Questions_Side_Nav   = 'Click_Saved_Questions_Side_Nav';
  static String Click_Settings_Side_Nav   = 'Click_Settings_Side_Nav';
  static String Click_Privacy_Policy_Side_Nav   = 'Click_Privacy_Policy_Side_Nav';
  static String Click_Share_Now_Side_Nav   = 'Click_Share_Now_Side_Nav';
  static String Click_Rate_Us_Side_Nav   = 'Click_Rate_Us_Side_Nav';
  static String Click_Log_Out_Side_Nav   = 'Click_Log_Out_Side_Nav';
  static String Click_Watch_Now_App_Tutorial   = 'Click_Watch_Now_App_Tutorial';
  static String Click_Demo_Bottom_Nav   = 'Click_Demo_Bottom_Nav';
  static String Click_My_Courses_Bottom_Nav   = 'Click_My_Courses_Bottom_Nav';
  static String Click_Downloads_Bottom_Nav   = 'Click_Downloads_Bottom_Nav';
  static String Click_Help_Bottom_Nav   = 'Click_Help_Bottom_Nav';
  static String Stop_Video   = 'Stop_Video';
  static String Stop_Live_Video   = 'Stop_Live_Video';
  static String Enter_Mobile_Login   = 'Enter_Mobile_Login';
  static String Enter_Password_Login   = 'Enter_Password_Login';
  static String Enter_Email_Login   = 'Enter_Email_Login';
  static String Click_Agree_TnC   = 'Click_Agree_TnC';
  static String Click_State   = 'Click_State';
  static String Enter_Name   = 'Enter_Name';
  static String Enter_Password   = 'Enter_Password';
  static String Enter_Email_ID   = 'Enter_Email_ID';
  static String Enter_Mobile_Number   = 'Enter_Mobile_Number';
  static String Enter_City   = 'Enter_City';
  static String Enter_OTP   = 'Enter_OTP';
  static String Click_Verify_OTP   = 'Click_Verify_OTP';
  static String My_Courses_Subjects = 'My_Courses_Subjects';
  static String My_Courses_Chapter = 'My_Courses_Chapter';
  static String Recorded_Video = 'Recorded_Video';
  static String Download_Video = 'Download_Video';
  static String Stop_Recorded_Video = 'Stop_Recorded_Video';
  static String Click_PDF_Viewer = 'Click_PDF_Viewer';
  static String Click_PDF_Browser = 'Click_PDF_Browser';
  static String My_Courses_Test_Series = 'My_Courses_Test_Series';
  static String Click_Feedback = 'Click_Feedback';
  static String Click_Free_Courses = 'Click_Free_Courses';
  static String My_Courses_Doubts = 'My_Courses_Doubts';
  static String Click_Ask_Doubts = 'Click_Ask_Doubts';
  static String Signup_Successful= 'Signup_Successful';
  static String Click_View_Demo= 'Click_View_Demo';
  static String Click_Purchase_Now_Sampling= 'Click_Purchase_Now_Sampling';
  static String Purchase_Now_Sampling= 'Purchase_Now_Sampling';
  static String Click_Doubts_Unlock_Sampling= 'Click_Doubts_Unlock_Sampling';
  static String Click_Subject= 'Click_Subject';
  static String Click_Chapter= 'Click_Chapter';
  static String Course_Detail_page= 'Course_Detail_page';
  static String Free_Course_List= 'Free_Course_List';
  static String Click_Free_Course_Details= 'Click_Free_Course_Details';
  static String Course_Details_Page= 'Course_Details_Page';
  static String Payment_Page_Back_Button= 'Payment_Page_Back_Button';
  static String Click_Topic_Study_Material= 'Click_Topic_Study_Material';
  static String My_Courses_Timeline= 'My_Courses_Timeline';



}