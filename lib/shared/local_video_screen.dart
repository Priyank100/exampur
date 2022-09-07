import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';

class LocalVideoScreen extends StatefulWidget {
  final File file;
  final String title;
  const LocalVideoScreen(this.file, this.title) : super();

  @override
  _LocalVideoScreenState createState() => _LocalVideoScreenState();
}
class _LocalVideoScreenState extends State<LocalVideoScreen> {
  // late VideoPlayerController videoPlayerController;
  // ChewieController? chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   // videoPlayerController = VideoPlayerController.file(widget.file);
  //   // chewieController = ChewieController(
  //   //   videoPlayerController: videoPlayerController,
  //   //   aspectRatio: 16/9 ,
  //   //   autoPlay: true,
  //   //   looping: true,
  //   // );
  //   initializePlayer();
  // }
  //
  // Future<void> initializePlayer() async {
  //   // videoPlayerController = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
  //   videoPlayerController = VideoPlayerController.file(widget.file);
  //   await Future.wait([
  //     videoPlayerController.initialize(),
  //   ]);
  //   chewieController = ChewieController(
  //       videoPlayerController: videoPlayerController,
  //       autoPlay: true,
  //       looping: true,
  //       aspectRatio: 16 / 9,
  //       // Try playing around with some of these other options:
  //
  //       // showControls: false,
  //       // materialProgressColors: ChewieProgressColors(
  //       //   playedColor: Colors.red,
  //       //   handleColor: Colors.blue,
  //       //   backgroundColor: Colors.grey,
  //       //   bufferedColor: Colors.lightGreen,
  //       // ),
  //       // placeholder: Container(
  //       //   color: Colors.grey,
  //       // ),
  //       // autoInitialize: true,
  //       errorBuilder: (context, errorMessage) {
  //         return Center(
  //           child: Text(
  //             errorMessage,
  //             style: TextStyle(color: AppColors.white),
  //           ),
  //         );}
  //   );
  //   setState(() {});
  // }
  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController!.dispose();
  //   super.dispose();
  // }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: CustomAppBar(),
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           padding: EdgeInsets.only(top: 8),
  //           height: (MediaQuery.of(context).size.width)/16*9,
  //           child: chewieController != null &&
  //               chewieController!
  //                   .videoPlayerController.value.isInitialized
  //               ? Chewie(
  //             controller: chewieController!,
  //           )
  //               :   Center(child: CircularProgressIndicator(color: AppColors.amber,)),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child:   Text(widget.title,style: TextStyle(fontSize: 20),),
  //         )
  //       ],
  //     ),
  //   );
  // }

  FlickManager? flickManager;
  VideoPlayerController? _playerController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    // _videoPlayerController= VideoPlayerController.file(widget.file);
    // flickManager = FlickManager(
    //   videoPlayerController:_videoPlayerController,
    // );
  }
  Future<void> initializePlayer() async {
    try {
      VideoPlayerController _oldCon = _playerController!;
      _oldCon.dispose();
      _playerController = null;
    } catch(e) {
      // print(e);
    }
    Future.delayed(Duration(milliseconds: 200));
    try {
      _playerController = VideoPlayerController.file(
          widget.file,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true)
      );
      await _playerController!.initialize().then((_){
        setState(() {
          _playerController!.seekTo(Duration(seconds: 0));
          _playerController!.play();
        });
      });
    } catch(e) {
      SchedulerBinding.instance!.addPostFrameCallback((_) => AppConstants.showAlertDialogWithBack(context, 'Video not available...'));
    }
    flickManager = FlickManager(
      videoPlayerController: _playerController!,
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
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
              color: AppColors.transparent,
              height: (MediaQuery.of(context).size.width) / 16 * 9,
              width: MediaQuery.of(context).size.width,
              // child: FlickVideoPlayer(
              //     flickManager: flickManager!
              // )
              child: _playerController!.value.isInitialized ? FlickVideoPlayer(
                  flickManager: flickManager!
              ) :  Container(
                color: AppColors.black,
                height: (MediaQuery.of(context).size.width) / 16 * 9,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator(color: AppColors.amber)),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:   Text(widget.title.replaceAll('--', ''),style: TextStyle(fontSize: 20),),
          )
        ],
      ),
    );
  }

}