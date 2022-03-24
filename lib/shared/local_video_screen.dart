import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:exampur_mobile/utils/appBar.dart';
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
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.file(widget.file);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16/9 ,
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
            height: (MediaQuery.of(context).size.width)/16*9,
            child: Chewie(
                controller: chewieController
            ),
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