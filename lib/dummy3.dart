import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Dummy3 extends StatefulWidget {
  final String videoPath;
  const Dummy3(this.videoPath) : super();

  @override
  _Dummy3State createState() => _Dummy3State();
}

class _Dummy3State extends State<Dummy3> {
  String videoID = '';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    try {
      videoID= YoutubePlayer.convertUrlToId(widget.videoPath)!;
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
      print(exception);
      videoID = '';
    } catch (error) {
      print(error);
      videoID = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MediaQuery.of(context).orientation == Orientation.landscape ? null : AppBar(title: Text('Youtube')),
      appBar: AppBar(title: Text('Youtube')),
      body: Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]);
  //   super.dispose();
  // }
}
