import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppTutorialVideo extends StatefulWidget {
  final String videoPath;
  final String title;
  const AppTutorialVideo(this.videoPath, this.title) : super();

  @override
  _AppTutorialVideoState createState() => _AppTutorialVideoState();
}

class _AppTutorialVideoState extends State<AppTutorialVideo> {
  // String videoID = '';
  // late YoutubePlayerController _controller;
  //
  // @override
  // void initState() {
  //   try {
  //     videoID= YoutubePlayer.convertUrlToId(widget.videoPath)!;
  //     _controller = YoutubePlayerController(
  //       initialVideoId: videoID,
  //       flags: YoutubePlayerFlags(
  //         hideControls: false,
  //         controlsVisibleAtStart: true,
  //         autoPlay: true,
  //         mute: false,
  //       ),
  //     );
  //
  //   } on Exception catch (exception) {
  //     AppConstants.printLog(exception.toString());
  //     videoID = '';
  //   } catch (error) {
  //     AppConstants.printLog(error.toString());
  //     videoID = '';
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //      appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : CustomAppBar(),
  //    // appBar: CustomAppBar(),
  //     body:
  //     MediaQuery.of(context).orientation == Orientation.landscape ?  YoutubePlayer(
  //       controller: _controller,
  //       showVideoProgressIndicator: true,
  //       progressIndicatorColor: AppColors.amber,
  //     ):
  //     Container(
  //       child: Column(
  //         children: [
  //           YoutubePlayer(
  //             controller: _controller,
  //             showVideoProgressIndicator: true,
  //             progressIndicatorColor: AppColors.amber,
  //           ),
  //           SizedBox(height: 40),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Text(widget.title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
  //           )
  //         ],
  //       ),
  //     ),
  //   );

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    String videoId = (YoutubePlayer.convertUrlToId(widget.videoPath.toString()) == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId(widget.videoPath.toString())!;

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
        appBar:CustomAppBar()
        ,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            SizedBox(height: 20),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(widget.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                )),



            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: RichText(
            //     text: TextSpan(
            //        // style: CustomTextStyle.headingSemiBold(context),
            //         text: widget.paidcourseList.title.toString()),
            //   ),
            // ),
            // SizedBox(height: 5),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
            //   child: RichText(
            //     text: TextSpan(
            //         //style: CustomTextStyle.subHeading2(context),
            //         ),
            //   ),
            // ),
          ],
        ),
      ),
    );

}
}
