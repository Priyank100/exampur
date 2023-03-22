import 'dart:async';
import 'dart:io';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/shared/maintenance_screen.dart';
import 'package:exampur_mobile/shared/update_screen.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int i = 0;
  List<String> loadingTextList = ['Loading Popular Courses', 'Loading Youtube Videos', 'Loading 1000+ Mock Tests'];
  String loadingText = 'Loading Popular Courses';
  Timer? timer;

  @override
  void initState() {
    AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.splashScreen);

    var map = {
      'Page_Name':'Splash_Screen'
    };
    AnalyticsConstants.firebaseEvent(AnalyticsConstants.splashScreenNew, map);

    Map<String, Object> stuff = {};
    AnalyticsConstants.logEvent(AnalyticsConstants.splashScreen,stuff);
    AnalyticsConstants.initAppFlyer();
     // AnalyticsConstants.moEngageInitialize(context);
    checkInternet();
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      loadingText = loadingTextList[i];
      i == 2 ? i = 0 : i++;
      setState((){});
    });
  }

  Future<void> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _checkVersion();
      } else {
        openDownloadPage();
      }
    } on SocketException catch (_) {
      openDownloadPage();
    }
  }

  void openDownloadPage() {
    Timer(Duration(seconds: 3), () {
      AppConstants.goAndReplace(context, Downloads(0));
    });
  }

  Future<void> _checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConstants.versionName = packageInfo.version;
    AppConstants.versionCode = packageInfo.buildNumber;
    await UpgradeAlert().upgrader.initialize().then((value) async {
      // String deviceVersion = UpgradeAlert().upgrader.currentInstalledVersion().toString();
      // String storeVersion = UpgradeAlert().upgrader.currentAppStoreVersion().toString();
      bool isUpdateAvailable = UpgradeAlert().upgrader.isUpdateAvailable();
      if(isUpdateAvailable) {
        await SharedPref.clearSharedPref(SharedPref.SIGNUP_TIME_Count);
        AppConstants.showUpdateAlert(
            context,
            "New version of this application is available now. So update the application first",
                () {
              callProvider();
            }
        );
      } else {
        callProvider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                Images.splash_img,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: 150),
              child: Column(
                children: [
                  Text(loadingText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      color: Colors.red,
                      backgroundColor: Colors.red[200],
                      // value: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> callProvider() async {
    AppConstants.subscription('ALL');
    checkSharedPrefToken();
  }

  Future<void> checkSharedPrefToken() async {
    await SharedPref.getSharedPref(SharedPref.TOKEN).then((value) {
      AppConstants.printLog('TOKEN>> $value');
      validateToken(value);
    });
  }

  Future validateToken(token) async {
    if(token != null && token.toString() != 'null') {
      Timer(Duration(seconds: 1), () => Provider.of<AuthProvider>(context, listen: false).tokenValidation(context, token));

    } else {
      Timer(Duration(seconds: 1), () => Provider.of<AuthProvider>(context, listen: false).userConfig(context));
      // Timer(Duration(seconds: 3),
      //         ()=>Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder:
      //             (context) =>
      //             LandingPage()
      //         )
      //     )
      // );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

}

