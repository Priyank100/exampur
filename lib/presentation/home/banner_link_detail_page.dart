import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/data/model/upsell_book.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/banner_detail_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BannerLinkDetailPage extends StatefulWidget {
  String type;
  final datalink;

  BannerLinkDetailPage(this.type, this.datalink);

  @override
  _BannerLinkDetailPageState createState() => _BannerLinkDetailPageState();
}

class _BannerLinkDetailPageState extends State<BannerLinkDetailPage> {
  Data? bannerDetailData;
  bool isLoading = false;

  Future<void> getLists() async {
    isLoading = true;
    if (widget.type == 'Course') {
      bannerDetailData = (await Provider.of<HomeBannerProvider>(context,
              listen: false)
          .getHomeBannnerCourseDetail(context, widget.datalink.toString()))!;
    } else {
      bannerDetailData =
          (await Provider.of<HomeBannerProvider>(context, listen: false)
              .getHomeBannnerComboDetail(context, widget.datalink.toString()))!;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bannerDetailData == null
            ? Center(child: LoadingIndicator(context))
            : Viedobanner(
                widget.type,
                bannerDetailData!.videoPath.toString(),
                bannerDetailData!.title.toString(),
                bannerDetailData!.id.toString(),
                bannerDetailData!.salePrice.toString(),
                bannerDetailData!.regularPrice.toString(),
                bannerDetailData!.description.toString(),
                bannerDetailData!.upsellBook??[],
                bannerDetailData!.pdfPath.toString(),
                bannerDetailData!.status.toString()
        )
    );
  }
}

class Viedobanner extends StatefulWidget {
  final String type;
  final String videoUrl;
  final String title;
  final String id;
  final String salePrice;
  final String regularPrice;
  final String description;
  final List<UpsellBook> upsellBookList;
  final String pdfPath;
  final String status;

  const Viedobanner(this.type, this.videoUrl, this.title, this.id,
      this.salePrice, this.regularPrice,this.description, this.upsellBookList,this.pdfPath, this.status)
      : super();

  @override
  _ViedobannerState createState() => _ViedobannerState();
}

class _ViedobannerState extends State<Viedobanner> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    String videoId =
        (YoutubePlayer.convertUrlToId(widget.videoUrl.toString()) == null)
            ? "errorstring"
            : YoutubePlayer.convertUrlToId(widget.videoUrl.toString())!;

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
        appBar: CustomAppBar(),
        // body:  Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       player,
        //       SizedBox(height: 20),
        //       Flexible(
        //           child: Padding(
        //         padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        //         child: Text(widget.title.toString(),
        //             textAlign: TextAlign.center,
        //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        //       )),
        //
        //       Padding(
        //         padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
        //         child: Row(
        //           children: [
        //             Text(
        //               '\u{20B9}',
        //               style: TextStyle(color: AppColors.black, fontSize: 25),
        //             ),
        //             SizedBox(
        //               width: 15,
        //             ),
        //             Text(
        //               widget.regularPrice.toString(),
        //               style: TextStyle(
        //                   color: AppColors.grey,
        //                   fontSize: 18,
        //                   decoration: TextDecoration.lineThrough),
        //             ),
        //             SizedBox(
        //               width: 5,
        //             ),
        //             Text(
        //               widget.salePrice.toString(),
        //               style: TextStyle(
        //                 fontSize: 18,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Html(data:widget.description.toString(), style: {
        //         "body": Style(
        //           fontSize: FontSize(12.0),
        //           fontWeight: FontWeight.bold,
        //         ),
        //       },),
        //       InkWell(
        //         onTap: () {
        //           // showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppColors.transparent, builder: (context) =>BottomSheeet1(widget.paidcourseList));
        //           // _BuyCourseBottomSheet(
        //           //   context,
        //           // );
        //           // AppConstants.printLog(widget.type);
        //           if (widget.type == 'Combo Course') {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => DeliveryDetailScreen(
        //                       'Combo',
        //                       widget.id.toString(),
        //                       widget.title.toString(),
        //                       widget.salePrice.toString(),
        //                       upsellBookList: widget.upsellBookList)),
        //             );
        //           } else {
        //             Navigator.push(
        //               context,
        //               // MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
        //               MaterialPageRoute(
        //                   builder: (context) => DeliveryDetailScreen(
        //                       'Course',
        //                       widget.id.toString(),
        //                       widget.title.toString(),
        //                       widget.salePrice.toString(),
        //                       upsellBookList: widget.upsellBookList)),
        //             );
        //           }
        //         },
        //         child: Container(
        //           width: double.infinity,
        //           decoration: BoxDecoration(
        //               color: AppColors.amber,
        //               borderRadius: BorderRadius.all(Radius.circular(10))),
        //           height: 50,
        //           margin: EdgeInsets.all(28),
        //           child: Center(
        //               child: Text(
        //             getTranslated(context, LangString.buyCourse)!,
        //             style: TextStyle(color: AppColors.white, fontSize: 18),
        //           )),
        //         ),
        //       )
        //       // Padding(
        //       //   padding: EdgeInsets.all(15),
        //       //   child: RichText(
        //       //     text: TextSpan(
        //       //        // style: CustomTextStyle.headingSemiBold(context),
        //       //         text: widget.paidcourseList.title.toString()),
        //       //   ),
        //       // ),
        //       // SizedBox(height: 5),
        //       // Padding(
        //       //   padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        //       //   child: RichText(
        //       //     text: TextSpan(
        //       //         //style: CustomTextStyle.subHeading2(context),
        //       //         ),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        body: Column(
          children: [
            player,
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          widget.pdfPath==null || widget.pdfPath=='null' || widget.pdfPath.isEmpty ? SizedBox() :  Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                widget.pdfPath.toString().contains('http') ?
                                ViewPdf(widget.pdfPath.toString(),'') :
                                ViewPdf(AppConstants.BANNER_BASE + widget.pdfPath.toString(),'')
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
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(widget.title.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                     Padding(
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
                              widget.regularPrice.toString(),
                              style: TextStyle(color: AppColors.grey, fontSize: 15,decoration: TextDecoration.lineThrough),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              widget.salePrice.toString(),
                              style: TextStyle(color: AppColors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Html(data:widget.description.toString(), style: {
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
        bottomNavigationBar:  InkWell(
                onTap: () {
                  _controller.pause();
                  // showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppColors.transparent, builder: (context) =>BottomSheeet1(widget.paidcourseList));
                  // _BuyCourseBottomSheet(
                  //   context,
                  // );
                  // AppConstants.printLog(widget.type);
                  if (widget.type == 'Combo Course') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeliveryDetailScreen(
                              'Combo',
                              widget.id.toString(),
                              widget.title.toString(),
                              widget.salePrice.toString(),
                              upsellBookList: widget.upsellBookList,
                              pre_booktype: widget.status)),
                    );
                  } else {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
                      MaterialPageRoute(
                          builder: (context) => DeliveryDetailScreen(
                              'Course',
                              widget.id.toString(),
                              widget.title.toString(),
                              widget.salePrice.toString(),
                              upsellBookList: widget.upsellBookList,
                            pre_booktype: widget.status)),
                    );
                  }
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
                    getTranslated(context, LangString.buyCourse)!,
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  )),
                ),
              ) ,
        ),

    );
  }
}
