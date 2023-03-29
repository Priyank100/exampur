import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/rate_model.dart';
import 'package:exampur_mobile/data/model/rating_feedback_model.dart';
import 'package:exampur_mobile/presentation/widgets/rating_feedback.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:exampur_mobile/utils/app_colors.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog() : super();

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  List<Color> selectedColor = [
    AppColors.grey200,
    AppColors.grey200,
    AppColors.grey200,
    AppColors.grey200,
    AppColors.grey200
  ];
  List<RateModel> rateList = [];
  String? userName = '';
  String? userMobile = '';
  // String? userEmail = '';
  String deviceModel = '';
  String deviceMake = '';
  String deviceOS = '';
  String versionName = '';
  String versionCode = '';

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      this.setRating();
    });
    getUserData();
    getDeviceData();
    getAppVersionData();
  }

  void setRating() {
    rateList.add(RateModel(getTranslated(context, LangString.rating1)!, '5'));
    rateList.add(RateModel(getTranslated(context, LangString.rating2)!, '4'));
    rateList.add(RateModel(getTranslated(context, LangString.rating3)!, '3'));
    rateList.add(RateModel(getTranslated(context, LangString.rating4)!, '2'));
    rateList.add(RateModel(getTranslated(context, LangString.rating5)!, '1'));
  }

  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
  //  userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
      setState(() {});
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        submitRating('Cancel');
        return Future.value(true);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColors.amber, width: 5)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: IconButton(onPressed: (){
                Navigator.of(context).pop();
                submitRating('Cancel');
                },
                  icon: Icon(Icons.cancel_outlined)),
              alignment: Alignment.topRight,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(getTranslated(context, LangString.ratingTitle)!),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.8,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rateList.length,
                  itemBuilder: (context, index) {
                    return ratingButton(index);
                  }
              ),
            )
          ],
        )
      ),
    );
  }

  Widget ratingButton(int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          // Navigator.pop(context);
          setState(() {
            selectedColor[index] = AppColors.amber;
          });
          submitRating(rateList[index].rate);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppColors.amber),
              color: selectedColor[index]
          ),
          child: Text(rateList[index].title),
        ),
      ),
    );
  }

  Future<void> submitRating(String rate) async {
    var body = rate == 'Cancel' ?
    {
      "user":{
        "name":userName,
        // "email":userEmail,
        "email":userMobile! +'@nill.com',
        "mobile":userMobile
      },
      "device":{
        "model":deviceModel,
        "make":deviceMake,
        "os":deviceOS
      },
      "app":{
        "version_name":versionName,
        "version_code":versionCode
      },
      "type":"rating",
      "status":"cancelled",
    }:
    {
      "user":{
        "name":userName,
        // "email":userEmail,
        "email":userMobile !+'@nill.com',
        "mobile":userMobile
      },
      "device":{
        "model":deviceModel,
        "make":deviceMake,
        "os":deviceOS
      },
      "app":{
        "version_name":versionName,
        "version_code":versionCode
      },
      "type":"rating",
      "status":"rated",
      "rating":rate
    };
    Map<String, String> header = {
      "x-auth-token": AppConstants.serviceLogToken,
      "Content-Type": "application/json",
      "app-version":AppConstants.versionCode
    };
    await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((response) async {

      //save rating to show for next time
      RatingFeedbackModel model = RatingFeedbackModel(userName, rate, DateFormat('dd-MM-yyyy').format(DateTime.now()));
      await SharedPref.saveSharedPref(SharedPref.RATING, jsonEncode(model));

      if(response == null) {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);

      } else {
        if(response.statusCode == 200) {
          Navigator.pop(context);

          if(rate.toString() != 'Cancel') {
            if (int.parse(rate) > 3) {
              AppConstants.openPlayStore();

            } else {
              AppConstants.goTo(context,
                  RatingFeedback(
                      userName,
                      userMobile,
                      // userEmail,
                      deviceModel,
                      deviceMake,
                      deviceOS,
                      versionName,
                      versionCode
                  )
              );
            }
          }
        } else {
          AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
        }
      }
    });
  }
}
