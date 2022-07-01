import 'dart:async';
import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

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

  void _checkVersion() async {
    final newVersion = NewVersion(
       androidId: "com.edudrive.exampur",
    );
    try {
    final status = await newVersion.getVersionStatus();
    AppConstants.printLog(status!.storeVersion.toString());
    AppConstants.printLog(status.storeVersion.toString());

      await newVersion.getVersionStatus().then((status) {
        if (status == null
            || status.localVersion == status.storeVersion
            || getExtendedVersionNumber(status.localVersion) >=
                getExtendedVersionNumber(status.storeVersion)) {
          callProvider();
        } else {
          Widget cancelButton = TextButton(
            child: Text("Skip", style: TextStyle(color: AppColors.amber)),
            onPressed: () {
              Navigator.pop(context);
              callProvider();
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "Lets update", style: TextStyle(color: AppColors.amber),),
            onPressed: () {
              SystemNavigator.pop();
              LaunchReview.launch(androidAppId: AppConstants.androidId,
                  iOSAppId: AppConstants.iosId);
            },
          );
          AlertDialog alert = AlertDialog(
            title: Text("UPDATE!!!"),
            content: Text(
                "Please update the app from " + "${status.localVersion}" +
                    " to " + "${status.storeVersion}"),
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
                  onWillPop: () async {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    return true;
                  },
                  child: alert);
            },
          );
        }
      });
    } catch(e){
      callProvider();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Container(
       // padding: EdgeInsets.only(left: 60,right: 60,top: 30),
        height: double.infinity,
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
              Images.splash_img,
          ),
        ),
      ),
      // body: Container(
      //   //alignment: Alignment.center,
      //   width: MediaQuery.of(context).size.width,
      //     height: MediaQuery.of(context).size.height,
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage(Images.splash_img,),
      //         fit: BoxFit.scaleDown,
      //       ),
      //     ),
      //   child: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Padding(
      //       padding: const EdgeInsets.all(0),
      //       child: CircularProgressIndicator(),
      //     ),
      //   )
      // ),
    );
  }

  // Future<void> callProvider() async {
  //   await Provider.of<AuthProvider>(context, listen: false).getBannerBaseUrl(context).then((value) {
  //     checkSharedPrefToken();
  //   });
  // }
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

