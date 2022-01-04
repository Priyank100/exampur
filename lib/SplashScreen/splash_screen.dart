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
    checkSharedPrefToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.splash_img),
              fit: BoxFit.fill,
            ),
          ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: CircularProgressIndicator(),
          ),
        )
      ),
    );
  }


  Future<void> checkSharedPrefToken() async {
    await SharedPref.getSharedPref(AppConstants.TOKEN).then((value) => {
      AppConstants.printLog('TOKEN>> $value'),
      validateToken(value)
    });
  }

  Future validateToken(token) async {
    if(token != null && token.toString() != 'null') {
      // Timer(Duration(seconds: 1), ()=> Provider.of<ValidTokenProvider>(context, listen: false).tokenValidation(context)
     Timer(Duration(seconds: 1), ()=> Provider.of<AuthProvider>(context, listen: false).tokenValidation(context));
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
