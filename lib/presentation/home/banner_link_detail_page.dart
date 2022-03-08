import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/banner_detail_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class BannerLinkDetailPage extends StatefulWidget {
  String type;
  final datalink;
  BannerLinkDetailPage(this.type, this.datalink) ;

  @override
  _BannerLinkDetailPageState createState() => _BannerLinkDetailPageState();
}

class _BannerLinkDetailPageState extends State<BannerLinkDetailPage> {
   Data? bannerDetailData;
   bool isLoading=false;
  Future<void> getLists() async {
    isLoading=true;
    if (widget.type == 'Course') {
      bannerDetailData= (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannnerCourseDetail(context, widget.datalink.toString()))! ;
      //print('anchal'+bannerDetailData.title.toString());
    } else {
      bannerDetailData= (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannnerBookDetail(context, widget.datalink.toString()))! ;
    }
    isLoading=false;
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
      body:bannerDetailData==null?Center(child: CircularProgressIndicator(color: AppColors.amber,)):
      Viedobanner(bannerDetailData!.videoPath.toString(), bannerDetailData!.title.toString(), bannerDetailData!.id.toString(), bannerDetailData!.salePrice.toString(),)

    );
  }
}

class Viedobanner extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String id;
  final String salePrice;
  const Viedobanner(this.videoUrl, this.title,this.id,this.salePrice) : super();

  @override
  _ViedobannerState createState() => _ViedobannerState();
}

class _ViedobannerState extends State<Viedobanner> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID = YoutubePlayer.convertUrlToId(
          widget.videoUrl.toString())!;
      _controller = YoutubePlayerController(
        initialVideoId: videoID,
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          autoPlay: true,
          mute: false,
        ),
      );
    } on Exception catch (exception) {
      AppConstants.printLog(exception.toString());
      videoID = '';
    } catch (error) {
      AppConstants.printLog(error.toString());
      videoID = '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
      // appBar: CustomAppBar(),
      body:MediaQuery.of(context).orientation == Orientation.landscape ? YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.amber,
      ): Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.amber,
            ),
            SizedBox(height: 20),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(widget.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => DeliveryDetailScreen(widget.paidcourseList)),
              MaterialPageRoute(builder: (context) =>
                  DeliveryDetailScreen('Course', widget.id.toString(),
                      widget.title.toString(), widget.salePrice.toString()
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
          )),
          ],
        ),
      ),
    );
  }
}
