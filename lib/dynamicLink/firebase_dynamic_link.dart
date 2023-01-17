import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/home/exampurone2one/one2oneViedo.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

import '../presentation/home/books/books_ebooks.dart';
import '../presentation/home/current_affairs_new/current_affairs_tab.dart';
import '../presentation/home/paid_courses/offline_courses.dart';
import '../presentation/home/paid_courses/paid_courses.dart';
import '../presentation/home/test_series_new/test_series_new.dart';

class FirebaseDynamicLinkService {
  static String uriPrefix = 'https://edudrive.page.link';
  // static String fallbackUrl = 'https://www.exampur.com';
  static String fallbackUrl = 'https://play.google.com/store/apps/details?id=com.edudrive.exampur';
  static String exampurTitle = 'Exampur';
  static String exampurLogo = 'https://exampur.com/assets/images/logo/exampur-logo.png';
  static int minVersion = 1;
  static String desktopBuy = 'https://buy.exampur.xyz/';

  static Future<String> createDynamicLink(String dataType, String data, String courseType, String id) async {
    String _linkMessage;
    String desktopCourseType = dataType == 'courses' ? 'buy-course' : dataType == 'combo' ? 'combo-course' : dataType == 'books' ? 'buy-book' : '';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        // link: Uri.parse(uriPrefix + '/?link=${fallbackUrl}&dataType=${dataType}&data=${data}&type=${courseType}&ofl=${fallbackUrl}'),
        link: Uri.parse(uriPrefix + '/?link=${desktopBuy+'$desktopCourseType/$id'}&dataType=${dataType}&data=${data}&type=${courseType}&ofl=${desktopBuy+'$desktopCourseType/$id'}'),
        androidParameters: AndroidParameters(
        packageName: AppConstants.androidId,
        minimumVersion: minVersion,
        fallbackUrl: Uri.parse(fallbackUrl),
      ),
      // iosParameters: IosParameters(
      //   bundleId: '',
      //   minimumVersion: '',
      //   appStoreId: '',
      //   fallbackUrl: Uri.parse('url')
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: exampurTitle,
        imageUrl: Uri.parse(exampurLogo),
        // description: 'Course',
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
    );
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    Uri url = shortLink.shortUrl;
    // Uri url = await parameters.buildUrl();
    _linkMessage = url.toString();
    return _linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          handleDeepLink(context, dynamicLink!);
        },
        onError: (OnLinkErrorException e) async{
          AppConstants.printLog('link error');
          AppConstants.printLog(e.message.toString());
        }
    );

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();

    handleDeepLink(context, data!);

  }

  static handleDeepLink(BuildContext context, PendingDynamicLinkData dataLink) async {
    try{
      final Uri deepLink = dataLink.link;

      if(deepLink!=null) {
        String data = deepLink.queryParameters['data'].toString();
        // var isCourses = deepLink.pathSegments.contains('courses');
        // var isBooks = deepLink.pathSegments.contains('books');
        // var isOne2One = deepLink.pathSegments.contains('one2one');
        // var isCombo = deepLink.pathSegments.contains('combo');
        String dataType = deepLink.queryParameters['dataType'].toString();

        var isCourses = dataType.contains('courses');
        var isBooks = dataType.contains('books');
        var isOne2One = dataType.contains('one2one');
        var isCombo = dataType.contains('combo');

        var isCurrentAffairs = dataType.contains('current-affair');
        var isLiveTest = dataType.contains('live-test');
        var isQuiz = dataType.contains('quiz');
        var isBookList = dataType.contains('book-list');
        var isOfflineCourses = dataType.contains('offline-course-list');
        var isPaidCourses = dataType.contains('paid-course-list');

        // int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : isCombo ? 4 : 0;

        int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : isCombo ? 4 :
                        isCurrentAffairs ? 5 : isLiveTest || isQuiz ? 6 : isBookList ? 7 :
                        isOfflineCourses ? 8 : isPaidCourses ? 9 : 0;


        switch(condition) {
          case 1:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            if(type == '1' || type == '2' || type == '3') {
              return Navigator.push(context, MaterialPageRoute(
                  settings:RouteSettings(name: 'Direct'+type),
                  builder: (context) =>
                  PaidCourseDetails('Course',courseData, int.parse(type.toString()))));
            } else {
              String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
              return Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  MyCourseTabView(courseData.id.toString(),courseData.title.toString(),courseData.testSeriesLink.toString().replaceAll('and', '&'),token)
              ));
            }

          case 2:
            BookEbook bookData = BookEbook.fromJson(json.decode(data));
            // bookData.title.
            return Navigator.push(context, MaterialPageRoute(
               // settings: RouteSettings(name: 'Direct'),
                builder: (context) =>
                PlaceOrderScreen(bookData)));

          case 3:
            One2OneCourses one2OneData = One2OneCourses.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                One2OneVideo(one2OneData)));

          case 4:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(
                settings: RouteSettings(name: 'Direct'),
                builder: (context) =>
                PaidCourseDetails('Combo',courseData, int.parse(type.toString()))));

          case 5:
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                CurrentAffairsTab()));

          case 6:
            String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
            String splitPart = isLiveTest ? 'test-link=' : 'quiz-link=';
            String testLink = deepLink.toString().split(splitPart)[1];
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                TestSeriesNew(testLink.replaceAll('%3D', '='), token)));

          case 7:
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                BooksEbook()));

          case 8:
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                OfflineCourse()));

          case 9:
            String categoryId = deepLink.queryParameters['category-id'].toString();
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PaidCourses(1, categoryId: categoryId)));

        }


      } else {
        return null;
      }
    } catch(e){
      AppConstants.printLog('link error');
      AppConstants.printLog(e.toString());
    }
  }

}