import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class TeachingContainer extends StatefulWidget {
  Courses courseData;
  int courseType;
  String tabId;
    TeachingContainer (this.courseData,this.courseType,this.tabId) : super();

  @override
  _TeachingContainerState createState() => _TeachingContainerState();
}

class _TeachingContainerState extends State<TeachingContainer> {

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
                    child: AppConstants.image(AppConstants.BANNER_BASE + widget.courseData.bannerPath.toString()),
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
                                  Container(
                                      height:100,
                                      child: Html(data:widget.courseData.description.toString())),
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

                            widget.courseType==1?  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                PaidCourseDetails(courseTabType, widget.courseData,widget.courseType)
                            )): Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                MyCourseTabView(widget.courseData.id.toString())
                            ))
                            ;
                          },text: getTranslated(context, 'view_details')!,),
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

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  DeliveryDetailScreen(courseTabType, widget.courseData.id.toString(),
                                    widget.courseData.title.toString(), widget.courseData.salePrice.toString(),
                                  )
                              ),
                            );


                          },text: getTranslated(context, 'buy_course')!,):SizedBox(),
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
                                child: Text(getTranslated(context, 'share')!)
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