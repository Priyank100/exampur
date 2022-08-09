import 'dart:convert';
import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/rating_dialog.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'images.dart';

class Keys {
  // static const String Rozar_pay_key = 'rzp_test_tnxy74fGchHvRY';
  // static const String Rozar_pay_key = 'rzp_test_0ltpDbPIMUqirI';
  static const String Razar_pay_key = 'rzp_live_2OGpV3khEWcs8M';
}

class SharedPrefConstants {
  static const String TOKEN           = 'Token';
  static const String USER_DATA       = 'user_data';
  static const String RATING          = 'rating';
}

class AppConstants {

  static bool isPrint       = true;
  static bool isotpverify = false;
  static String langCode    = 'en';
  static String filePath    = 'storage/emulated/0/Download/Exampur';
  static String downloadMag = 'Download has been started. View your file in the download section of your phone or on the app in the "Download" section. Touch outside to close the pop-up. Your file is getting downloaded in the background.';
  static String BANNER_BASE = '';

  static String defaultCountry = 'India';

  static String Mobile_number = '9873111552';
  static String Email_id      = 'help@exampur.com';
  static String Email_sub     = 'Feedback';
  static String playStoreAppUrl = 'https://play.google.com/store/apps/details?id=com.edudrive.exampur';
  static String androidId     = 'com.edudrive.exampur';
  static String iosId         = '';

  static String shareAppContent = 'Hey check out EXAMPUR App at: ' + playStoreAppUrl;
  // static String googleFeedbackFormUrl = 'https://docs.google.com/forms/d/e/1FAIpQLScCCm43CYzI4C0h4HgFCg5XB5dYa0my6q8rDif8IR_3RGuACQ/viewform';
  static String googleFeedbackFormUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSdnU2iboo0rPFiVBWcJZYHXSlIJeDZqiye8D2IqGjvZjrOMdA/viewform?usp=pp_url&entry.43008044=USER_NAME&entry.2068509611=USER_MOBILE';

  static List<String> selectedCategoryList = [];

  // static String currentAffairesId = '61efe9771dbf84752e750373';
  // static String studyMaterialsId = '61efe9921dbf84752e750384';
  // static String currentAffairesId = '6225f4b40536af56be90ed66';
  // static String studyMaterialsId = '6225f4540536af56be90ed28';
  static String currentAffairesId = 'CURRENTAFFAIR';
  static String studyMaterialsId = 'STUDYMATERIALS';

  static String testSeriesToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjI4NjZiNTI2M2JjZDU5NGNlYjQ2OTEiLCJpYXQiOjE2NDY4MTQ5ODIsImV4cCI6MTY0NjkwMTM4Mn0.nC3XmvNX2Y_hKsiF1ZARgaMrWMVJ2w80AFyAKT0mLsA';

  static String CATEGORY_LENGTH       = '0';

  static String serviceLogToken = 'QhmAn5x6UxxWVdc8pkEe77eDAH9U2U9sXjs4kqaxbT2vp5kVmfru5nLL2nEpSQm9dBHLFBeQuEcXmmpzcf34MetTuNXBbaLTuG7pETEGQ2Hp';

  static void printLog(message) {
    if (isPrint) {
      print(message);
    }
  }

  static Future<void> makeCallEmail(String url) async {
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
      duration: Duration(milliseconds: 1000),
    ));
  }

  static void showAlertDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          child: Text(getTranslated(context, StringConstant.cancel)!,style: TextStyle(color: AppColors.amber)),
          onPressed:  () {
            Navigator.pop(context);
          },
        )
      ],
      content: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(padding: EdgeInsets.all(8),
                  child: Text("Message", style: TextStyle(fontSize: 16))),
              Divider(),
              Container(padding: EdgeInsets.all(8), child: Text(message)),
            ],
          )
        ]),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAlertDialogWithButton(BuildContext context, String message, Function function) {
    Widget cancelButton = TextButton(
      child: Text(getTranslated(context, StringConstant.cancel)!,style: TextStyle(color: AppColors.amber)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(getTranslated(context, StringConstant.Continue)!,style: TextStyle(color: AppColors.amber),),
      onPressed:  () {
        function();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(getTranslated(context, StringConstant.Alert)!),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showAlertDialogWithBack(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          child: Text('Close',style: TextStyle(color: AppColors.amber)),
          onPressed:  () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        )
      ],
      content: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(padding: EdgeInsets.all(8),
                    child: Text("Message", style: TextStyle(fontSize: 16))),
                Divider(),
                Container(padding: EdgeInsets.all(8), child: Text(message)),
              ],
            )
          ]),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showLoaderDialog(BuildContext context, {message}) {
    String msg = 'Loading';
    if(message != null) msg=message;
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: AppColors.amber,),
          Container(
              margin: EdgeInsets.only(left: 10), child: Text(msg)),
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

  static Widget noDataFound() {
    return Center(
      child: Image.asset(Images.no_data)
    );
  }

  static Widget comingSoonImage() {
    return Center(
        child: Image.asset(Images.coming_soon)
    );
  }

  /*static bool isEmailValid(String emailId) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\")) @((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailId);
  }*/

  static String encodeCategory() {
    List<String> catIdList = [];
    for (var id in AppConstants.selectedCategoryList)
      catIdList.add('"' + id + '"');
    String encodeCategory = base64.encode(utf8.encode(catIdList.toString().replaceAll(" ", "")));
    return encodeCategory;
  }

  static Future<void> checkPermission(BuildContext context, Permission permission, Function callback) async {
    var status = await permission.status;
    if (status.isGranted) {
      callback();
    } else {
      await permission.request().then((value) async {
        if(value.isGranted) {
          callback();
        } else {
          AppConstants.showBottomMessage(context, 'To download, allow permission', AppColors.black);
        }
      });
    }
  }

  static void createExampurFolder() async {
    final path= Directory(AppConstants.filePath);
    bool exist = await path.exists();
    if (!exist) {
      path.create();
    }
  }

  static Future<void> goTo(BuildContext context, Widget route) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => route
        )
    );
  }

  static Future<void> goAndReplace(BuildContext context, Widget route) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => route
        )
    );
  }

  static Future<String> selectDate(BuildContext context, String dateFormat) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      return DateFormat(dateFormat).format(picked);
    } else {
      return '';
    }
  }

  static Future<void> subscription(String topic) async {
    AppConstants.printLog('>>>Subscription>>' + topic);
    await FirebaseMessaging.instance.subscribeToTopic(topic.replaceAll(' ', '_'));
  }

  static Future<void> unSubscription(String topic) async {
    AppConstants.printLog('>>>UnSubscription>>' + topic);
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic.replaceAll(' ', '_'));
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (e) {
      AppConstants.printLog('Connectivity>> ${e.message}');
      return false;
    }
  }

  static Future<void> checkRatingCondition(BuildContext context, bool isAppClose) async {
    var userValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    String userName = userValue[0]['data']['first_name'].toString();

    var ratingValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.RATING));
    AppConstants.printLog(ratingValue);

    if(ratingValue == null || ratingValue == 'null') {
      showRatingDialog(context);

    } else {
      String name = ratingValue['name'];
      String rating = ratingValue['rating'];
      String date = ratingValue['date'];
      DateTime now = DateTime.now();
      DateTime ratingDate = DateFormat("dd-MM-yyyy").parse(date);
      int difference = now.difference(ratingDate).inDays;

      if(userName == name) {
        if(rating.toString() == 'Cancel') {
          if(difference  > 3) {
            showRatingDialog(context);
          } else if(isAppClose) {exit(0);}
        } else {
          if(int.parse(rating) < 4) {
            if(difference  > 7) {
              showRatingDialog(context);
            } else if(isAppClose) {exit(0);}
          } else if(isAppClose) {exit(0);}
        }
      } else {
        showRatingDialog(context);
      }
    }
  }

  static void showRatingDialog(BuildContext context) {
    showDialog(barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.zero,
            content: RatingDialog(),
          );
        });
  }

}

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

class AppColors {

  static const Color amber       = Colors.amber;
  static const Color black       = Colors.black;
  static const Color white       = Colors.white;
  static const Color white24     = Colors.white24;
  static const Color white38     = Colors.white38;
  static const Color white54     = Colors.white54;
  static const Color red         = Colors.red;
  static const Color green       = Colors.green;
  static const Color yellow      = Colors.yellow;
  static const Color blue        = Colors.blue;
  static const Color orange      = Colors.orange;
  static const Color cyan        = Colors.cyan;
  static const Color blueGrey    = Colors.blueGrey;
  static const Color grey        = Colors.grey;
  static const Color transparent = Colors.transparent;

  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey400 = Colors.grey[400]!;
  static Color grey500 = Colors.grey[500]!;
  static Color grey600 = Colors.grey[600]!;

  static Color brown400 = Colors.brown[400]!;

  static Color blue300 = Colors.blue[300]!;

  static const Color dark        = Color(0xFFd19d0f);
  static const Color jobAlert    = Color(0xFF14739c);
  static const Color darkOrange  = Color(0xFFf76d02);
  static const Color quiz        = Color(0xFF0582f7);
  static const Color affairs     = Color(0xFF7790a6);
  static const Color freeCourses = Color(0xFFf23587);
  static const Color one2one     = Color(0xFF069413);
  static const Color book        = Color(0xFF0b8f8d);
  static const Color paidCourses = Color(0xFFa807a8);
  static const Color series      = Color(0xFFd44242);
}

class StringConstant {

  static String appTutorial= 'app_tutorial';
  static String allFieldsMandatory= 'all_fields_mandatory';
  static String applyCoupon= 'apply_coupon';
  static String address= 'address';
  static String add= 'add';
  static String apply= 'apply';
  static String address_REQUIRED= 'address_REQUIRED';
  static String Age= 'age';
  static String attempthistory= 'attempt_history';
  static String audioOnly= 'audio_only';
  static String attemptQuiz= 'attempt_quiz';
  static String Alert= 'alert';
  static String attemptTest= 'attempt_test';
  static String attemptedQuiz= 'attempted_quiz';

  static String books= 'books';
  static String buy= 'buy';
  static String buyCourse= 'buy_course';
  static String billingaddress= 'billing_address';
  static String book_name= 'book_name';
  static String BackToHomePage= 'back_to_home_page';
  static String BillNumber= 'bill_number';
  static String browser= 'browser';

  static String currentAffairs= 'current_affairs';
  static String chooseCategory= 'choose_category';
  static String city= 'city';
  static String confirmPassword= 'confirm_password';
  static String changePassword= 'change_password';
  static String currentPassword= 'current_password';
  static String continueToBuyCourse= 'continue_to_buy_course';
  static String continueToBuyBook= 'continue_to_buy_book';
  static String calculatorPage= 'calculator_page';
  static String calculate= 'calculate';
  static String CITY_REQUIRED= 'CITY_REQUIRED';
  static String country= 'country';
  static String coursename= 'course_name';
  static String CaBytes= 'ca_bytes';
  static String Class10= '10th_class';
  static String Class12= '12th_class';
  static String ConfirmPasswordNotMatched= 'confirm_password_is_not_matched';
  static String clickHereToViewPDF= 'click_view_PDF';
  static String center= 'center';
  static String Course= 'course';
  static String callUs= 'call_us';
  static String cancel= 'cancel';
  static String Continue= 'continue';

  static String downloads= 'downloads';
  static String dailyQuiz= 'daily_quiz';
  static String demo= 'demo';
  static String demo_classes= 'demo_classes';
  static String downloadVideo= 'download_video';
  static String DateofPurchase= 'date_of_purchase';


  static String graduation= 'graduation';

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
  static String enteryourage= 'enter_your_age';
  static String EnterApplycoupon= 'Enter_valid_coupon_apply';
  static String Email_Required= 'email_required';
  static String emailUs= 'email_us';


  static String freeCourses= 'free_courses';
  static String firstName= 'first_name';
  static String fresher= 'fresher';
  static String facingProblemInApplication= 'facing_problem_in_application';
  static String feedBack= 'feedback';

  static String hello= 'hello';
  static String home= 'home';
  static String homePage= 'home_page';
  static String help= 'help';
  static String helpAndFeedback= 'help_and_feedback';

  static String issueSubmittedSuccessfully= 'issue_submitted_successfully';
  static String itemType= 'item_type';
  static String inVoice= 'invoice';

  static String lastName= 'last_name';
  static String logOut= 'log_out';
  static String landmarkTehsil= 'landmark';
  static String languagePreferences= 'language_preferences';
  static String LearningClosetPvt= 'Learning Closet Pvt. Ltd. (Exampur)';
  static String LiveChat= 'live_chat';
  static String live= 'live';
  static String liveTest= 'live_test';

  static String paidCourse= 'paid_course';
  static String pleaseChooseTheCategory= 'please_choose_the_category';
  static String phoneNumber= 'phone_number';
  static String pinCode= 'pin_code';
  static String use_coupon= 'use_coupon';
  static String provideFurtherDetailsForDeliveryOfBooks= 'provide_further_details_for_delivery_of_books';
  static String preference= 'preference';
  static String PromoCode_REQUIRED= 'PromoCode_REQUIRED';
  static String pincode_REQUIRED= 'pincode_REQUIRED';
  static String paynow= 'pay_now';
  static String pleaseselectqualification= 'please_select_qualification';
  static String Postgraduation= 'post_graduation';
  static String PleaseSelectState= 'please_select_state';
  static String pleaseSelectAttemptHistory= 'please_select_attempt_history';
  static String pleaseEnterAge= 'please_enter_age';
  static String PaymentMode= 'payment_mode';
  static String priceBreakdown= 'price_breakdown';
  static String Price= 'price';
  static String Pricegst= 'price';
  static String placeOrder= 'place_order';
  static String PleaseletterPassword= 'please_letter_password';
  static String PleaseEnternewPassword= 'please_enter_new_password';
  static String PleasecurrentPassword= 'please_enter_current_password';
  static String Pleaseverifyyourphoneno = 'please_verify_your_phone_no.';
  static String PreviousYearPdf = 'previous_year_pdf';
  static String PracticeQuestion = 'practice_question';
  static String PrivacyPolicy = 'privacy_policy';
  static String pdf = 'pdf';
  static String pleaseChoosetoOpenpdf= 'please_choose_to_open_pdf';
  static String pdfViewer = 'pdf_viewer';

  static String name= 'name';
  static String newPassword= 'new_password';
  static String newBatch= 'new_batch';
  static String next= 'next';
  static String Name_Field_Required= 'name_field_required';
  static String noData= 'no_data';
  static String noLiveStreamPresent= 'no_live_stream_present';
  static String Normal= 'normal';

  static String testCourses= 'test_courses';
  static String TotalAmount= 'total_amount';
  static String TransactionReceipt= 'transaction_receipt';
  static String Thankyou= 'thank_you';
  static String TranscationId= 'transcation_id';
  static String TermsandConditions= 'Terms and Conditions.';
  static String ThisitemnonRefundable= 'This item is non-refundable.';
  static String TypeYourDoubtHere= 'type_your_doubt_here';
  static String ThisFileisAlreadyExist= 'this_file_is_already_exist';

  static String offlineBatches= 'offline_batches';
  static String OrderDate= 'order_date';

  static String jobAlerts= 'job_alerts';

  static String loading = 'loading';

  static String submitIssue= 'submit_issue';
  static String studyMaterials= 'study_materials';
  static String serverError= 'server_error';
  static String settings= 'settings';
  static String shareNow= 'share_now';
  static String selectCategories= 'select_categories';
  static String searchCategory= 'search_category';
  static String searchCourse= 'search_course';
  static String state= 'state';
  static String selectLanguage= 'select_language';
  static String security= 'security';
  static String saveProfile= 'save_profile';
  static String saveTheCourse= 'save_the_course';
  static String share= 'share';
  static String skip= 'skip';
  static String State_Required= 'state_REQUIRED';
  static String sellingPrice= 'selling_price';
  static String selectissue= 'select_issue';
  static String showless= 'show_less';
  static String showmore= 'show_more';
  static String StudentName= 'student_name';
  static String selectSubject= 'select_subject';
  static String selectChapter= 'select_chapter';
  static String Send= 'send';
  static String savedQuestion= 'saved_question';

  static String viewPdf= 'view_pdf';

  static String watchAppTutorial= 'watch_app_tutorial';
  static String writeAboutTheProblem= 'write_about_the_problem';
  static String watch= 'watch';

  static String myPurchase= 'my_purchase';
  static String myTimetable= 'my_timetable';
  static String myCourses= 'my_courses';

  static String rateUs= 'rate_us';
  static String recorded= 'recorded';
  static String repeater= 'repeater';

  static String general= 'general';

  static String userName= 'user_name';
  static String UpdatedSuccessfully= 'updated_successfully';
  static String upComing= 'upcoming';

  static String viewDetails= 'view_details';
  static String viewAll= 'view_all';
  static String view= 'view';
  static String viewInvoice= 'view_invoice';
  static String Validity= 'validity';

  static String qualification= 'qualification';
  static String Quizz= 'quizz';

}