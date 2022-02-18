import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paidcoursedetails.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class TeachingContainer extends StatefulWidget {
  final Courses courseData;
  int courseType;
    TeachingContainer (this.courseData,this.courseType) : super();

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
                    // bottomRight: Radius.circular(20),
                    // bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: double.infinity,
                    // child: CachedNetworkImage(
                    //   imageUrl: AppConstants.BANNER_BASE + widget.courseData.bannerPath.toString(),
                    //   placeholder: (context, url) => new Image.asset(Images.noimage),
                    //   errorWidget: (context, url, error) => new Icon(Icons.error),
                    // ),
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
                                  Text(
                                    widget.courseData.description.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            // ClipOval(
                            //   clipper: MyClip(),
                            //   child: FadeInImage.assetNetwork(
                            //     placeholder: Images.noimage,
                            //     image: widget.paidcourseList[widget.index].logoPath.toString(),
                            //
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
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
                      // Expanded(
                      //   child: ListView.builder(
                      //       itemCount: 4,
                      //       shrinkWrap: true,
                      //       itemBuilder: (BuildContext context,int index){
                      //         return Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 children: [
                      //                   RowTile(title: 'jhgcf', ),
                      //
                      //                 ],
                      //               );
                      //   }),
                      // ),

                      Column(
                        children: [
                          InkWell(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                PaidCourseDetails(widget.courseData,widget.courseType)
                            ));
                          },
                            child: Container(height: 30,width: 120,decoration: BoxDecoration( color: Color(0xFF060929),
                              borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, 'view_details')!,style: TextStyle(color: Colors.white)))),
                          ),
                          SizedBox(height: 10,),
                          widget.courseType==1?     InkWell(
                            onTap: (){
                              showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (context) =>
                                  BottomSheeet1(widget.courseData));
                            },
                            child: Container(height: 30,width: 110,decoration: BoxDecoration( color: Color(0xFF060929),
                                borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, 'buy_course')!,style: TextStyle(color: Colors.white)))),
                          ):SizedBox(),

                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset(Images.share,height: 18,width: 18,),
                              SizedBox(width: 5,),
                              InkWell(
                                onTap: () async {
                                  String data = json.encode(widget.courseData);
                                  String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink(
                                      'courses', data, widget.courseType.toString()
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
                // Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(10),
                //           bottomRight: Radius.circular(10)),
                //       color: Theme.of(context).primaryColor,
                //     ),
                //     height: 40,
                //     child: Center(child: Text("Watch Now")))
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