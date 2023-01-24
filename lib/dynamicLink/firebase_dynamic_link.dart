import 'dart:convert';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/home/exampurone2one/one2oneViedo.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

import '../presentation/home/books/books_ebooks.dart';
import '../presentation/home/current_affairs_new/current_affairs_tab.dart';
import '../presentation/home/home.dart';
import '../presentation/home/paid_courses/offline_courses.dart';
import '../presentation/home/paid_courses/paid_courses.dart';
import '../presentation/home/study_material_new/study_material_new.dart';
import '../presentation/home/test_series_new/test_series_new.dart';
import '../presentation/my_courses/TeacherSubjectView/DownloadPdfView.dart';
import '../presentation/my_courses/TeacherSubjectView/material_video.dart';
import '../presentation/my_courses/Timeline/TimeTableVideo.dart';

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
        String dataType = deepLink.queryParameters['dataType'].toString();

        var isCourses = dataType.contains('courses');
        var isBooks = dataType.contains('books');
        var isOne2One = dataType.contains('one2one');
        var isCombo = dataType.contains('combo');

        var isCurrentAffairs = dataType == 'current-affair';
        var isLiveTest = dataType == 'live-test';
        var isQuiz = dataType == 'quiz';
        var isBookList = dataType == 'book-list';
        var isEBookList = dataType == 'ebook-list';
        var isOfflineCourses = dataType == 'offline-course-list';
        var isPaidCourses = dataType == 'paid-course-list';
        var isRecordedVideo = dataType == 'recorded-video';
        var isLiveVideo = dataType == 'live-videoooooooooooooooooo';
        var isPdf = dataType == 'pdf';
        var isPreviousYearPdf = dataType == 'previous-year';
        var isCheckout = dataType == 'checkout';

        // int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : isCombo ? 4 : 0;

        int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : isCombo ? 4 : isCurrentAffairs ? 5 :
                        isLiveTest || isQuiz ? 6 : isBookList ? 7 : isEBookList ? 8 : isOfflineCourses ? 9 :
                        isPaidCourses ? 10 : isRecordedVideo ? 11 : isLiveVideo ? 12 : isPdf ? 13 :
                        isPreviousYearPdf ? 14 : isCheckout ? 15 : 0;


        switch(condition) {
          case 1:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            if(type == '1' || type == '2' || type == '3') {
              return Navigator.push(context, MaterialPageRoute(
                  settings:RouteSettings(name: 'Direct'+type),
                  builder: (context) =>
                      PaidCourseDetails('Course',courseData, int.parse(type.toString()))
              ));
            } else {
              String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
              return Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                      MyCourseTabView(courseData.id.toString(),courseData.title.toString(),courseData.testSeriesLink.toString().replaceAll('and', '&'),token)
              ));
            }

          case 2:
            BookEbook bookData = BookEbook.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(
               // settings: RouteSettings(name: 'Direct'),
                builder: (context) =>
                    PlaceOrderScreen(bookData)
            ));

          case 3:
            One2OneCourses one2OneData = One2OneCourses.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    One2OneVideo(one2OneData)
            ));

          case 4:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(
                settings: RouteSettings(name: 'Direct'),
                builder: (context) =>
                    PaidCourseDetails('Combo',courseData, int.parse(type.toString()))
            ));

          case 5:
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    CurrentAffairsTab()
            ));

          case 6:
            String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
            String splitPart = isLiveTest ? 'test-link=' : 'quiz-link=';
            String testLink = deepLink.toString().split(splitPart)[1];
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    TestSeriesNew(testLink.replaceAll('%3D', '='), token)
            ));

          case 7:
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    BooksEbook(bookEbookTab: 0)
            ));

          case 8:
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    BooksEbook(bookEbookTab: 1)
            ));

          case 9:
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    OfflineCourse()
            ));

          case 10:
            String categoryId = deepLink.queryParameters['category-id'].toString();
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    PaidCourses(1, categoryId: categoryId)
            ));

          case 11:
            String title = deepLink.queryParameters['title'].toString();
            String vid = deepLink.queryParameters['vid'].toString();
            bool contentLog = deepLink.queryParameters['contentLog'].toString().toLowerCase()=='true'?true:false;
            String url = deepLink.queryParameters['url'].toString();
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    MyMaterialVideo(url,title,'',vid,contentLog)
            ));

          case 12:
            // String url = deepLink.queryParameters['url'].toString();
            // String title = deepLink.queryParameters['title'].toString();
            // String vid = deepLink.queryParameters['vid'].toString();
            // return Navigator.push(context, MaterialPageRoute(
            //     builder: (context) =>
            //         MyTimeTableViedo(url, title, vid)
            // ));

          case 13:
            String title = deepLink.queryParameters['title'].toString();
            String url = deepLink.queryParameters['url'].toString();
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    DownloadViewPdf(title, url)
            ));

          case 14:
            String tabId = deepLink.queryParameters['tab-id'].toString();
            return Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    StudyMaterialNew(1,tabId: tabId)
            ));

          case 15:
            String courseId = deepLink.queryParameters['course-id'].toString();
            AnalyticsConstants.checkOutPageApi(context, courseId);
        }

      } else {
        return null;
      }
    } catch(e){
      AppConstants.printLog('<<dynamic link error>>');
      AppConstants.printLog(e.toString());
    }
  }

}