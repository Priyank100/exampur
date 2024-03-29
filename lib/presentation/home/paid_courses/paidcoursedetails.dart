import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/offline_courses.dart';
import 'package:exampur_mobile/presentation/home/paid_courses/paid_courses.dart';
import 'package:exampur_mobile/presentation/my_course_new/mycourse_tab.dart';
import 'package:exampur_mobile/presentation/my_courses/myCoursetabview.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/delivery_detail_screen_param.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PaidCourseDetails extends StatefulWidget {
  String courseTabType;
  final PaidCourseData courseData;
  int courseType;
  PaidCourseDetails(this.courseTabType,this.courseData,this.courseType) : super();

  @override
  _PaidCourseDetailsState createState() => _PaidCourseDetailsState();
}

class _PaidCourseDetailsState extends State<PaidCourseDetails> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
 // late YoutubeQualityChangeCallback qualityChangeCallback;
  //String? defaultQuality='';
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;


  bool _muted = false;
  bool _isPlayerReady = false;
  String message = '';
  int counter = 0;
  int temp = 0;

  String selectedEmiPlans = '';

  void addListData(){
    if(AppConstants.titlesave.length <= 10 && !AppConstants.titlesave.contains(widget.courseData.title.toString())){
      AppConstants.titlesave.add(widget.courseData.title.toString());
   // print('>>>>>>>>>>>>>>>>>>');
   // print(AppConstants.titlesave);
    }
  }

  @override
  void initState() {
  //  addListData();
    Future.delayed(Duration.zero, () {
      AppConstants.routeName = ModalRoute.of(context)!.settings.name!;
      var map = {
        'Page_Name':'Course_Details',
        'Course_Category':AppConstants.paidTabName,
        'Course_Name':widget.courseData.title.toString(),
        'Mobile_Number':AppConstants.userMobile,
        'Language':AppConstants.langCode,
        'User_ID':AppConstants.userMobile,
        'Video_Name':widget.courseData.title.toString(),
        'Path_name':ModalRoute.of(context)!.settings.name
      };
      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Watch_Now,map);
    });
    Future.delayed(Duration.zero, () {
      AppConstants.routeName = ModalRoute.of(context)!.settings.name!;
    var map = {
      'Page_Name':'Course_Details',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.courseData.title.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Path_name':ModalRoute.of(context)!.settings.name
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Course_Detail_page,map);});

    // AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    AppConstants.printLog(widget.courseData.videoPath.toString());
    message = AppConstants.langCode == 'hi' ? LangString.preBookTextHi : LangString.preBookTextEng;
    String videoId = (YoutubePlayer.convertUrlToId(widget.courseData.videoPath.toString()) == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId(widget.courseData.videoPath.toString())!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId, //widget.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        //forceHD: widget.fullHD ??= false,
        enableCaption: true,
        hideThumbnail: true,
      ),
    )..addListener(listener);

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
      if(_controller!.value.position.inSeconds != temp && _controller!.value.isPlaying ){
        counter++;
        temp = _controller!.value.position.inSeconds;
      }

    }
  }



  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    var backbutton = {
      'Page_Name':'Course_Details',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.courseData.title.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Path_name':AppConstants.routeName
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Course_Details_Page,backbutton);
    // var map = {
    //   'Page_Name':'Course_Details',
    //   'Course_Category':AppConstants.paidTabName,
    //   'Course_Name':widget.courseData.title.toString(),
    //   'Mobile_Number':AppConstants.userMobile,
    //   'Language':AppConstants.langCode,
    //   'User_ID':AppConstants.userMobile,
    //   'Total_Watch_Time':counter,
    //   'Path_name':AppConstants.routeName
    // };
    // AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Stop_Video,map);
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    // var d = Duration(seconds: _controller.value.position.inSeconds);
    // var min = d.inMinutes;
    // var sec = _controller.value.position.inSeconds % 60;
    // var m = '$min'.padLeft(2,'0');
    // var s = '$sec'.padLeft(2,'0');
    super.dispose();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    var dispose = {
      'Page_Name':'Course_Details',
      'Course_Name':widget.courseData.title.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Total_Watch_Time':counter,
      'Path_name':AppConstants.routeName
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Stop_Video,dispose);

    if(AppConstants.routeName == 'Direct1') {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PaidCourses(1)
      ));
    } else if(AppConstants.routeName == 'Direct2') {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => OfflineCourse()
        ));
    } else{
    Navigator.pop(context);
  }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          //aspectRatio: 19 / 9,
          controller: _controller,
          // showVideoProgressIndicator: false,
          progressIndicatorColor: Colors.blueAccent,
          topActions: <Widget>[
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),
        builder: (context, player) => Scaffold(
          appBar:CustomAppBar(),
          body: Column(
            children: [
              player,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(widget.courseData.title.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.courseData.validTime == null || widget.courseData.validTime == 'null' ? SizedBox() :
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: Text(getTranslated(context, LangString.Validity)!+' :  '+widget.courseData.validTime.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children:[
                          widget.courseData.purchase == true ? SizedBox() :   Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: InkWell(
                              onTap: () async {
                                _controller.pause();
                                AnalyticsConstants.moengagePlugin.setUserAttribute('Demo_Course', widget.courseData.title);
                                AppConstants.mycourseType = 2;
                                var analytics = {
                                  'Page_Name':'Course_Details',
                                  'Course_Category':AppConstants.paidTabName,
                                  'Course_Name':widget.courseData.title.toString(),
                                  'Mobile_Number':AppConstants.userMobile,
                                  'Language':AppConstants.langCode,
                                  'User_ID':AppConstants.userMobile,
                                };
                                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_View_Demo,analytics);

                                Map<String, dynamic> map = {
                                  "courseTabType": widget.courseTabType.toString(),
                                  "id": widget.courseData.id.toString(),
                                  "title": widget.courseData.title.toString(),
                                  "salePrice": widget.courseData.salePrice.toString(),
                                  "upsellBookList": widget.courseData.upsellBook??[],
                                  "selectedEmiPlan": selectedEmiPlans,
                                  "preBooktype": widget.courseData.status,
                                  "preBookDetail": widget.courseData.preBookDetail
                                };
                                SamplingBottomSheetParam.setDeliveryDetailParam = map;

                                List<String> samplingFeaturesList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getSamplingFeaturesList(context, widget.courseData.id.toString()))!;
                                SamplingBottomSheetParam.setFeaturesList = samplingFeaturesList;
                                String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
                                AppConstants.myCourseName = widget.courseData.title.toString();
                                AppConstants.myCourseId= widget.courseData.id.toString();
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                MyCourseTab(widget.courseData.id.toString(),widget.courseData.title.toString(),widget.courseData.testSeriesLink.toString(),token)
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                width: Dimensions.DailyMonthlyViewBtnWidth,
                                height: Dimensions.DailyMonthlyViewBtnHeight,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                   // border: Border.all(color: AppColors.black),
                                    color: AppColors.amber
                                ),
                                child: Text('View Demo', style: TextStyle(color:AppColors.white, fontSize: 10)),
                              ),
                            ),
                          ),
                          widget.courseData.pdfPath==null || widget.courseData.pdfPath=='null' || widget.courseData.pdfPath!.isEmpty ? SizedBox():
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                            child: InkWell(
                              onTap: (){
                                var map = {
                                  'Page_Name':'Course_Details',
                                  'Course_Category':AppConstants.paidTabName,
                                  'Course_Name':widget.courseData.title.toString(),
                                  'Mobile_Number':AppConstants.userMobile,
                                  'Language':AppConstants.langCode,
                                  'User_ID':AppConstants.userMobile,
                                  'Path_name':ModalRoute.of(context)!.settings.name
                                };
                                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_View_PDF,map);
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                widget.courseData.pdfPath.toString().contains('http') ?
                                ViewPdf(widget.courseData.pdfPath.toString(),'') :
                                ViewPdf(AppConstants.BANNER_BASE + widget.courseData.pdfPath.toString(),'')
                                ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                width: Dimensions.DailyMonthlyViewBtnWidth,
                                height: Dimensions.DailyMonthlyViewBtnHeight,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    color: AppColors.red
                                ),
                                child: Text(getTranslated(context, LangString.viewPdf)!, style: TextStyle(color:AppColors.white, fontSize: 10)),
                              ),
                            ),
                          )])
                        ],
                      ),
                      widget.courseType==1 || widget.courseType==2 || widget.courseType==3?  Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              '\u{20B9}',
                              style: TextStyle(color: AppColors.black, fontSize: 15),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.courseData.regularPrice.toString(),
                              style: TextStyle(color: AppColors.grey, fontSize: 15,decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              widget.courseData.salePrice.toString(),
                              style: TextStyle(color: AppColors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ):SizedBox(),
                      Html(data:widget.courseData.description.toString(), style: {
                        "body": Style(
                           padding: EdgeInsets.zero,
                            fontSize: FontSize(12.0),
                          fontFamily: 'Noto Sans'
                          //fontWeight: FontWeight.bold,
                        ),
                      },)
                    ],
                  )
                ),
              )
            ],
          ),
          bottomNavigationBar: Container(
            child: widget.courseType==1 || widget.courseType==2 || widget.courseType==3 ?
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    selectedEmiPlans.isEmpty?
                    SizedBox():
                    Row(
                      children: [
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    child: Text('Emi Plan : ' + selectedEmiPlans)
                                ),
                            ),
                        IconButton(
                            onPressed: (){
                              setState(() {
                                selectedEmiPlans = '';
                              });
                            },
                            icon: Icon(Icons.cancel_outlined)
                        )
                      ],
                    ),
                    widget.courseData.emiPLans!=null && widget.courseData.emiPLans!.length > 0 ?
                    InkWell(
                      onTap: () {
                        _controller.pause();
                        showBottomSheetEmiPlans();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        height: 40,
                        margin: EdgeInsets.fromLTRB(10,10,10,0),
                        child: Center(
                            child: Text(
                              'Check EMI Option',
                              style: TextStyle(color: AppColors.white, fontSize: 18),
                            )),
                      ),
                    ):SizedBox(),
                    // widget.courseData.purchase == true ? SizedBox() :
                    // InkWell(
                    //   onTap: () async {
                    //     _controller.pause();
                    //     AppConstants.mycourseType = 2;
                    //
                    //     var analytics = {
                    //       'Page_Name':'Course_Details',
                    //       'Course_Category':AppConstants.paidTabName,
                    //       'Course_Name':widget.courseData.title.toString(),
                    //       'Mobile_Number':AppConstants.userMobile,
                    //       'Language':AppConstants.langCode,
                    //       'User_ID':AppConstants.userMobile,
                    //     };
                    //     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_View_Demo,analytics);
                    //
                    //     Map<String, dynamic> map = {
                    //       "courseTabType": widget.courseTabType.toString(),
                    //       "id": widget.courseData.id.toString(),
                    //       "title": widget.courseData.title.toString(),
                    //       "salePrice": widget.courseData.salePrice.toString(),
                    //       "upsellBookList": widget.courseData.upsellBook??[],
                    //       "selectedEmiPlan": selectedEmiPlans,
                    //       "preBooktype": widget.courseData.status,
                    //       "preBookDetail": widget.courseData.preBookDetail
                    //     };
                    //     SamplingBottomSheetParam.setDeliveryDetailParam = map;
                    //
                    //     List<String> samplingFeaturesList = (await Provider.of<NewMyCourseProvider>(context, listen: false).getSamplingFeaturesList(context, widget.courseData.id.toString()))!;
                    //     SamplingBottomSheetParam.setFeaturesList = samplingFeaturesList;
                    //     String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
                    //     Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    //         MyCourseTab(widget.courseData.id.toString(),widget.courseData.title.toString(),widget.courseData.testSeriesLink.toString(),token)
                    //     ));
                    //   },
                    //   child: Container(
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         color: AppColors.amber,
                    //         borderRadius: BorderRadius.all(Radius.circular(10))),
                    //     height: 40,
                    //     margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    //     child: Center(
                    //         child: Text(
                    //           'View Demo',
                    //           style: TextStyle(color: AppColors.white, fontSize: 16),
                    //         )),
                    //   )
                    // ),

               widget.courseType == 2 ?
               InkWell(onTap: (){
                 var map = {
                   'Page_Name':'Course_Details',
                   'Course_Category':AppConstants.paidTabName,
                   'Course_Name':widget.courseData.title.toString(),
                   'Mobile_Number':AppConstants.userMobile,
                   'Language':AppConstants.langCode,
                   'User_ID':AppConstants.userMobile,
                   'Path_name':ModalRoute.of(context)!.settings.name
                 };
                 AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Offline_call_us,map);
                 AppConstants.makeCallEmail('tel:'+AppConstants.offline_call);
               },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        height: 40,
                        margin: EdgeInsets.only(left: 8,right: 8,top: 5),
                        child: Center(
                            child: Text(
                              'Call Us',
                              style: TextStyle(color: AppColors.white, fontSize:  widget.courseData.status == 'Published'?16: 12),
                            )
                        ),
                      ),
                    ):SizedBox(),
                    widget.courseData.purchase == true ? AlreadyPurchasedBtn() :
                    InkWell(
                      onTap: () {
                        _controller.pause();
                        AnalyticsConstants.moengagePlugin.setUserAttribute('Buy_Course', widget.courseData.title);
                        // var dispose = {
                        //   'Page_Name':'Course_Details',
                        //   'Course_Name':widget.courseData.title.toString(),
                        //   'Mobile_Number':AppConstants.userMobile,
                        //   'Language':AppConstants.langCode,
                        //   'User_ID':AppConstants.userMobile,
                        //   'Total_Watch_Time':counter,
                        //   'Path_name':AppConstants.routeName
                        // };
                        // AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Stop_Video,dispose);
                        var map = {
                          'Page_Name':'Course_Details',
                          'Course_Category':AppConstants.paidTabName,
                          'Course_Name':widget.courseData.title.toString(),
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':AppConstants.langCode,
                          'User_ID':AppConstants.userMobile,
                          'Path_name':ModalRoute.of(context)!.settings.name
                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Buy_Course,map);
                        AnalyticsConstants.firebaseEvent(AnalyticsConstants.buyCourse2Click, map);

                        FirebaseAnalytics.instance.logEvent(name: 'Buy_Course',parameters: {
                          'Course_Id':widget.courseData.id.toString(),
                          'Course_Name':widget.courseData.title.toString()
                        });
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            DeliveryDetailScreen(widget.courseTabType, widget.courseData.id.toString(),
                                widget.courseData.title.toString(), widget.courseData.salePrice.toString(),
                                upsellBookList: widget.courseData.upsellBook??[], emiPlan: selectedEmiPlans,
                              pre_booktype:widget.courseData.status,preBookDetail:widget.courseData.preBookDetail
                            )
                        ));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        height: 40,
                        margin: EdgeInsets.all(10),
                        child: Center(
                            child: Text(
                              widget.courseData.status == 'Published'?
                              getTranslated(context, LangString.buyCourse)!:message.replaceAll('X', widget.courseData.preBookDetail!.percentOff.toString()),
                              style: TextStyle(color: AppColors.white, fontSize:  widget.courseData.status == 'Published'?16: 12),
                            )
                        ),
                      ),
                    )
                  ],
                ) : SizedBox()
          ),
        ),
      ),
    );
  }

  Widget AlreadyPurchasedBtn() {
    return InkWell(
      onTap: () async {
        _controller.pause();
        String token = await SharedPref.getSharedPref(SharedPref.TOKEN);
        var map = {
          'Page_Name':'Course_Details',
          'Course_Category':AppConstants.paidTabName,
          'Course_Name':widget.courseData.title.toString(),
          'Mobile_Number':AppConstants.userMobile,
          'Language':AppConstants.langCode,
          'User_ID':AppConstants.userMobile,
        };
        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Buy_Course,map);
        FirebaseAnalytics.instance.logEvent(name: 'Buy_Course',parameters: {
          'Course_Id':widget.courseData.id.toString(),
          'Course_Name':widget.courseData.title.toString()
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            MyCourseTabView(
                widget.courseData.id.toString(),
                widget.courseData.title.toString(),
                widget.courseData.testSeriesLink.toString(),
                token
            )
        ));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.amber,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 40,
        margin: EdgeInsets.all(10),
        child: Center(
            child: Text(getTranslated(context,LangString.view)!, style: TextStyle(color: AppColors.white))
        ),
      ),
    );
  }

  void showBottomSheetEmiPlans() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Choose your plan'),
            ),
            Divider(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.courseData.emiPLans!.length,
                itemBuilder: (context, index) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter state){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            state((){
                              onChanged(index);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  (index+1).toString() + '. ' +
                                  widget.courseData.emiPLans![index].title.toString() +
                                  ' (₹' + widget.courseData.emiPLans![index].costPerEmi.toString() + ' per EMI)'
                              )
                          ),
                        )
                      ],
                    );
                  });
                }
            ),
          ],
        );
      }
    );
  }

  void onChanged(val) {
    selectedEmiPlans = widget.courseData.emiPLans![val].title.toString();
    setState(() {
    });
  }

}

