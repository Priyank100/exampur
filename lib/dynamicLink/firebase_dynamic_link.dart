import 'dart:convert';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/home/exampurone2one/one2oneViedo.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';

class FirebaseDynamicLinkService {
  static String uriPrefix = 'https://edudrive.page.link';
  static String fallbackUrl = 'https://www.exampur.com';
  static String exampurTitle = 'Exampur';
  static String exampurLogo = 'https://exampur.com/assets/images/logo/exampur-logo.png';
  static int minVersion = 1;

  static Future<String> createDynamicLink(String dataType, String data, String courseType) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse(uriPrefix + '/${dataType}?data=${data}&type=${courseType}'),
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
        var isCombo = deepLink.pathSegments.contains('combo');

        int condition = isCourses ? 1 : isBooks ? 2 : isOne2One ? 3 : isCombo ? 4 : 0;

        switch(condition) {
          case 1:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            if(type == '1') {
              return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  PaidCourseDetails('Course',courseData, int.parse(type.toString()))));
            } else {
              return Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  MyCourseTabView(courseData.id.toString(),'','')
              ));
            }
          case 2:
            BookEbook bookData = BookEbook.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PlaceOrderScreen(bookData)));
          case 3:
            One2OneCourses one2OneData = One2OneCourses.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                One2OneVideo(one2OneData)));
          case 4:
            String type = deepLink.queryParameters['type'].toString();
            PaidCourseData courseData = PaidCourseData.fromJson(json.decode(data));
            return Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PaidCourseDetails('Combo',courseData, int.parse(type.toString()))));
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