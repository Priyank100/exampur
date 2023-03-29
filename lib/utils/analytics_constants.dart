import 'dart:convert';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:moengage_flutter/constants.dart';
import 'package:moengage_flutter/inapp_campaign.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/properties.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import '../Localization/language_constrants.dart';
import '../SharePref/shared_pref.dart';
import '../presentation/AppTutorial/app_tutorial.dart';
import '../presentation/DeliveryDetail/delivery_detail_screen.dart';
import '../presentation/home/BannerBookDetailPage.dart';
import '../presentation/home/banner_link_detail_page.dart';
import '../presentation/home/books/books_ebooks.dart';
import '../presentation/home/current_affairs_new/current_affairs_details.dart';
import '../presentation/home/current_affairs_new/current_affairs_tab.dart';
import '../presentation/home/job_alert_new/job_notifications.dart';
import '../presentation/home/paid_courses/paid_courses.dart';
import '../presentation/home/practice_question/practice_question_category.dart';
import '../presentation/home/practice_question/practice_question_listing.dart';
import '../presentation/home/study_material_new/study_material_new.dart';
import '../presentation/home/study_material_new/study_material_sub_category.dart';
import '../presentation/home/test_series_new/test_series_new.dart';
import '../presentation/my_courses/TeacherSubjectView/DownloadPdfView.dart';
import '../presentation/my_courses/TeacherSubjectView/material_video.dart';
import '../presentation/my_courses/myCoursetabview.dart';
import 'app_colors.dart';
import 'app_constants.dart';
import 'lang_string.dart';

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
  static String prebookClick              = 'Pre_Book_Clicked';

  static String splashScreenNew           = 'New_Splash_Screen';
  static String loginClick                = 'New_Login_Clicked';
  static String letsRegisterClick         = 'New_Lets_Register_Clicked';
  static String registerClick             = 'New_Register_Clicked';
  static String callSignUpClick           = 'New_Call_Signup_Clicked';
  static String verifyOTPClick            = 'New_Verify_OTP_Clicked';
  static String skipOTPClick              = 'New_Skip_OTP_Clicked';
  static String saveCategoryClick         = 'New_Save_Category_Clicked';
  static String liveCourseClick           = 'New_Live_Course_Clicked';
  static String viewDetailClick           = 'New_View_Detail_Clicked';
  static String buyCourse1Click           = 'New_Buy_Course_1_Clicked';
  static String buyCourse2Click           = 'New_Buy_Course_2_Clicked'; // (inside view detail)
  static String applyCouponClick          = 'New_Apply_Coupon_Clicked'; // (after putting in coupon code)
  static String continueToBuyClick        = 'New_Continue_To_Buy_Clicked';
  static String payNowClick               = 'New_Pay_Now_Clicked';
  static String purchaseSuccess           = 'New_Purchase_Successful';
  static String purchaseFailed            = 'New_Purchase_Failed';

  static void sendAnalyticsEvent(String clickName) async {
    await analytics.logEvent(
      name: clickName,
    );
  }

  static void firebaseEvent(String clickName, Map<String, dynamic> mapData) async {
    await analytics.logEvent(
      name: clickName,
      parameters: mapData
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

  static void onInAppClick(InAppCampaign message, context) {
   // https://edudrive.page.link/course/courseId=63412111d60860384c299bd3
    List<String> actiondata = message.navigationAction!.url.split("/");

    if (actiondata[3] == 'course') {
      AppConstants.goTo(
          context,
          BannerLinkDetailPage(
            'Course',
            actiondata[1],
          ));
      // Navigator.push(context,MaterialPageRoute(settings: RouteSettings(name: 'Direct'),
      //     builder: (_) => BannerLinkDetailPage('Course', actiondata[1],)));

    }
  }

  static void _onInAppShown(InAppCampaign message) {
   // print("This is a callback on inapp shown from native to flutter. Payload " +
     //   message.toString());
  }

  static void _onInAppDismiss(InAppCampaign message) {
    // print(
    //     "This is a callback on inapp dismiss from native to flutter. Payload " +
    //         message.toString());
  }

  static void _onInAppCustomAction(InAppCampaign message) {
    // print(
    //     "This is a callback on inapp custom action from native to flutter. Payload " +
    //         message.toString());
  }

  static void _onInAppSelfHandle(InAppCampaign message) {
    // print(
    //     "This is a callback on inapp self handle from native to flutter. Payload " +
    //         message.toString());
  }

  static Future<void> moEngageInitialize(BuildContext context) async {
    String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    moengagePlugin.initialise();
    moengagePlugin.showInApp();
    moengagePlugin.setUpInAppCallbacks(
        onInAppClick: (inAppCompaign) {
          String dynamicBase = 'link.exampur.com/';
          // List<String> actiondata =
          //     inAppCompaign.navigationAction!.url.split('');
          // List<String> actionId = actiondata[4].split("=");
          // print('>>>>>>>>>>>>>>>>>>' + actionId[1] );

          String screenWithData = inAppCompaign.navigationAction!.url.split(
              dynamicBase)[1];

          // print('>>>>>>>>>>>>>>');
          // print(screenWithData);

          String screenName = '';
          List<String> actiondata = [];

          if (screenWithData.contains('?')) {
            actiondata = [
              screenWithData.substring(0, screenWithData.indexOf("?")).trim(),
              screenWithData.substring(screenWithData.indexOf("?") + 1).trim()
            ];
            screenName = actiondata[0];
          } else {
            screenName = screenWithData;
          }



//======================================CouponCode========================================//
          if (screenName == 'checkout') {
            List<String> courseData = [
              actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
              actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
            ];
            checkOutPageApi(context,courseData[1]);

          }
//======================================StudyMaterialScreen========================================//
          else if (screenName == "study-material") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, StudyMaterialNew(0));
            } else {
              if(actiondata[1].toLowerCase().contains('tab-title')){
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("&")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("&") + 1).trim()
                ];
                AppConstants.goTo(context, StudyMaterialSubCategory(0,tabData[0].replaceAll('tab-title=', ''),tabData[1].replaceAll('category-id=', '')));
              }else{
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
                ];
                AppConstants.goTo(context, StudyMaterialNew(0,tabId: tabData[1],));
              }
            }
          }
//============================================previousyear================================//
          else if (screenName == "previous-year-pdf") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, StudyMaterialNew(1));
            } else {
              if(actiondata[1].toLowerCase().contains('tab-title')){
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("&")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("&") + 1).trim()
                ];
                AppConstants.goTo(context, StudyMaterialSubCategory(1,tabData[0].replaceAll('tab-title=', ''),tabData[1].replaceAll('category-id=', '')));
              }else{
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
                ];
                AppConstants.goTo(context, StudyMaterialNew(1,tabId: tabData[1],));
              }
            }
          }
//======================================practiseQuestion==========================================//
          else if (screenName == "practice-question") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, PracticeQuestionCategory());
            }
            else {
              if(actiondata[1].toLowerCase().contains('name')){
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("&")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("&") + 1).trim()
                ];
               // name,category.name.toString(),slug,category.slug.toString()
                AppConstants.goTo(context, PracticeQuestionListing(tabData[0].replaceAll('name=', ''),tabData[1].replaceAll('category-name=', ''),tabData[2].replaceAll('slug=', ''),tabData[3].replaceAll('category-slug=', '')));
              }
              else{
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
                ];
                AppConstants.goTo(context, PracticeQuestionCategory(tabId: tabData[1],));
              }

            }
          }
//======================================currentAffairScreen========================================//
          else if (screenName == "current-affair") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, CurrentAffairsTab());
            }
           else{
              AppConstants.goTo(context, CurrentAffairsDetails('hi',actiondata[1].replaceAll('article-id=', '')));
            }
          }
//======================================jobAlertScreen========================================//
          else if (screenName == "job-alert") {
            // print('jobAlert');
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, JobNotifications());
            }
            else {
              if(actiondata[1].contains('&')) {
                List<String> tabData = [
                  actiondata[1].substring(0, actiondata[1].indexOf("&")).trim(),
                  actiondata[1].substring(actiondata[1].indexOf("&") + 1).trim()
                ];
                AppConstants.goTo(context, JobNotifications(
                    courseIdMoE: tabData[0].replaceAll('course-id=', ''),
                    tagSlugMoE: tabData[1].replaceAll('tag-slug=', '')));
              } else {
                AppConstants.goTo(context, JobNotifications(
                    courseIdMoE: actiondata[1].replaceAll('course-id=', '')));
              }
            }
          }
//=====================================paid-Course======================================//
          else if (screenName == "paid-course") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, PaidCourses(1));
            } else {
              AppConstants.goTo(context, PaidCourses(
                1, categoryId: actiondata[1].replaceAll('category-id=', ''),));
            }
          }
//=======================================Free-Course================================//
          else if (screenName == "free-course") {
            if(actiondata == null || actiondata.isEmpty) {
              AppConstants.goTo(context, PaidCourses(0));
            } else {
              AppConstants.goTo(context, PaidCourses(
                0, categoryId: actiondata[1].replaceAll('category-id=', ''),));
            }
          }
//================================================MyCourse===============================//
          else if (screenName == 'my-course'){
            List<String> mycourse = actiondata[1].split('&');
           AppConstants.goTo(context, MyCourseTabView(mycourse[0].replaceAll('courseId=',''),mycourse[1].replaceAll('title=',''),mycourse[2].replaceAll('testSeriesLink=',''),token,tabIndex:int.parse(mycourse[3].replaceAll('tabIndex=',''))));
          }
//========================================AppTutorial====================================//
          else if (screenName == "app-tutorial") {
            AppConstants.goTo(context, AppTutorial());
          }
//========================================bookListingPage===============================//
          else if (screenName == "books") {
            AppConstants.goTo(context, BooksEbook(bookEbookTab:0));
          }
          else if (screenName == "ebooks") {
            AppConstants.goTo(context, BooksEbook(bookEbookTab:1));
          }
//=====================================================bookdetailpage===============================//
          else if (screenName == "book-detail") {
            List<String> bookId = [
              actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
              actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
            ];
            AppConstants.goTo(context, BannerLinkBookDetailPage('Book',bookId[1]));
          }
//=====================================================recorded===============================//
          else if (screenName == "recorded") {
            List<String> act = actiondata[1].split('&').toList();
            String title = act[0].split('=')[1];
            String vid = act[1].split('=')[1];
            bool contentLog = act[2].split('=')[1].toLowerCase()=='true'?true:false;
            String url = act[3].split('=')[1];
            AppConstants.goTo(context, MyMaterialVideo(url,title,'',vid,contentLog));
          }
//=============================================pdf===========================================//
          else if (screenName == "pdf") {
            List <String> titles = [
              actiondata[1].substring(0, actiondata[1].indexOf("&")).trim(),
              actiondata[1].substring(actiondata[1].indexOf("&") + 1).trim()
            ];
            AppConstants.goTo(context, DownloadViewPdf(
                titles[0].replaceAll('title=', ''),
                titles[1].replaceAll('url=', '')));
          }
//======================================TestScreen========================================//
          else if (screenName == "live-test" ||
              screenName == "quiz"|| screenName =="test-series") {
            List<String> urlData = [
              actiondata[1].substring(0, actiondata[1].indexOf("=")).trim(),
              actiondata[1].substring(actiondata[1].indexOf("=") + 1).trim()
            ];
            AppConstants.goTo(context, TestSeriesNew(urlData[1], token));
          }
//===============================================================================================
        },
        onInAppShown: _onInAppShown,
        onInAppDismiss: _onInAppDismiss,
        onInAppCustomAction: _onInAppCustomAction,
        onInAppSelfHandle: _onInAppSelfHandle);
    // moengagePlugin.passFCMPushToken('UAIIRLJXLAVMA3I6TOFYHV8P');
    // _moengagePlugin.setUserName(AppConstants.userName);
    // _moengagePlugin.setPhoneNumber(AppConstants.userMobile);
    // _moengagePlugin.setUniqueId(AppConstants.userMobile);
  }

  static void trackEventMoEngage(String eventName, Map<String, dynamic> map) {
    // moengagePlugin.showInApp();
    var properties = MoEProperties();
    for (var entry in map.entries) {
      properties.addAttribute(entry.key, entry.value);
    }
    moengagePlugin.trackEvent(eventName, properties);
    AppConstants.printLog(properties.generalAttributes);
    // AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Moengage');
  }

  static Future<void> checkOutPageApi(BuildContext context,String courseID) async {
    await Service.get(API.checkoutUrl.replaceAll('courseID', courseID)).then((response) {
      AppConstants.printLog(response.body.toString());
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject['statusCode'].toString() == '200') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  DeliveryDetailScreen(
                      jsonObject['data']['type'],courseID,jsonObject['data']['title'],jsonObject['data']['sale_price'].toString()
                  )));
        }
      }
      else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      }
    });
  }


  static String Login_page = 'Login_page';
  static String Click_Submit = 'Click_Submit';
  static String Home_Page = 'Home_Page';
  static String Click_Forgot_Password_Login = 'Click_Forgot_Password_Login';
  static String Click_Call_Us_Login = 'Click_Call_Us_Login';
  static String Error_Invalid_Mobile = 'Error_Invalid_Mobile';
  static String Error_Incorrect_Password = 'Error_Incorrect_Password';
  static String Sign_Up = 'Sign_Up';
  static String Click_Register = 'Click_Register';
  static String Signup_OTP_Page = 'Signup_OTP_Page';
  static String Click_Skip_OTP = 'Click_Skip_OTP';
  static String Click_Login_New_Register = 'Click_Login_New_Register';
  static String Error_Invalid_OTP = 'Error_Invalid_OTP';
  static String Click_Banner_Home = 'Click_Banner_Home';
  static String Click_Paid_Courses = 'Click_Paid_Courses';
  static String Click_Books = 'Click_Books';
  static String Click_Test_Series = 'Click_Test_Series';
  static String Click_Quiz = 'Click_Quiz';
  static String Click_Study_Material = 'Click_Study_Material';
  static String Click_Study_Material_Pdf = 'Click_Study_Material_Pdf';
  static String Click_Job_Alerts = 'Click_Job_Alerts';
  static String Click_Current_Affairs = 'Click_Current_Affairs';
  static String Click_Previous_Year_PDF = 'Click_Previous_Year_PDF';
  static String Click_Practice_Questions = 'Click_Practice_Questions';
  static String Click_Live_Test = 'Click_Live_Test';
  static String Click_Translate_English = 'Click_Translate_English';
  static String Click_Translate_Hindi = 'Click_Translate_Hindi';
  static String Click_My_Courses = 'Click_My_Courses';
  static String Click_Watch_Now = 'Click_Watch_Now';
  static String Course_List = 'Course_List';
  static String Click_Buy_Course = 'Click_Buy_Course';
  static String Click_Share_Course = 'Click_Share_Course';
  static String Click_View_Details_Course = 'Click_View_Details_Course';
  static String Click_View_PDF = 'Click_View_PDF';
  static String Coupon_Code_Successfully_Applied = 'Coupon_Code_Successfully_Applied';
  static String Coupon_Code_Failed = 'Coupon_Code_Failed';
  static String Click_Recommended_Book = 'Click_Recommended_Book';
  static String Check_Out_Page = 'Check_Out_Page';
  static String Click_Pay_Now = 'Click_Pay_Now';
  static String Purchase_Successful = 'Purchase_Successful';
  static String Purchase_Failed = 'Purchase_Failed';
  static String Books_List = 'Books_List';
  static String Click_Share_Books = 'Click_Share_Books';
  static String Click_Buy_Book = 'Click_Buy_Book';
  static String Click_Place_Order = 'Click_Place_Order';
  static String Click_Confirm_Purchase_Books = 'Click_Confirm_Purchase_Books';
  static String Current_Affairs = 'Current_Affairs';
  static String Click_CA_Article = 'Click_CA_Article';
  static String Click_Alerts = 'Click_Alerts';
  static String Click_App_Tutorial_Page_Side_Nav = 'Click_App_Tutorial_Page_Side_Nav';
  static String Click_Choose_Category_Side_Nav = 'Click_Choose_Category_Side_Nav';
  static String Click_My_Purchase_Side_Nav = 'Click_My_Purchase_Side_Nav';
  static String Click_Downloads_Side_Nav = 'Click_Downloads_Side_Nav';
  static String Click_Attempted_Test_Side_Nav = 'Click_Attempted_Test_Side_Nav';
  static String Click_Attempted_Quiz_Side_Nav = 'Click_Attempted_Quiz_Side_Nav';
  static String Click_Saved_Questions_Side_Nav = 'Click_Saved_Questions_Side_Nav';
  static String Click_Settings_Side_Nav = 'Click_Settings_Side_Nav';
  static String Click_Privacy_Policy_Side_Nav = 'Click_Privacy_Policy_Side_Nav';
  static String Click_Share_Now_Side_Nav = 'Click_Share_Now_Side_Nav';
  static String Click_Rate_Us_Side_Nav = 'Click_Rate_Us_Side_Nav';
  static String Click_Log_Out_Side_Nav = 'Click_Log_Out_Side_Nav';
  static String Click_Watch_Now_App_Tutorial = 'Click_Watch_Now_App_Tutorial';
  static String Click_Demo_Bottom_Nav = 'Click_Demo_Bottom_Nav';
  static String Click_My_Courses_Bottom_Nav = 'Click_My_Courses_Bottom_Nav';
  static String Click_Downloads_Bottom_Nav = 'Click_Downloads_Bottom_Nav';
  static String Click_Help_Bottom_Nav = 'Click_Help_Bottom_Nav';
  static String Stop_Video = 'Stop_Video';
  static String Stop_Live_Video = 'Stop_Live_Video';
  static String Enter_Mobile_Login = 'Enter_Mobile_Login';
  static String Enter_Password_Login = 'Enter_Password_Login';
  static String Enter_Email_Login = 'Enter_Email_Login';
  static String Click_Agree_TnC = 'Click_Agree_TnC';
  static String Click_State = 'Click_State';
  static String Enter_Name = 'Enter_Name';
  static String Enter_Password = 'Enter_Password';
  static String Enter_Email_ID = 'Enter_Email_ID';
  static String Enter_Mobile_Number = 'Enter_Mobile_Number';
  static String Enter_City = 'Enter_City';
  static String Enter_OTP = 'Enter_OTP';
  static String Click_Verify_OTP = 'Click_Verify_OTP';
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
  static String Signup_Successful = 'Signup_Successful';
  static String Click_View_Demo = 'Click_View_Demo';
  static String Click_Purchase_Now_Sampling = 'Click_Purchase_Now_Sampling';
  static String Purchase_Now_Sampling = 'Purchase_Now_Sampling';
  static String Click_Doubts_Unlock_Sampling = 'Click_Doubts_Unlock_Sampling';
  static String Click_Subject = 'Click_Subject';
  static String Click_Chapter = 'Click_Chapter';
  static String Course_Detail_page = 'Course_Detail_page';
  static String Free_Course_List = 'Free_Course_List';
  static String Click_Free_Course_Details = 'Click_Free_Course_Details';
  static String Course_Details_Page = 'Course_Details_Page';
  static String Payment_Page_Back_Button = 'Payment_Page_Back_Button';
  static String Click_Topic_Study_Material = 'Click_Topic_Study_Material';
  static String My_Courses_Timeline = 'My_Courses_Timeline';
  static String Click_offline_Courses= 'Click_offline_Courses';
  static String Offline_call_us= 'Offline_call_us';
  static String counselling= 'counselling';
  static String recordedcoursevod= 'Recorded Course VOD';
  static String Click_class_feedback= 'Click_class_feedback';
  static String Click_rating_count= 'Click_rating_count';
  static String Submit_feedback= 'Submit–feedback';
  static String Demo_Book_pdf= 'Demo_Book_pdf';
  static String click_card_bottom_nav= 'Click_Card_Bottom_Nav';
  static String offer_tab_Bottom_Nav= 'offer_tab_Bottom_Nav';
  static String click_youtube_bottom_nav= 'Click_Youtube_Bottom_Nav';
  static String channel_page_landed= 'Channel_Page_Landed';
  static String Playlist_click= 'Playlist_Click';
  static String Youtube_video_play= 'Youtube_Video_Play';
  static String YouTube_course_detail= 'YouTube_Course_Detail';
  static String YouTube_buy_now= 'YouTube_Buy_Now';
  static String YouTube_click_paid_course= 'YouTube_Click_Paid_Course';
  static String view_youtube_pdf= 'view_youtube_pdf';
  static String popup_course_buy= 'Popup_course_buy';
  static String popup_book_buy= 'Popup_book_buy';
  static String cross_buy_popup = 'cross_buy_popup';
  static String Teacher_code_submit = 'Teacher_code_submit';
  static String Teacher_code_cross = 'Teacher_code_cross';
  static String Cross_signup= 'Cross_signup';
  static String cross_purchase= 'cross_purchase';
  static String QOD_click= 'QOD_click';
  static String E_Bookclick= 'E_book_click';
}