
import 'package:chewie/chewie.dart';

import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class MyApexVideoMaterial extends StatefulWidget {
  String url;
  String title;
  MyApexVideoMaterial(this.url,this.title) : super();

  @override
  _MyApexVideoMaterialState createState() => _MyApexVideoMaterialState();
}

class _MyApexVideoMaterialState extends State<MyApexVideoMaterial> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url);
    chewieController = ChewieController(
        cupertinoProgressColors: ChewieProgressColors(),
        videoPlayerController: videoPlayerController,
        aspectRatio: 16/9,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text("Video unavanilable",style: TextStyle(color: AppColors.white),),
          );
        });

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
          SizedBox(height: 8,),
          Container(
            //padding: EdgeInsets.only(top: 8),
            height: (MediaQuery.of(context).size.width)/16*9,
            width: MediaQuery.of(context).size.width,
            child: Chewie(
                controller: chewieController
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:   Text(widget.title,style: TextStyle(fontSize: 20)),
          ),

        ],
      ),
    );
  }
}
