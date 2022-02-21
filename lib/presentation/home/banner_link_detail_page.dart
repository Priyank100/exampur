import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/banner_detail_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class BannerLinkDetailPage extends StatefulWidget {
  String type;
  final datalink;
  BannerLinkDetailPage(this.type,this.datalink) ;

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
      body:bannerDetailData==null?Center(child: CircularProgressIndicator(color: AppColors.amber,)):Viedobanner(bannerDetailData!)

    );
  }
}

class Viedobanner extends StatefulWidget {
  final Data bannerDetailData;
  const Viedobanner(this.bannerDetailData) ;

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
          widget.bannerDetailData.videoPath.toString())!;
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
            //SizedBox(height: 20),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(widget.bannerDetailData.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),

          ],
        ),
      ),
    );
  }
}
