import 'dart:convert';
import 'dart:io';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/downloads/pdf_downloads.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PaidCourseDetails extends StatefulWidget {
  final Courses courseData;
  int courseType;
  PaidCourseDetails(this.courseData,this.courseType) : super();

  @override
  _PaidCourseDetailsState createState() => _PaidCourseDetailsState();
}

class _PaidCourseDetailsState extends State<PaidCourseDetails> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _muted = false;
  bool _isPlayerReady = false;

  // String pdfLink = 'https://www.learningcontainer.com/download/sample-pdf-file-for-testing/?wpdmdl=1566&amp;refresh=621508d3713281645545683';
  // String pdfName = 'my_first_pdf';
  String videoLink = 'https://rr4---sn-qxoedn7z.googlevideo.com/videoplayback?expire=1647436896&ei=AJAxYrSSJ6aKir4PjfKAuAU&ip=64.145.93.28&id=o-AIOf30mWS6a-aMMzDS3DYYsKUzHaUamWNTBiW7d6A9ku&itag=22&source=youtube&requiressl=yes&mh=cE&mm=31%2C26&mn=sn-qxoedn7z%2Csn-tt1eln7s&ms=au%2Conr&mv=m&mvi=4&pl=26&initcwndbps=278750&vprv=1&mime=video%2Fmp4&ns=13YXWEXCOaflbwrdoTPbnwUG&cnr=14&ratebypass=yes&dur=2980.048&lmt=1647239317883159&mt=1647414780&fvip=4&fexp=24001373%2C24007246&c=WEB&txp=7310224&n=QLo28DGh9I8YYQ&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAI8NLjLspAoCqJPFOZUb62cATkyybPURKa541cWpebAHAiBkZmqXWEr0Alara090urQ0rHdd3ATEnUFF-exJvcIjrA%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAI_O0HKwtvgMm6344rH3ROA9I3NiitHN8sZXJ4luSlj8AiEAkIcbJYqjOz_6bPqdCF1hULbegUt0zQGHSQPRRcwzuxk%3D&title=UP%20Lekhpal%20Hindi%20%7C%20UP%20Constable%20Hindi%20%7C%20UPP%20Hindi%20Practice%20Set%20%7C%20Hindi%20Grammar%20%7C%20Hindi%20by%20Mohit%20Sir';
  String videoName = 'my_first_video';

  @override
  void initState() {
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
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      // onExitFullScreen: () {
      //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },

      player: YoutubePlayer(
        //aspectRatio: 19 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          //todo: change video quality
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        // onEnded: (data) {
        //   _showSnackBar('Video over!');
        // },
      ),
      builder: (context, player) => Scaffold(
        appBar:CustomAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            AppConstants.checkPermission(context, Permission.storage, requestDownload);
          },
          backgroundColor: AppColors.white,
          elevation: 8.0,
          label: ImageIcon(
            AssetImage(Images.download_pdf),
            color: AppColors.red,
            size: 24,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            SizedBox(height: 20),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(widget.courseData.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Text('Validity : 20th April 2022',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 10),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                          ViewPdf(AppConstants.BANNER_BASE + 'pdf link','')
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
                      child: Text('View PDF', style: TextStyle(color:AppColors.white, fontSize: 12)),
                    ),
                  ),
                )
              ],
            ),
            // SingleChildScrollView(
            //     child: Html(data:utf8.decode(base64.decode(widget.courseData.description.toString())))
            // ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text(widget.courseData.description.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.grey)),
                  ),
                ),
                widget.courseType==1 ?  Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        '\u{20B9}',
                        style: TextStyle(color: AppColors.black, fontSize: 25),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.courseData.regularPrice.toString(),
                        style: TextStyle(color: AppColors.grey, fontSize: 18,decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        widget.courseData.salePrice.toString(),
                        style: TextStyle(color: AppColors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ):SizedBox(),
                widget.courseType==1 ? InkWell(
                  onTap: () {
                   // showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppColors.transparent, builder: (context) =>BottomSheeet1(widget.paidcourseList));
                    // _BuyCourseBottomSheet(
                    //   context,
                    // );
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
                      MaterialPageRoute(builder: (context) =>
                          DeliveryDetailScreen('Course', widget.courseData.id.toString(),
                              widget.courseData.title.toString(), widget.courseData.salePrice.toString()
                          )
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 50,
                    margin: EdgeInsets.all(28),
                    child: Center(
                        child: Text(
                          getTranslated(context, StringConstant.buyCourse)!,
                      style: TextStyle(color: AppColors.white, fontSize: 18),
                    )),
                  ),
                ):SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> requestDownload() async {
    final dir = await getApplicationDocumentsDirectory();
    var _localPath = dir.path + '/' + pdfName;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: videoLink,
        fileName: videoName,
        savedDir: _localPath,
        showNotification: false,
        openFileFromNotification: false,
        saveInPublicStorage: false,
      );
      AppConstants.printLog(_taskid);
      Navigator.push(context, MaterialPageRoute(builder: (_) =>
          Downloads()
      ));
    });
  }
}

/*class Bottomsheet2 extends StatefulWidget {
  const Bottomsheet2({Key? key}) : super(key: key);

  @override
  _Bottomsheet2State createState() => _Bottomsheet2State();
}

class _Bottomsheet2State extends State<Bottomsheet2> {

  bool isVisible = false;
//   FocusNode inputNode = FocusNode();
// // to open keyboard call this function;
//   void openKeyboard(){
//     FocusScope.of(context).requestFocus(inputNode);
//   }
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
         // height: 210,
          color: AppColors.white,
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'pay via:',
                style: TextStyle(color: AppColors.grey400),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(color: AppColors.black, width: 1)),
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Image.asset(
                      Images.payment,
                      height: 25,
                      width: 25,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Pay Online',
                      style: TextStyle(color: AppColors.black),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  setState(() {
                    isVisible = true;
                  });
                  FocusScope.of(context).requestFocus(new FocusNode());
                 // visibilityObs ? null : _changed(true, "obs");
                },
                child: Container(height: 40,width: 120,
                  //padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: AppColors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Center(
                    child: Text(
                      'Apply coupon',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Visibility(
                visible: isVisible,
                // maintainSize: true,
                // maintainAnimation: true,
                // maintainState: true,
                child:  Row(crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex:3,
                        child: Container(
                          width: 70,
                          height: 45,
                          padding: EdgeInsets.only(left: 8,top: 4),
                          decoration: BoxDecoration(
                            color: AppColors.grey300,

                            borderRadius:  BorderRadius.all(const Radius.circular(12)),
                            //       border: Border(
                            //   left: BorderSide(10)
                            // ),
                            boxShadow: [
                              BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                            ],
                          ),
                          child: TextField(
                            maxLines: 1,
                           cursorColor:AppColors.amber ,

                           // focusNode: inputNode,
                            autofocus:true,
                            // style: Theme.of(context).textTheme.title,
                            decoration: new InputDecoration(
hintText: 'Discount Coupon',
                                hintStyle: TextStyle(color: AppColors.grey400),
                                isDense: true,
                              fillColor: AppColors.grey.withOpacity(0.1),border: InputBorder.none
                            ),
                          ),

                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex:2,
                        child: Container(
                          decoration: BoxDecoration(color: AppColors.amber,
                            borderRadius:  BorderRadius.all(const Radius.circular(12)),
                          ),
                          height: 45,child: Center(child: Text('Apply',style: TextStyle(color: AppColors.white),)),
                        ),
                      )
                ])
              )

            ],
          ),
        ),
      ),
    );
  }
}


class BottomSheeet1 extends StatefulWidget {
  final Courses paidcourseList;
  const BottomSheeet1(this.paidcourseList);

  @override
  _BottomSheeet1State createState() => _BottomSheeet1State();
}

class _BottomSheeet1State extends State<BottomSheeet1> {

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
            color: AppColors.white   ),


//height: MediaQuery.of(context).size.height/1.88,
        // padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28)),
                  color: AppColors.amber   ),),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.paidcourseList.title.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10,),

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
                      height: 200,
                      // child: FadeInImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(
                      //    AppConstants.BANNER_BASE+   widget.paidcourseList.bannerPath.toString()
                      //   ),
                      //   placeholder: AssetImage(Images.noimage),
                      // ),
                      child: AppConstants.image(AppConstants.BANNER_BASE + widget.paidcourseList.bannerPath.toString()),

                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.paidcourseList.title.toString(),maxLines: 2,
                    style: TextStyle(fontSize: 20),
                  ),

                  Row(
                    children: [
                      Text(
                        '\u{20B9}',
                        style: TextStyle(color: AppColors.black, fontSize: 25),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.paidcourseList.regularPrice.toString(),
                        style: TextStyle(color: AppColors.grey, fontSize: 18,decoration: TextDecoration.lineThrough),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        widget.paidcourseList.salePrice.toString(),
                        style: TextStyle(color: AppColors.black, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppColors.transparent, builder: (context) =>Bottomsheet2());
                          // _SkipBottomSheet(
                          //   context,
                          // );
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(color: AppColors.amber, width: 2)),
                          padding: EdgeInsets.all(8),
                          child:
                          Center(
                            child: Text(
                              getTranslated(context,StringConstant.skip)!,
                              style: TextStyle(color: AppColors.amber,fontSize: 20),
                            ),
                          ),

                        ),
                      ),
                      InkWell(
                        onTap: (){
                          FocusScope.of(context).unfocus();
                          Navigator.push(
                            context,
                            // MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
                            MaterialPageRoute(builder: (context) =>
                                DeliveryDetailScreen('Course', widget.paidcourseList.id.toString(),
                                    widget.paidcourseList.title.toString(), widget.paidcourseList.salePrice.toString()
                                )
                            ),
                          );
                        },
                        child: Container(
                          height: 50, width: 100,
                          //padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.amber,
                              borderRadius: BorderRadius.all(Radius.circular(7))),
                          child: Center(
                            child: Text(
                              getTranslated(context, StringConstant.add)!,
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
    ),
      );
  }


}*/

