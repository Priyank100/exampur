import 'dart:convert';
import 'dart:ui';

import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../Localization/language_constrants.dart';
import '../../../data/model/free_video_content_model.dart';
import '../../../provider/FreeVideoProvider.dart';
import '../../../utils/analytics_constants.dart';
import '../../../utils/api.dart';
import '../../../utils/appBar.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/images.dart';
import '../../../utils/lang_string.dart';
import '../../DeliveryDetail/delivery_detail_screen.dart';
import '../../my_courses/TeacherSubjectView/DownloadPdfView.dart';
import '../../widgets/Custom_toogle_button.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_round_button.dart';
import '../banner_link_detail_page.dart';

class FreeVideoDetail extends StatefulWidget {
  final bool tab;
  String playListID;
  String videoId;
  String courseName;
  String courseId;
   FreeVideoDetail(this.tab,this.playListID,this.videoId,this.courseName,this.courseId,{Key? key}) : super(key: key);

  @override
  State<FreeVideoDetail> createState() => _FreeVideoDetailState();
}

class _FreeVideoDetailState extends State<FreeVideoDetail> {
  String videoId = '';
 static String SalePrice = '';
 static String title = '';
 static String type = '';
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;
  bool activeButton = false;

  FreeVideoPlayListModel ? freeVideoPlayListModel;
  bool isLoading = true;


  Future<void> getFreePlayList() async {
    videoId = widget.videoId;
   // playlistName = widget.playlistName!;
    checkOutPagePriceApi(context,widget.courseId.toString());

    freeVideoPlayListModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoPlayList(context, widget.playListID))!;

   // videoId = widget.videoId.isEmpty ? freeVideoPlayListModel!.videos![0].videoUrl.toString() : widget.videoId;
    isLoading = false;
    setState((){});
  }
  @override
  void initState() {
    var map = {
      'Page_Name':'Free Videos',
      'Mobile_Number':AppConstants.userMobile,
      'Language':'en',
      'video name':AppConstants.playlistname,
      'course id':widget.courseId
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Youtube_video_play, map);
    getFreePlayList().then((value) =>
    // String videoId = (YoutubePlayer.convertUrlToId('y8wae3aVr7k') == null)
    //     ? "errorstring"
    //     : YoutubePlayer.convertUrlToId('')!;

    _controller = YoutubePlayerController(
      initialVideoId:videoId , //widget.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        enableCaption: true,
        hideThumbnail: true,
      ),
    )..addListener(listener));

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    activeButton = widget.tab;
    super.initState();
  }
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }
  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Scaffold(body:Center(child: CircularProgressIndicator(),)): YoutubePlayerBuilder(
        player: YoutubePlayer(
        //aspectRatio: 19 / 9,
        controller: _controller,
        // showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
        //todo: change video quality
        ],
        onReady: () {
      _isPlayerReady = true;
    },
    ),
    builder: (context, player) => Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar:CustomAppBar(),
      body: Column(children: [
        player,
     Expanded(child:   SingleChildScrollView(
       physics:ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          // child: Container(
          //  // color: Colors.grey.shade200,
          //   color: Colors.blue,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ToggleButton(widget.tab, this.chatPressed, this.playlistPressed),
              ),
              activeButton ? PlaylistList():PaidCourseData()
            ],),
         // ),
        ))

      ],),
      bottomNavigationBar: Container(
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //     color: Colors.amber.shade200,
            //     alignment: Alignment.center,
            //     padding: EdgeInsets.all(8),
            //     margin: EdgeInsets.only(bottom: 5),
            //     child: Text('*आप 50% छूट पाने के लिए EXAMPUR10 कूपन का उपयोग कर सकते हैं|',style: TextStyle(fontSize: 12),)),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.black,
                borderRadius: BorderRadius.circular(15)
              ),
              child:
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Text(widget.courseName,style: TextStyle(fontSize: 15,color: Colors.white),),
              SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    Text('\u{20B9} '+SalePrice,style: TextStyle(fontSize:20,color: Colors.white)),
                  ]),
              )
                     ],),
                   ) ,
                    InkWell(
                      onTap: (){
                        _controller.pause();
                        var map = {
                          'Page_Name':'Free Videos',
                          'Mobile_Number':AppConstants.userMobile,
                          'Language':'en',
                          'video name':AppConstants.playlistname,
                          'course id':widget.courseId,
                          'course name':widget.courseName,
                          'channel name': AppConstants.channelname
                        };
                        AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_buy_now, map);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) =>
                                DeliveryDetailScreen(
                                    type,widget.courseId,title,SalePrice
                                )));
                       // AppConstants.goTo(context, BannerLinkDetailPage('Course',widget.courseId));
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(getTranslated(context, LangString.buyCourse)!,style: TextStyle(color: Colors.white)),),
                    )
                  ],),
            )

          ],
        ),)

    ));
  }
  Widget PlaylistList(){
    return Container(
      //color: Colors.amber,
     height: 380,
     // margin: EdgeInsets.only(bottom: 100),
      padding: EdgeInsets.only(bottom: 50),
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
         itemCount: freeVideoPlayListModel!.videos!.length,
          itemBuilder: (context, index){
        return freeVideoPlayListModel!.videos!.length == 0 ? AppConstants.noDataFound()
            :InkWell(
          onTap: (){
            _controller.pause();
            var map = {
              'Page_Name':'Free Videos',
              'Mobile_Number':AppConstants.userMobile,
              'Language':'en',
              'playlist name':freeVideoPlayListModel!.videos![index].title.toString(),
            };
            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Playlist_click, map);
            // print('>>>>>>>>>>>>>>>>');
            // videoId = freeVideoPlayListModel!.videos![index].videoUrl.toString();
            // print(videoId);
            AppConstants.playlistname = freeVideoPlayListModel!.videos![index].title.toString();
            AppConstants.goAndReplace(context, FreeVideoDetail(true, widget.playListID,freeVideoPlayListModel!.videos![index].videoUrl.toString(),widget.courseName,widget.courseId,));
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(12)),
              boxShadow:  [
                BoxShadow(
                  color: AppColors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                ),
              ],
              color: AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              // Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white
              //     ),
              //     width: 150,
              //     height: 95,
              //     // child: Image.network(API.homeBanner_URL + widget.listData.imagePath.toString(), fit: BoxFit.fill)
              //     child: AppConstants.image(AppConstants.YOUTUBE_IMG.replaceAll('VIDEO_ID', freeVideoPlayListModel!.videos![index].videoUrl.toString()), boxfit: BoxFit.fill)
              // ),
              SizedBox(
                height: 95,
                width: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: AppConstants.image(AppConstants.YOUTUBE_IMG.replaceAll('VIDEO_ID', freeVideoPlayListModel!.videos![index].videoUrl.toString()), boxfit: BoxFit.fill),

                    ),
                     Container(
                        alignment: Alignment.center,
                        child: Image.asset(Images.youtubeImg,height: 90,width: 45,)
                    )
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Flexible(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                //  SizedBox(height: 10,),
                  freeVideoPlayListModel!.videos![index].title.toString().trim().isEmpty || freeVideoPlayListModel!.videos![index].title == 'null'? SizedBox():  Text(freeVideoPlayListModel!.videos![index].title.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),maxLines: 3, overflow: TextOverflow.ellipsis,),
                 SizedBox(height: 35,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(child:
                      freeVideoPlayListModel!.name.toString().trim().isEmpty || freeVideoPlayListModel!.name == 'null'? SizedBox()  :Text(freeVideoPlayListModel!.name.toString(),style: TextStyle(color: Colors.red),maxLines: 1, overflow: TextOverflow.ellipsis,)
                      ),
                      SizedBox(width: 5,),
                      freeVideoPlayListModel!.videos![index].pdfUrl.toString().trim().isEmpty ||  freeVideoPlayListModel!.videos![index].pdfUrl == 'null'? SizedBox():       InkWell(
                        onTap: (){
                          var map = {
                            'Page_Name':'Free Videos',
                            'Mobile_Number':AppConstants.userMobile,
                            'Language':'en',
                            'video name':AppConstants.playlistname,
                            'course id':widget.courseId,
                            'course name':widget.courseName,
                            'channel name': AppConstants.channelname
                          };
                          AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.view_youtube_pdf, map);
  AppConstants.goTo(context, DownloadViewPdf(freeVideoPlayListModel!.videos![index].pdfUrl.toString(), freeVideoPlayListModel!.videos![index].pdfUrl.toString()));
                        },
                        child: Container(
                          height: 30,
                          width: 86,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.red),
                          child: Center(child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Text(getTranslated(context, LangString.viewPdf)!,style: TextStyle(color: Colors.white,fontFamily: 'Noto Sans',fontSize: 12),),
                            Icon(Icons.arrow_drop_down,color: Colors.white,size: 16,)

                          ],)),
                        ),
                      )
                    ],
                  ),
                 // SizedBox(height: 10,)
                ],))
            ],)
          ),
        );
      }),
    );
  }
  Widget PaidCourseData(){
    return  Container(
      height: 305,
      child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index){
              return  Container(
                // height: 370,
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
                  width:MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  // margin: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
                  // color: Colors.red,
                  child: Container(
                    // height: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),),

                    child: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all( Radius.circular(10),

                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              )),
                          width: double.infinity,
                          child: AppConstants.image(AppConstants.YOUTUBE_IMG.replaceAll('VIDEO_ID', widget.videoId),height:150.0,boxfit: BoxFit.fill),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.courseName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18),
                                  ),
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
                        padding: const EdgeInsets.only(top: 8,right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomRoundButton(
                                onPressed: ()async{
                                  _controller.pause();
                                  var map = {
                                    'Page_Name':'Free Videos',
                                    'Mobile_Number':AppConstants.userMobile,
                                    'Language':'en',
                                    'video name':AppConstants.playlistname,
                                    'course id':widget.courseId,
                                    'course name':widget.courseName,
                                    'channel name': AppConstants.channelname
                                  };
                                  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_course_detail, map);
                                  AppConstants.goTo(context, BannerLinkDetailPage('Course',widget.courseId));
                                },
                                text:getTranslated(context, LangString.viewDetails)!
                            ),
                          ],
                        ),
                      ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomRoundButton(
                    onPressed: ()async{
                      _controller.pause();
                      var map = {
                        'Page_Name':'Free Videos',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':'en',
                        'video name':AppConstants.playlistname,
                        'course id':widget.courseId,
                        'course name':widget.courseName,
                        'channel name': AppConstants.channelname
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_buy_now, map);
                     // checkOutPageApi(context,widget.courseId);
                      Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) =>
                                          DeliveryDetailScreen(
                                              type,widget.courseId,title,SalePrice
                                          )));
                    },
                        text:getTranslated(context, LangString.buyCourse)!
                    ),
                  ],
                ),
              ),

                      // InkWell(
                      //   onTap: (){
                      //     _controller.pause();
                      //     var map = {
                      //       'Page_Name':'Free Videos',
                      //       'Mobile_Number':AppConstants.userMobile,
                      //       'Language':'en',
                      //       'video name':AppConstants.playlistname,
                      //       'course id':widget.courseId,
                      //       'course name':widget.courseName,
                      //       'channel name': AppConstants.channelname
                      //     };
                      //     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_buy_now, map);
                      //     checkOutPageApi(context,widget.courseId);
                      //   },
                      //   child: Container(
                      //       height: 50,
                      //       width: 200,
                      //       margin: EdgeInsets.only(top: 20,bottom: 8),
                      //       decoration: BoxDecoration(
                      //           color: Colors.amber,
                      //           borderRadius: BorderRadius.circular(8)
                      //       ),
                      //       alignment: Alignment.center,
                      //       child: Text('Buy Now',style: TextStyle(color: Colors.white),)),
                      // ),
                    ],),
                  )
              );
            }
      ),
    );
  }
  // Widget chatData(){
  //   return SingleChildScrollView(
  //     child: Container(
  //      // height: 370,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(15),
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: AppColors.grey.withOpacity(0.5),
  //               spreadRadius: 3,
  //               blurRadius: 5,
  //               offset: Offset(0, 3), // changes position of shadow
  //             ),
  //           ],
  //           color: Theme.of(context).backgroundColor,
  //         ),
  //       width:MediaQuery.of(context).size.width,
  //       alignment: Alignment.center,
  //        margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
  //        // margin: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
  //      // color: Colors.red,
  //       child: Container(
  //          // height: 270,
  //          decoration: BoxDecoration(
  //            color: Colors.white,
  //          borderRadius: BorderRadius.all(
  //     Radius.circular(15),
  //     ),),
  //
  //           child: Column(children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.all( Radius.circular(10),
  //
  //               ),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.all(
  //                       Radius.circular(10),
  //                     )),
  //                 width: double.infinity,
  //                 child: AppConstants.image(AppConstants.YOUTUBE_IMG.replaceAll('VIDEO_ID', widget.videoId),boxfit: BoxFit.fill),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Flexible(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           widget.courseName,
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(fontSize: 18),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //
  //                   ClipOval(
  //                     child: Image.asset(
  //                       Images.exampur_logo,
  //                       height: 50,
  //                       width: 50,
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //             InkWell(
  //               onTap: (){
  //                 _controller.pause();
  //                 var map = {
  //                   'Page_Name':'Free Videos',
  //                   'Mobile_Number':AppConstants.userMobile,
  //                   'Language':'en',
  //                   'video name':AppConstants.playlistname,
  //                   'course id':widget.courseId,
  //                   'course name':widget.courseName,
  //                   'channel name': AppConstants.channelname
  //                 };
  //                 AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.YouTube_buy_now, map);
  //                 checkOutPageApi(context,widget.courseId);
  //               },
  //               child: Container(
  //                   height: 50,
  //                   width: 200,
  //                   margin: EdgeInsets.only(top: 20,bottom: 8),
  //                   decoration: BoxDecoration(
  //                       color: Colors.amber,
  //                       borderRadius: BorderRadius.circular(8)
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Text('Buy Now',style: TextStyle(color: Colors.white),)),
  //             ),
  //           ],),
  //         )
  //     ),
  //   );
  // }

  void chatPressed() {
    setState((){
      activeButton = false;
    });
  }

  void playlistPressed() {
    setState((){
      activeButton = true;
    });
  }
  // static Future<void> checkOutPageApi(BuildContext context,String courseID) async {
  //   await Service.get(API.checkoutUrl.replaceAll('courseID', courseID)).then((response) {
  //     AppConstants.printLog(response.body.toString());
  //     if(response != null && response.statusCode == 200) {
  //       var jsonObject = jsonDecode(response.body);
  //       if (jsonObject['statusCode'].toString() == '200') {
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (_) =>
  //                 DeliveryDetailScreen(
  //                     jsonObject['data']['type'],courseID,jsonObject['data']['title'],jsonObject['data']['sale_price'].toString()
  //                 )));
  //       }
  //     }
  //     else {
  //       AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
  //     }
  //   });
  // }
  static Future<void> checkOutPagePriceApi(BuildContext context,String courseID) async {
    await Service.get(API.checkoutUrl.replaceAll('courseID', courseID)).then((response) {
      AppConstants.printLog(response.body.toString());
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject['statusCode'].toString() == '200') {
          SalePrice  = jsonObject['data']['sale_price'].toString();
          title  = jsonObject['data']['title'].toString();
          type  = jsonObject['data']['type'].toString();
        }
      }
      else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      }
    });
  }
}
