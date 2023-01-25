import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../utils/appBar.dart';
import '../../widgets/Custom_toogle_button.dart';

class FreeVideoDetail extends StatefulWidget {
  const FreeVideoDetail({Key? key}) : super(key: key);

  @override
  State<FreeVideoDetail> createState() => _FreeVideoDetailState();
}

class _FreeVideoDetailState extends State<FreeVideoDetail> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;
  bool isShow = false;

  @override
  void initState() {
    String videoId = (YoutubePlayer.convertUrlToId('') == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId('')!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId, //widget.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
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
    return  YoutubePlayerBuilder(
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
      backgroundColor: Colors.white,
      appBar:CustomAppBar(),
      body: Column(children: [
        player,
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ToggleButton(onPressedChat: (){

          },onPressedPlaylist: (){

          },),
        ),
        Text('dxfcgvhbjnkm')
      ],),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8),
        color: Colors.amber.shade200,
        child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('rdtfyguhjikl'),
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 Column(children: [
                   SizedBox(height: 10,),
                      Text('SSc Batch',style: TextStyle(fontSize: 20),),

            Row(
              children: [
                Text('1500'),
                SizedBox(width: 10,),
                Text('3000'),
              ])
                 ],) ,
                  Container(
                    height: 60,
                    width: 140,
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text('View Course'),)
                ],),
          ],
        ),)

    ));
  }
}
