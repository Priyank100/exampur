import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LocalVideoScreen extends StatefulWidget {
  final File file;
  final String title;
  const LocalVideoScreen(this.file, this.title) : super();

  @override
  _LocalVideoScreenState createState() => _LocalVideoScreenState();
}
class _LocalVideoScreenState extends State<LocalVideoScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    // videoPlayerController = VideoPlayerController.file(widget.file);
    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   aspectRatio: 16/9 ,
    //   autoPlay: true,
    //   looping: true,
    // );
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    // videoPlayerController = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
    videoPlayerController = VideoPlayerController.file(widget.file);
    await Future.wait([
      videoPlayerController.initialize(),
    ]);
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        aspectRatio: 16 / 9,
        // Try playing around with some of these other options:

        // showControls: false,
        // materialProgressColors: ChewieProgressColors(
        //   playedColor: Colors.red,
        //   handleColor: Colors.blue,
        //   backgroundColor: Colors.grey,
        //   bufferedColor: Colors.lightGreen,
        // ),
        // placeholder: Container(
        //   color: Colors.grey,
        // ),
        // autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: AppColors.white),
            ),
          );}
    );
    setState(() {});
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
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
            height: (MediaQuery.of(context).size.width)/16*9,
            child: chewieController != null &&
                chewieController!
                    .videoPlayerController.value.isInitialized
                ? Chewie(
              controller: chewieController!,
            )
                :   Center(child: CircularProgressIndicator(color: AppColors.amber,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:   Text(widget.title,style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }
}