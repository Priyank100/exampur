import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class MyMaterialVideo extends StatefulWidget {
  String url;
  String title;
  String download;

  MyMaterialVideo(this.url, this.title, this.download) : super();

  @override
  _MyMaterialVideoState createState() => _MyMaterialVideoState();
}

class _MyMaterialVideoState extends State<MyMaterialVideo> {
  FlickManager? flickManager;
  late VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(widget.url);
    flickManager = FlickManager(
      // videoPlayerController: VideoPlayerController.network(widget.url),
      videoPlayerController: _playerController,
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }

  // Future<void> initializePlayer() async {
  //  // videoPlayerController = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-forest-stream-in-the-sunlight-529-large.mp4');
  //   videoPlayerController = VideoPlayerController.network(widget.url);
  //   await Future.wait([
  //     videoPlayerController.initialize(),
  //   ]);
  //   chewieController = ChewieController(
  //     videoPlayerController: videoPlayerController,
  //     autoPlay: true,
  //     looping: true,
  //     aspectRatio: 16 / 9,
  //     // Try playing around with some of these other options:
  //
  //     // showControls: false,
  //     // materialProgressColors: ChewieProgressColors(
  //     //   playedColor: Colors.red,
  //     //   handleColor: Colors.blue,
  //     //   backgroundColor: Colors.grey,
  //     //   bufferedColor: Colors.lightGreen,
  //     // ),
  //     // placeholder: Container(
  //     //   color: Colors.grey,
  //     // ),
  //     // autoInitialize: true,
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
  //   chewieController.dispose();
  //   super.dispose();
  // }
  // @override
  // void dispose() {
  //   videoPlayerController.dispose();
  //   chewieController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            color: AppColors.transparent,
            height: (MediaQuery.of(context).size.width) / 16 * 9,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                FlickVideoPlayer(
                    flickManager: flickManager!
                ),
                /*Positioned(
                  right: MediaQuery.of(context).size.width/8,
                  bottom: 0.0,
                  child: DropdownButton<VideoSpeed>(
                    underline: SizedBox(),
                    icon: Icon(Icons.speed, color: AppColors.white),
                    onChanged: (VideoSpeed? videoSpeed) {
                      changeSpeed(videoSpeed!);
                    },
                    items: VideoSpeed.getVideoSpeedList()
                        .map<DropdownMenuItem<VideoSpeed>>(
                          (e) => DropdownMenuItem<VideoSpeed>(
                          value: e,
                          child: Text(e.title)
                      ),
                    ).toList(),
                  )
                )*/
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.title, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(
            height: 60,
          ),
          Center(
            child: InkWell(onTap: (){
              if(widget.url.contains('mp4'))
                AppConstants.checkPermission(context, Permission.storage, requestVideoDownload);
              else
                AppConstants.showAlertDialog(context, 'Url not in mp4 format');
            },
              child: Container(
                  height: 45,width:MediaQuery.of(context).size.width/1.10,decoration: BoxDecoration( color:AppColors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, StringConstant.downloadVideo)!,style: TextStyle(color: Colors.white,fontSize: 15)
              ))),
            ),
          )
        ],
      ),
    );
  }

  Future<void> requestVideoDownload() async {
    final dir = await getApplicationDocumentsDirectory();

    var _localPath = dir.path + '/' + widget.title;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: widget.download =="" ? widget.url: widget.download,
        fileName: widget.title,
        savedDir: _localPath,
        showNotification: false,
        openFileFromNotification: false,
        saveInPublicStorage: false,
      );
      AppConstants.printLog(_taskid);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Downloads(0)));
    });
  }

  void changeSpeed(VideoSpeed videoSpeed) {
    setState(() {
      _playerController.setPlaybackSpeed(videoSpeed.speed);
    });
  }
}

class VideoSpeed {
  final String title;
  final double speed;
  VideoSpeed(this.title, this.speed);

  static List<VideoSpeed> getVideoSpeedList() {
    return <VideoSpeed>[
      VideoSpeed('2.0x', 2.0),
      VideoSpeed('1.75x', 1.75),
      VideoSpeed('1.5x', 1.5),
      VideoSpeed('1.25x', 1.25),
      VideoSpeed('Normal', 1.0),
      VideoSpeed('0.75x', 0.75),
      VideoSpeed('0.5x', 0.5),
      VideoSpeed('0.25x', 0.25)
    ];
  }
}
