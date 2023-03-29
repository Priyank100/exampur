import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:launch_review/launch_review.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import '../Localization/language_constrants.dart';
import '../SharePref/shared_pref.dart';
import '../data/model/DoubtCourseIdModel.dart';
import '../data/model/OfflineCounselingModel.dart';
import '../presentation/widgets/rating_dialog.dart';
import 'app_colors.dart';
import 'images.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'lang_string.dart';

class Keys {
  // static const String Rozar_pay_key = 'rzp_test_tnxy74fGchHvRY';
  // static const String Rozar_pay_key = 'rzp_test_0ltpDbPIMUqirI';
  static const String Razar_pay_key = 'rzp_live_2OGpV3khEWcs8M';
}

class AppConstants {
  static bool isPrint       = false;
  static bool isotpverify   = false;
  static String langCode    = 'en';
  static String filePath    = 'storage/emulated/0/Download/Exampur';
  static String downloadMag = 'Download has been started. View your file in the download section of your phone or on the app in the "Download" section. Touch outside to close the pop-up. Your file is getting downloaded in the background.';
  static String BANNER_BASE = '';
  static String YOUTUBE_IMG = 'https://img.youtube.com/vi/VIDEO_ID/mqdefault.jpg';

  // static String defaultCountry = 'India';
  static String defaultCountry = 'Nill';
  static String defaultCity = 'Nill';
  static String defaultState = 'Nill';

  static String Mobile_number = '9873111552';
  static String offline_call  = '9054993549';
  static String Email_id      = 'help@exampur.com';
  static String Email_sub     = 'Feedback';
  static String playStoreAppUrl = 'https://play.google.com/store/apps/details?id=com.edudrive.exampur';
  static String androidId     = 'com.edudrive.exampur';
  static String iosId         = '';

  static String versionName = '';
  static String versionCode = '';
  static String deviceModel = '';
  static String deviceMake = '';
  static String deviceOS = '';


  static String myCourseName = '';
  static String myCourseId = '';
  static String timlineName = '';
  static String timlineId = '';

  static String shareAppContent = 'Hey check out EXAMPUR App at: ' + playStoreAppUrl;
  // static String googleFeedbackFormUrl = 'https://docs.google.com/forms/d/e/1FAIpQLScCCm43CYzI4C0h4HgFCg5XB5dYa0my6q8rDif8IR_3RGuACQ/viewform';
  static String googleFeedbackFormUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSdnU2iboo0rPFiVBWcJZYHXSlIJeDZqiye8D2IqGjvZjrOMdA/viewform?usp=pp_url&entry.43008044=USER_NAME&entry.2068509611=USER_MOBILE';

  static List<String> selectedCategoryList = [];
  static List<String> selectedCategoryNameList = [];

  static int homeIndex = 0;


  static List<String> contentLogList = [];
  static List<Course> doubtCourseIdList = [];
  static List<CounselingCourse> offlineCounselingIdList = [];
  static List<String> titlesave = [];

  // static String currentAffairesId = '61efe9771dbf84752e750373';
  // static String studyMaterialsId = '61efe9921dbf84752e750384';
  // static String currentAffairesId = '6225f4b40536af56be90ed66';
  // static String studyMaterialsId = '6225f4540536af56be90ed28';
  static String currentAffairesId = 'CURRENTAFFAIR';
  static String studyMaterialsId = 'STUDYMATERIALS';

  static String testSeriesToken = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2MjI4NjZiNTI2M2JjZDU5NGNlYjQ2OTEiLCJpYXQiOjE2NDY4MTQ5ODIsImV4cCI6MTY0NjkwMTM4Mn0.nC3XmvNX2Y_hKsiF1ZARgaMrWMVJ2w80AFyAKT0mLsA';

  static String CATEGORY_LENGTH       = '0';

  static String serviceLogToken = 'QhmAn5x6UxxWVdc8pkEe77eDAH9U2U9sXjs4kqaxbT2vp5kVmfru5nLL2nEpSQm9dBHLFBeQuEcXmmpzcf34MetTuNXBbaLTuG7pETEGQ2Hp';


  // for moengage ------------------------------------
  static String userName = '';
  static String userMobile = '';
 // static String Email = '';
  static String Id = '';
  static String courseName = '';
  static String subjectId = '';
  static String subjectName = '';
  static String chapterName = '';
  static String paidTabName = '';
  static String videoQuality = '';
  static String currentindex = '';
  static int mycourseType = 0;
  static String routeName = '';
  static String videoId = '';
  static int teacherRatingType = 0;

  static String channelname = '';
  static String coursename = '';
  static String playlistname = '';
  // static List<String> selectedCategoryName = [];

  //=========================================================


  //========================================webviewcallwithnative=================================//
  static const platform = const MethodChannel('flutter.native/helper');




  //==============================Constant Methods===================================================//

  static void printLog(message) {
    if (isPrint) {
      print(message);
    }
  }

  static Future<void> makeCallEmail(String url) async {
    UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
    if (!await launcher.launch(
      url,
      useSafariVC: false,
      useWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      universalLinksOnly: false,
      headers: <String, String>{},
    )) {
      throw 'Could not launch $url';
    }
  }

  static void openPlayStore() {
    LaunchReview.launch(androidAppId: AppConstants.androidId, iOSAppId: AppConstants.iosId);
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

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM
    );
  }

  static void showAlertDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          child: Text(getTranslated(context, LangString.cancel)!,style: TextStyle(color: AppColors.amber)),
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

  static void showAlertDialogOkButton(BuildContext context,String header, String message,Function function) {
    AlertDialog alert = AlertDialog(
      actions: [
        Center(
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width/2,
            color: AppColors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Text('OK',style: TextStyle(color: AppColors.white)),
            onPressed:  () {
              function();
            },
          ),
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
                    child: Text(header, style: TextStyle(fontSize: 16))),
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
      child: Text(getTranslated(context, LangString.cancel)!,style: TextStyle(color: AppColors.amber)),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(getTranslated(context, LangString.Continue)!,style: TextStyle(color: AppColors.amber),),
      onPressed:  () {
        function();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(getTranslated(context, LangString.Alert)!),
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

  static void showAlertDialogWithYesBack(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      actions: [
        TextButton(
          child: Text('Close',style: TextStyle(color: AppColors.amber)),
          onPressed:  () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('Cancel',style: TextStyle(color: AppColors.amber)),
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
    var userValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    String userName = userValue[0]['data']['first_name'].toString();

    var ratingValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.RATING));
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

  static void showUpdateAlert(BuildContext context, String message, Function skipCall) {
    Widget cancelButton = TextButton(
      child: Text('Skip',style: TextStyle(color: AppColors.amber)),
      onPressed:  () {
        Navigator.pop(context);
        skipCall();
      },
    );
    Widget continueButton = TextButton(
      child: Text('UPDATE NOW',style: TextStyle(color: AppColors.amber),),
      onPressed:  () {
        AppConstants.openPlayStore();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Update'),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: alert,
            onWillPop: () async {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              return true;
            });
      },
    );
  }

  static int unlockItem(int listLength) {
    double unlock = (30 / 100) * listLength;
    int num = unlock.round();
    return num;
  }

  static String customRound(double val) {
    num mod = pow(10.0, 2);
    return ((val * mod).round().toDouble() / mod).toStringAsFixed(2);
  }

  static String timeRound(){
    DateTime now = DateTime.now();
    String   formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);
     return formattedDate;
  }
}