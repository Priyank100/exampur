import 'package:exampur_mobile/presentation/home/BannerBookDetailPage.dart';
import 'package:exampur_mobile/presentation/home/banner_link_detail_page.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../SharePref/shared_pref.dart';
import '../../presentation/home/test_series_new/test_series_new.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? route) async{
      AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>anchal');
      AppConstants.printLog(route.toString());
      var token = await SharedPref.getSharedPref(SharedPref.TOKEN);
      if(route != null){
        List<String> actiondata =route.split("/");

        if(actiondata[0] == "Course"){
          AppConstants.goTo(context,
              BannerLinkDetailPage('Course', actiondata[1],
              ));

        }else if(actiondata[0] == "Combo Course"){
          AppConstants.goTo(context,
              BannerLinkDetailPage('Combo Course',actiondata[1],
              ));
        }
        else if(actiondata[0] == "Book"){
          AppConstants.goTo(context,   BannerLinkBookDetailPage('Book', actiondata[1],

          ));
        }
        else if (actiondata[0] == "youtube") {
          AppConstants.makeCallEmail("${actiondata[1]}");

        // } else if(actiondata[0] == "testseries") {
        //   AppConstants.goTo(context, TestSeriesNew(actiondata.sublist(1).join('/').trim(), token));

        }else if(actiondata[0] == "https:"){
          AppConstants.makeCallEmail(route);
        }
      }
    });
  }

  static void display(RemoteMessage message) async {

    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "exampur",
            "exampur channel",
            importance: Importance.max,
            priority: Priority.high,
          )
      );


      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["action"],
      );
    } on Exception catch (e) {
      AppConstants.printLog(e.toString());
    }
  }
}