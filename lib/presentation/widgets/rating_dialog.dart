import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/rate_model.dart';
import 'package:exampur_mobile/presentation/widgets/rating_feedback.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

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
  String userName = '';
  String userMobile = '';
  String userEmail = '';
  String deviceModel = '';
  String deviceMake = '';
  String deviceOS = '';
  String versionName = '';
  String versionCode = '';

  @override
  void initState() {
    setRating();
    getUserData();
    getDeviceData();
    getAppVersionData();
    super.initState();
  }

  void setRating() {
    rateList.add(RateModel('Extremely Happy', '5'));
    rateList.add(RateModel('Happy', '4'));
    rateList.add(RateModel('Neutral', '3'));
    rateList.add(RateModel('Dissatisfied', '2'));
    rateList.add(RateModel('Very Dissatisfied', '1'));
  }

  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
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
              child: Text('How happy are you with the app?'),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rateList.length,
                  itemBuilder: (context, index) {
                    return button(index);
                  }
              ),
            )
          ],
        )
      ),
    );
  }

  Widget button(int index) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
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
    AppConstants.showLoaderDialog(context);
    var body = {
      "user":{
        "name":userName,
        // "id":"users id",   // id not used
        "mobile":userMobile,
        "email":userEmail
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
      "status":rate == 'Cancel' ? "cancelled" : "rated",
      "rating":rate
    };
    await Service.post(API.submitRatingUrl, body: body).then((response) {
      Navigator.pop(context);
      if(response == null) {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      } else {
        if(response.statusCode == 200) {
          //get response
          if(int.parse(rate) < 3) {
            LaunchReview.launch(
                androidAppId: AppConstants.androidId,
                iOSAppId: AppConstants.iosId);
          } else {
            AppConstants.goTo(context,
                RatingFeedback(
                    userName, userMobile, userEmail,
                    deviceModel, deviceMake, deviceOS,
                    versionName, versionCode
                )
            );
          }
        } else {
          AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
        }
      }
    });
  }
}