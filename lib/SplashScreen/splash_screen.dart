import 'dart:async';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen() : super();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    AppConstants.sendAnalyticsEvent('Splash_Screen');
    callProvider();
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

  Future<void> callProvider() async {
    await Provider.of<AuthProvider>(context, listen: false).getBannerBaseUrl(context).then((value) {
      checkSharedPrefToken();
    });
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
     Timer(Duration(seconds: 1), ()=> Provider.of<AuthProvider>(context, listen: false).tokenValidation(context, token));
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

}
