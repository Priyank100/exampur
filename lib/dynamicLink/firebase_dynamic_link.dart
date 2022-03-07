import 'dart:convert';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/presentation/home/exampurone2one/one2oneViedo.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

class FirebaseDynamicLinkService {
  static String uriPrefix = 'https://exampurapp.page.link';
  static String packageName = 'com.example.exampur_mobile';
  static int minVersion = 1;

  static Future<String> createDynamicLink(String dataType, String data, String courseType) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse(uriPrefix + '/${dataType}?data=${data}&type=${courseType}'),
        androidParameters: AndroidParameters(
        packageName: packageName,
        minimumVersion: minVersion,
        fallbackUrl: Uri.parse('https://www.exampur.com'),
      ),
      // iosParameters: IosParameters(
      //   bundleId: '',
      //   minimumVersion: '',
      //   appStoreId: '',
      //   fallbackUrl: Uri.parse('url')
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Exampur',
        imageUrl: Uri.parse('https://exampur.com/assets/images/logo/exampur-logo.png'),
        // description: 'Course',
      )
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

  static handleDeepLink(BuildContext context, PendingDynamicLinkData dataLink) {
    try{
      final Uri deepLink = dataLink.link;

      if(deepLink!=null) {
        String data = deepLink.queryParameters['data'].toString();
        var isCourses = deepLink.pathSegments.contains('courses');
        var isBooks = deepLink.pathSegments.contains('books');
        var isOne2One = deepLink.pathSegments.contains('one2one');

        int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : 0;

        switch(condition) {
          case 1:
            String type = deepLink.queryParameters['type'].toString();
            Courses courseData = Courses.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PaidCourseDetails(courseData, int.parse(type.toString()))));
          case 2:
            BookEbook bookData = BookEbook.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PlaceOrderScreen(bookData)));
          case 3:
            One2OneCourses one2OneData = One2OneCourses.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                One2OneVideo(one2OneData)));
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