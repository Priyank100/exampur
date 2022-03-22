import 'package:chewie/chewie.dart';
import 'package:exampur_mobile/data/model/my_course_timeline_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyTimeTableViedo extends StatefulWidget {
// String url;
//   MyTimeTableViedo(this.url) : super();

  @override
  _MyTimeTableViedoState createState() => _MyTimeTableViedoState();
}

class _MyTimeTableViedoState extends State<MyTimeTableViedo> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network('widget.url');
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 8),
            height: 250,
            child: Chewie(
                controller: chewieController
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child:   Text(widget.title),
          // )
        ],
      ),
    );
  }
}

