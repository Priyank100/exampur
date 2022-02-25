  import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BannerDetailPage extends StatefulWidget {
  final datalink;
  final title;
BannerDetailPage(this.datalink,this.title) ;

  @override
  _BannerDetailPageState createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID = YoutubePlayer.convertUrlToId(
          widget.datalink.toString())!;
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
                  child: Text(widget.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),
            // Flexible(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            //     child: Text(widget.paidcourseList.description.toString(),
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 10,
            //             color: AppColors.grey)),
            //   ),
            // ),
            // widget.courseType==1 ?  Padding(
            //   padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            //   child: Row(
            //     children: [
            //       Text(
            //         '\u{20B9}',
            //         style: TextStyle(color: AppColors.black, fontSize: 25),
            //       ),
            //       SizedBox(
            //         width: 15,
            //       ),
            //       Text(
            //         widget.paidcourseList.regularPrice.toString(),
            //         style: TextStyle(color: AppColors.grey, fontSize: 18,decoration: TextDecoration.lineThrough),
            //       ),
            //       SizedBox(width: 5,),
            //       Text(
            //         widget.paidcourseList.salePrice.toString(),
            //         style: TextStyle(color: AppColors.black, fontSize: 18),
            //       ),
            //     ],
            //   ),
            // ):SizedBox(),
            // widget.courseType==1 ?     InkWell(
            //   onTap: () {
            //     showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppColors.transparent, builder: (context) =>BottomSheeet1(widget.paidcourseList));
            //     // _BuyCourseBottomSheet(
            //     //   context,
            //     // );
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         color: AppColors.amber,
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //     height: 50,
            //     margin: EdgeInsets.all(28),
            //     child: Center(
            //         child: Text(
            //           getTranslated(context, StringConstant.buyCourse)!,
            //           style: TextStyle(color: AppColors.white, fontSize: 18),
            //         )),
            //   ),
            // ):SizedBox()
          ],
        ),
      ),
    );
  }
}
