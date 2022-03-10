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

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    String videoId = (YoutubePlayer.convertUrlToId(widget.viedoList.targetLink.toString()) == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId(widget.viedoList.targetLink.toString())!;

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
                  child: Text(widget.viedoList.title.toString(),
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
