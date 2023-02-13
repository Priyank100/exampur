import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/FirestoreDB/firestore_db.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/analytics_constants.dart';
import '../../widgets/custom_rateTeacherBottomsheet.dart';

class MyTimeTableViedo extends StatefulWidget {
String url;
String title;
String videoId;
  MyTimeTableViedo(this.url,this.title,this.videoId) : super();

  @override
  _MyTimeTableViedoState createState() => _MyTimeTableViedoState();
}

class _MyTimeTableViedoState extends State<MyTimeTableViedo> {
  String userName = '';
  String userPhone = '';
  String videoTitle = '';
  TextEditingController _sendchat = TextEditingController();
  Map<String, dynamic> map = Map();
  FlickManager? flickManager;
  late VideoPlayerController _videoPlayerController;
  bool teacherRating = false;

  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(
        await SharedPref.getSharedPref(SharedPref.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    userPhone = jsonValue[0]['data']['phone'].toString();
    // markAttendance();
    FirestoreDB.markAttendance(widget.videoId, userName, userPhone);
    teacherRating = await SharedPref.getSharedPref(widget.videoId) == 'null' ? false : true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // initializePlayer();
    // getChat();
    getSharedPrefData();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    flickManager = FlickManager(
      videoPlayerController: _videoPlayerController,
    );
    var map = {
      'Page_Name':'My_Courses_Timeline',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Name':AppConstants.courseName,
      'Faculty_Name':AppConstants.subjectName.toString(),
      'Topic_Name':widget.title.toString(),
      'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
    };

   AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Watch_Now,map);
    // videoPlayerController = VideoPlayerController.network(widget.url);
    // chewieController = ChewieController(
    //   cupertinoProgressColors: ChewieProgressColors(),
    //   videoPlayerController: videoPlayerController,
    //     aspectRatio: 16/9,
    //   autoPlay: true,
    //   looping: true,
    //     errorBuilder: (context, errorMessage) {
    //       return Center(
    //         child: Text("Video unavanilable",style: TextStyle(color: AppColors.white),),
    //       );
    //     });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics:ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (MediaQuery.of(context).size.width)/16*9,
              child: FlickVideoPlayer(
                flickManager: flickManager!,
                flickVideoWithControls: const FlickVideoWithControls(
               controls: const FlickPortraitControls(isLive: true),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(widget.title,style: TextStyle(fontSize: 15),),
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, LangString.LiveChat)!,style: TextStyle(fontSize: 18)),
                  teacherRating ? SizedBox() : InkWell(
                    onTap: (){
                      AppConstants.videoId = widget.videoId;
                      AppConstants.teacherRatingType = 0;
                      var map = {
                        'Page_Name':'Recorded_Video',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'User_ID':AppConstants.userMobile,
                        "topic":widget.title.toString(),
                        "class type":"live"
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_class_feedback, map);
                     RateTeacherBottom.rateTeacherBottomSheet(context, this.refresh);
                    },
                    child: Container
                      (
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      alignment: Alignment.center,
                      child: Text(getTranslated(context, LangString.ratethisteacher)!,style: TextStyle(color: Colors.white),),),
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
            Container(
              height: MediaQuery.of(context).size.height*0.43,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: StreamBuilder(
                stream: FirestoreDB.getChat(widget.videoId),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: streamSnapshot.data == null ? 0 : streamSnapshot.data!.docs.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      DateTime dt = (streamSnapshot.data!.docs[index]['createdAt']).toDate();
                      return Column(
                        children: <Widget>[
                          Container(
                              child:Padding(
                                padding: const EdgeInsets.only(left: 12,top: 5,right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        new Text(streamSnapshot.data!.docs[index]['user'],style: TextStyle(fontSize: 12,color: AppColors.green),),
                                        new Text(DateFormat('hh:mm a').format(dt),style: TextStyle(color: AppColors.grey,fontSize: 12),),
                                      ],
                                    ),
                                    Text(streamSnapshot.data!.docs[index]['message'],style: TextStyle(fontSize: 14))
                                  ],),
                              )
                          ),
                          new Divider(),
                        ],
                      );
                    }
                  );
                },
              )
            )
          ],
        ),
      ),
        bottomNavigationBar: Container(
          padding: MediaQuery.of(context).viewInsets,
          color: AppColors.transparent,
          child:  Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: getTranslated(context, LangString.TypeYourDoubtHere)!,
                  controller: _sendchat,
                  value: (value) {}),
              ),
              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if(_sendchat.text.trim().toString().isNotEmpty) {
                    FirestoreDB.sendMessage(widget.videoId, userName, userPhone,
                        _sendchat.text.trim().toString());
                    _sendchat.text = '';
                    setState(() {});
                  } else {
                    AppConstants.showBottomMessage(context, 'Enter message', AppColors.black);
                  }
                },
                child: Container(
                  // padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(color: AppColors.amber,borderRadius:  BorderRadius.all(const Radius.circular(8))),
                    child: Center(child: Text(getTranslated(context, LangString.Send)!,style: TextStyle(color: AppColors.white)))
                ),
              )
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    var d = Duration(seconds: _videoPlayerController.value.position.inSeconds);
    var min = d.inMinutes;
    var sec = _videoPlayerController.value.position.inSeconds % 60;
    var m = '$min'.padLeft(2,'0');
    var s = '$sec'.padLeft(2,'0');
    var map = {
      'Page_Name':'My_Courses_Timeline',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Name':AppConstants.courseName,
      'Topic_Name':widget.title.toString(),
      'Video_Quality':AppConstants.videoQuality.toString(),
      'Total_Watch_Time':_videoPlayerController.value.position.inSeconds,
      'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : 'Free_Course'
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Stop_Live_Video,map);
    super.dispose();
  }

  Future<void> refresh() async {
    teacherRating = await SharedPref.getSharedPref(widget.videoId) == 'null' ? false : true;
    setState((){});
  }
}


