import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/my_course_notification_model.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyCourseNotifications extends StatefulWidget {
  final String courseId;
  MyCourseNotifications(this.courseId) ;


  @override
  _MyCourseNotificationsState createState() => _MyCourseNotificationsState();
}

class _MyCourseNotificationsState extends State<MyCourseNotifications> {
  List<NotificationData> myCourseNotificationList = [];
  bool isLoading = false;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    isLoading = true;
   // String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
    myCourseNotificationList = (await Provider.of<MyCourseProvider>(context, listen: false).getMyCourseNotificationList(context, widget.courseId))!;
    isLoading = false;
    setState(() {}
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body:isLoading?Center(child: LoadingIndicator(context)):myCourseNotificationList.length ==0?AppConstants.noDataFound() :ListView.separated(
                  itemCount:myCourseNotificationList.length ,
                  padding: EdgeInsets.all(8),

                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                        //leading: Image.asset(Images.exampur_logo,height: 70,width: 70,),
                      leading: myCourseNotificationList[index].imagePath.toString().contains('http') ?
                      AppConstants.image(myCourseNotificationList[index].imagePath.toString(),height: 90.0,width: 110.0) :
                      AppConstants.image(AppConstants.BANNER_BASE + myCourseNotificationList[index].imagePath.toString(),height: 90.0,width: 110.0),
                        title:Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(myCourseNotificationList[index].title.toString(),style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold)),
                           SizedBox(height: 10,),
                         myCourseNotificationList[index].action.toString().isEmpty?SizedBox():   Container(
                              width: Dimensions.AppTutorialImageHeight,
                              height: 25,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:AppColors.dark),
                              child: MaterialButton(

                                child: Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: AppColors.white,size: 10,),
                                    Text(getTranslated(context, LangString.watch)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white))
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => YoutubeVideo(myCourseNotificationList[index].action.toString(),
                                              myCourseNotificationList[index].title.toString())
                                      )
                                  );
                                },
                              ),
                            ),
                          ],)
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10,),
                      child: Divider(thickness: 1,),
                    );
                  },
                )

    );
  }
}
