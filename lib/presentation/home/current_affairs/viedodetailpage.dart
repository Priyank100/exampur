import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ViedoDetailPage extends StatefulWidget {
  final Data viedoList;
  const ViedoDetailPage(this.viedoList) ;

  @override
  _ViedoDetailPageState createState() => _ViedoDetailPageState();
}

class _ViedoDetailPageState extends State<ViedoDetailPage> {
  String videoID = '';
  late YoutubePlayerController _controller;
  @override
  void initState() {
    try {
      videoID = YoutubePlayer.convertUrlToId(
          widget.viedoList.targetLink)!;
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

        // resizeToAvoidBottomInset: true,
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
    child: Text(widget.viedoList.title.toString(),
    textAlign: TextAlign.center,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    )),
    // Flexible(
    // child: Padding(
    // padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
    // child: Text(widget.viedoList.description.toString(),
    // style: TextStyle(
    // fontWeight: FontWeight.bold,
    // fontSize: 10,
    // color: AppColors.grey)),
    // ),
    // ),

    ],
    ),
    ));
  }
}
