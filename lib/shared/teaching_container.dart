import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class TeachingContainer extends StatefulWidget {
  PaidCourseData courseData;
  int courseType;
  String tabId;
  String tabName;
    TeachingContainer (this.courseData,this.courseType,this.tabId, this.tabName) : super();

  @override
  _TeachingContainerState createState() => _TeachingContainerState();
}

class _TeachingContainerState extends State<TeachingContainer> {
  String? deviceModel;
  String? deviceMake;
  String? deviceOS;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? versionName;
  String? versionCode;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getDeviceData();
    getAppVersionData();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              AppConstants.printLog("tapped");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all( Radius.circular(10),

                  ),
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: double.infinity,
                    child: widget.courseData.bannerPath.toString().contains('http') ?
                    AppConstants.image(widget.courseData.bannerPath.toString()) :
                    AppConstants.image(AppConstants.BANNER_BASE + widget.courseData.bannerPath.toString()),
                  ),
                ),

                Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.courseData.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                 Html(data:widget.courseData.description.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' '),style: {
                                        'body': Style(
                                            maxLines: 3,
                                            textOverflow: TextOverflow.ellipsis,
                                            fontSize: const FontSize(13),
                                        )})
                                ],
                              ),
                            ),

                            ClipOval(
                              child: Image.asset(
                               Images.exampur_logo,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),


                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [


                      Column(
                        children: [
                          CustomRoundButton(onPressed: (){
                            // List<String> courseIdList = [widget.courseData.id.toString(),widget.courseData.title.toString()];
                            // // courseIdList.add(widget.courseData.id.toString());
                            // widget.courseType==1?AppConstants.sendAnalyticsItemsDetails('Paid_Course_Details',courseIdList):null;

                            String courseTabType = 'Course';
                            if(widget.tabId=='combo_course'){
                              courseTabType = 'Combo';
                            }else{
                              courseTabType = 'Course';
                            }
                            widget.courseType==1?AppConstants.subscription(widget.courseData.id.toString().replaceAll(' ', '_')):'';
                            // widget.courseType==1?  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                            //     PaidCourseDetails(courseTabType, widget.courseData,widget.courseType)
                            // )): submitLog(context, widget.courseData.title.toString(), widget.courseData.id.toString());
                            // Navigator.push(context, MaterialPageRoute(builder: (_) =>
                            //     MyCourseTabView(widget.courseData.id.toString(),'','')
                            // ));
                            if(widget.courseType==1) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  PaidCourseDetails(courseTabType, widget.courseData,widget.courseType)
                              ));
                            } else {
                              AppConstants.printLog(widget.courseData.title.toString());
                              AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
                             submitLog(widget.courseData.title.toString(), widget.courseData.id.toString(), widget.tabName.toString());
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                  MyCourseTabView(widget.courseData.id.toString(),'','')
                              ));
                            }
                          },text: getTranslated(context, StringConstant.viewDetails)!,),

                          SizedBox(height: 10,),

                          widget.courseType==1? CustomRoundButton(onPressed: ()async{
                            await   FirebaseAnalytics.instance.logEvent(name:'Paid_Courdse_Details',parameters: {
                              'Course_id':widget.courseData.id.toString().replaceAll(' ', '_'),
                              'Course_title':widget.courseData.title.toString().replaceAll(' ', '_')
                            });
                            String courseTabType = 'Course';
                            if(widget.tabId=='combo_course'){
                              courseTabType = 'Combo';
                            }else{
                              courseTabType = 'Course';
                            }
                            widget.courseData.onEmi??false ?
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  PaidCourseDetails(courseTabType, widget.courseData,widget.courseType))
                            ) :
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  DeliveryDetailScreen(courseTabType, widget.courseData.id.toString(),
                                    widget.courseData.title.toString(), widget.courseData.salePrice.toString(),
                                      upsellBookList: widget.courseData.upsellBook??[]
                                  )
                              ),
                            );
                          },text: getTranslated(context, StringConstant.buyCourse)!):SizedBox(),

                          SizedBox(height: 10,),

                          Row(
                            children: [
                              Image.asset(Images.share,height: 18,width: 18,),
                              SizedBox(width: 5,),
                              InkWell(
                                onTap: () async {
                                  String courseTabType = '';
                                  if(widget.tabId=='combo_course'){
                                    courseTabType = 'combo';
                                  }else{
                                    courseTabType = 'courses';
                                  }

                                  String data = json.encode(widget.courseData);
                                  String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink(
                                      courseTabType, data.replaceAll('&', 'and'), widget.courseType.toString()
                                  );
                                  String shareContent =
                                      'Get "' + widget.courseData.title.toString() + '" Course from Exampur Now.\n' +
                                          dynamicUrl;
                                  Share.share(shareContent);
                                  // Share.share(dynamicUrl);
                                },
                                child: Text(getTranslated(context, StringConstant.share)!)
                              )
                            ],
                          ),

                          SizedBox(height: 15,),
                        ],
                      ),

                    ],),
                ),

              ],
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Future<void> submitLog(String courseName, String courseId, String tabName) async {
    // AppConstants.showLoaderDialog(context);
    var body = {
      "user":{
        "name":userName,
       // "id":'',
        "email":userEmail,
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
      "type":"free-course",
      "course":{
        "name":courseName,
        "id":courseId,
        "category":tabName,
      }
    };
    Map<String, String> header = {
      "x-auth-token": AppConstants.logToken,
      "Content-Type": "application/json"
    };
    await Service.post(API.log_free_course_view_detail, body: body, myHeader: header).then((response) {
      AppConstants.printLog(header);
      AppConstants.printLog(response.body);
      // if(response == null) {
      //   AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      // } else {
      //   if(response.statusCode == 200) {
      //     AppConstants.printLog(response.body);
      //   } else {
      //     AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
      //   }
      // }
    });
  }
}

class RowTile extends StatelessWidget {

  final String title;
  const RowTile({required this.title}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(children: [
        Icon(Icons.done,color: Colors.amber,),
        SizedBox(width: 5,),
        Text(title),


      ],),
    );
  }



}
class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 25, 25);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}