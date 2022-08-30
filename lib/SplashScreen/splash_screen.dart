import 'dart:async';
import 'dart:io';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    AnalyticsConstants.sendAnalyticsEvent(AnalyticsConstants.splashScreen);
    Map<String, Object> stuff = {};
    AnalyticsConstants.logEvent(AnalyticsConstants.splashScreen,stuff);
    AnalyticsConstants.initAppFlyer();
    checkInternet();
    super.initState();
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
    await UpgradeAlert().upgrader.initialize().then((value) async {
      // String deviceVersion = UpgradeAlert().upgrader.currentInstalledVersion().toString();
      // String storeVersion = UpgradeAlert().upgrader.currentAppStoreVersion().toString();
      bool isUpdateAvailable = UpgradeAlert().upgrader.isUpdateAvailable();
      if(isUpdateAvailable) {
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
      body:  Container(
        height: double.infinity,
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            Images.splash_img,
          ),
        ),
      ),
    );
  }

  Future<void> callProvider() async {
    AppConstants.subscription('ALL');
    checkSharedPrefToken();
  }

  Future<void> checkSharedPrefToken() async {
    await SharedPref.getSharedPref(SharedPrefConstants.TOKEN).then((value) {
      AppConstants.printLog('TOKEN>> $value');
      validateToken(value);
    });
  }

  Future validateToken(token) async {
    if(token != null && token.toString() != 'null') {
      // Timer(Duration(seconds: 1), ()=> Provider.of<ValidTokenProvider>(context, listen: false).tokenValidation(context)
      Timer(Duration(seconds: 1), () => Provider.of<AuthProvider>(context, listen: false).tokenValidation(context, token));
      //  Timer(Duration(seconds: 3),
      //          ()=>Navigator.pushReplacement(context,
      //          MaterialPageRoute(builder:
      //              (context) =>
      //              BottomNavigation()
      //          )
      //      )
      //  );

    } else {
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  LandingPage()
              )
          )
      );
    }
  }

  int getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }

}

