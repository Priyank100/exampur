import 'dart:convert';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static String uriPrefix = 'https://exampurflutter.page.link';
  static String packageName = 'com.example.exampur_mobile';
  static int minVersion = 1;

  static Future<String> createDynamicLink(String data, String type) async {
    String _linkMessage;

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse(uriPrefix + '/courses?data=${data}&type=${type}'),
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
      final Uri? deepLink = dataLink?.link;
      var isCourse = deepLink!.pathSegments.contains('courses');
      if(isCourse) {
        if(deepLink!=null) {
          String? data = deepLink?.queryParameters['data'];
          String? type = deepLink?.queryParameters['type'];
          Courses courses = Courses.fromJson(json.decode(data!));
          return Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PaidCourseDetails(courses, int.parse(type.toString()))));
        } else {
          return null;
        }
      } else {
        return null;
      }
    }catch(e){
      AppConstants.printLog('link error');
      AppConstants.printLog(e.toString());
    }
  }

}