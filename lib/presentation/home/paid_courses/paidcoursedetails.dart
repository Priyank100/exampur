import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

typedef YoutubeQualityChangeCallback(String quality, Duration position);

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
// String _selectedQuality='';
  // String pdfLink = 'https://www.learningcontainer.com/download/sample-pdf-file-for-testing/?wpdmdl=1566&amp;refresh=621508d3713281645545683';
  // String pdfName = 'my_first_pdf';
  // String videoLink= 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
  // String videoName = 'my_first_video2';

  List<bool> radioSelectList = [];
  String selectedEmiPlans = '';

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
    // if (defaultQuality == '720p') {
    //   _selectedQuality = 'HD';
    // } else if (defaultQuality == '1080p') {
    //   _selectedQuality = 'Full HD';
    // } else {
    //   _selectedQuality =defaultQuality!.toUpperCase();
    // }

    if(widget.courseData.emiPLans != null && widget.courseData.emiPLans!.length > 0) {
      for (int i = 0; i < widget.courseData.emiPLans!.length; i++) {
        radioSelectList.add(false);
      }
    }

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
      player: YoutubePlayer(
        //aspectRatio: 19 / 9,
        controller: _controller,
        // showVideoProgressIndicator: false,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          //todo: change video quality
          // const SizedBox(width: 8.0),
          // Expanded(
          //   child: Text(
          //     _controller.metadata.title,
          //     style: const TextStyle(
          //       color: Colors.white,
          //       fontSize: 18.0,
          //     ),
          //     overflow: TextOverflow.ellipsis,
          //     maxLines: 1,
          //   ),
          // ),
          // IconButton(
          //   icon: const Icon(
          //     Icons.settings,
          //     color: Colors.white,
          //     size: 25.0,
          //   ),
          //   onPressed: () {
          //     _resolutionBottomSheet();
          //   },
          // ),
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
                          child: Text(getTranslated(context, StringConstant.Validity)!+' :  '+widget.courseData.validTime.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        widget.courseData.pdfPath==null || widget.courseData.pdfPath=='null' || widget.courseData.pdfPath!.isEmpty ? SizedBox():
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                          child: InkWell(
                            onTap: (){
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
                              child: Text(getTranslated(context, StringConstant.viewPdf)!, style: TextStyle(color:AppColors.white, fontSize: 10)),
                            ),
                          ),
                        )
                      ],
                    ),
                    widget.courseType==1 ?  Padding(
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
                        fontSize: FontSize(12.0),
                        fontWeight: FontWeight.bold,
                      ),
                    },)
                  ],
                )
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          child: widget.courseType==1 ?
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  radioSelectList.length == 0 ?
                  SizedBox() :
                  InkWell(
                    onTap: () {
                      showBottomSheetEmiPlans();
                    },
                    child: Container(
                      width: double.infinity,
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
                  ),
                  InkWell(
                    onTap: () {
                      _controller.pause();
                      FirebaseAnalytics.instance.logEvent(name: 'Buy_Course',parameters: {
                        'Couse_Id':widget.courseData.id.toString(),
                        'Couse_Name':widget.courseData.title.toString()
                      });
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          DeliveryDetailScreen(widget.courseTabType, widget.courseData.id.toString(),
                              widget.courseData.title.toString(), widget.courseData.salePrice.toString(),
                              upsellBookList: widget.courseData.upsellBook??[]
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
                            getTranslated(context, StringConstant.buyCourse)!,
                            style: TextStyle(color: AppColors.white, fontSize: 18),
                          )),
                    ),
                  )
                ],
              ) : SizedBox()
        ),
      ),
    );
  }

  void showBottomSheetEmiPlans() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: ListView.builder(
            shrinkWrap: true,
            // itemCount: widget.courseData.emiPLans!.length,
            itemCount: 3,
              itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(5),
                child: RadioListTile(
                  groupValue: selectedEmiPlans,
                  value: 'Test',
                  // title: Text(widget.courseData.emiPLans![index].title.toString()),
                  title: Text('Test'),
                  onChanged: (value){
                    setState(() {
                      selectedEmiPlans = '';
                    });
                  },
                ),
              );
            }
          ),
        );
      }
    );
  }

  // void _resolutionBottomSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             _qualityRow('1080p'),
  //             _qualityRow('720p'),
  //             _qualityRow('480p'),
  //             _qualityRow('360p'),
  //             _qualityRow('240p'),
  //             _qualityRow('144p'),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget _qualityRow(String quality) {
  //   String currentQuality;
  //   if (quality == '1080p') {
  //     currentQuality = 'Full HD';
  //   } else if (quality == '720p') {
  //     currentQuality = 'HD';
  //   } else {
  //     currentQuality = quality.toUpperCase();
  //   }
  //   return InkWell(
  //     onTap: () {
  //       qualityChangeCallback(
  //         quality.toLowerCase(),
  //         _controller.value.position,
  //       );
  //       Navigator.pop(context);
  //     },
  //     child: Row(
  //       children: <Widget>[
  //         Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: currentQuality == _selectedQuality
  //               ? Icon(
  //             Icons.check,
  //           )
  //               : Container(
  //             height: 30,
  //             width: 30,
  //           ),
  //         ),
  //         Text(
  //           quality,
  //           style: TextStyle(fontWeight: FontWeight.w900),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

