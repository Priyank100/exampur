import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../SharePref/shared_pref.dart';
import '../../../utils/api.dart';

class MyMaterialVideo extends StatefulWidget {
  String url;
  String title;
  String download;
  String vid;
  bool isTimlineRequired;


  MyMaterialVideo(this.url, this.title, this.download,this.vid,this.isTimlineRequired) : super();

  @override
  _MyMaterialVideoState createState() => _MyMaterialVideoState();
}

class _MyMaterialVideoState extends State<MyMaterialVideo> {
  FlickManager? flickManager;
  VideoPlayerController? _playerController;
  String? deviceModel;
  String? deviceMake;
  String? deviceOS;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? versionName;
  String? versionCode;


  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
      setState(() {});
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    setState(() {});
  }


  @override
  void initState() {
    initializePlayer();
    getUserData();
    getDeviceData();
    getAppVersionData();
    super.initState();
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
    _playerController = VideoPlayerController.network(
        widget.url,
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
    _playerController!.pause();
    _playerController!.dispose();
    flickManager!.dispose();

    widget.isTimlineRequired == true ?  videoTimeLog():null;
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

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pop(context);
    AppConstants.checkRatingCondition(context, false);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
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
              child: Text(widget.title.replaceAll('--', ''), style: TextStyle(fontSize: 20)),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  _playerController!.pause();
                  if(widget.download.isEmpty) {
                    if(widget.url.contains('mp4')) {
                      // AppConstants.checkPermission(context, Permission.storage, requestVideoDownload);
                      openPermissionDialog();
                    } else {
                      AppConstants.showAlertDialog(context, 'No Video Found to Download this Video');
                    }
                  } else {
                    if(widget.download.contains('mp4')) {
                      // AppConstants.checkPermission(context, Permission.storage, requestVideoDownload);
                      openPermissionDialog();
                    } else {
                      AppConstants.showAlertDialog(context, 'No Video Found to Download this Video');
                    }
                  }
                },
                child: Container(
                    height: 45,width:MediaQuery.of(context).size.width/1.10,decoration: BoxDecoration( color:AppColors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text(getTranslated(context, LangString.downloadVideo)!,style: TextStyle(color: Colors.white,fontSize: 15)))
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> openPermissionDialog() async {
    await Permission.storage.request().then((value) async {
      if(value.isGranted) {
        AppConstants.createExampurFolder();
      widget.isTimlineRequired == true ?  videoDownloadClickLog():null;
        requestVideoDownload();
      } else {
        AppConstants.showAlertDialogWithButton(
            context,
            "To download this file, click on 'Continue' to allow the storage permission from setting",
                () async {
              Navigator.pop(context);
              await openAppSettings();
            }
        );
      }
    });
  }

  Future<void> requestVideoDownload() async {
      var now = DateTime.now();
      final dir = await getApplicationDocumentsDirectory();
     //  var _localPath = dir.path + '/' + widget.title + '~' + now.toString();
      var _localPath = dir.path + Platform.pathSeparator + widget.vid+ now.toString();
       final savedDir = Directory(_localPath);
     // final savedDir = Directory(AppConstants.filePath);
      await savedDir.create(recursive: true).then((value) async {
        String? _taskid = await FlutterDownloader.enqueue(
          url: widget.download == "" ? widget.url : widget.download,
          fileName: widget.title,
          savedDir: _localPath,
          showNotification: false,
          openFileFromNotification: false,
          saveInPublicStorage: false,
        );
        AppConstants.printLog(_taskid);
        AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        AppConstants.printLog( widget.download == "" ? widget.url : widget.download);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Downloads(0)));
      }).catchError((error) {
        AppConstants.printLog(error);
      });
  }
  Future<void> videoTimeLog() async {
    // AppConstants.showLoaderDialog(context);
    var d = Duration(seconds: _playerController!.value.position.inSeconds);
    var min = d.inMinutes;
    var sec = _playerController!.value.position.inSeconds % 60;
    var m = '$min'.padLeft(2,'0');
    var s = '$sec'.padLeft(2,'0');
    AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>+ $m:$s');
    {
      var body = {
        "user": {
          "name": userName,
          "email": userEmail,
          "mobile": userMobile
        },
        "device": {
          "model": deviceModel,
          "make": deviceMake,
          "os": deviceOS
        },
        "app": {
          "version_name": versionName,
          "version_code": versionCode
        },
        "type": "content-log",
        "content-type": "video-view",
        "course": {
          "name":AppConstants.myCourseName,
          "id": AppConstants.myCourseId
        },
        "content": {
          "timeline_name": widget.title.toString(),
          "timeline_id": widget.vid.toString(),
          "time_spend":'$m:$s',
        }
      };
      Map<String, String> header = {
        "x-auth-token": AppConstants.serviceLogToken,
        "Content-Type": "application/json",
        "app-version":AppConstants.versionCode
      };

      await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((
          response) {
       // AppConstants.printLog(header);
        AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        AppConstants.printLog(response.body);
        AppConstants.printLog('video-view-click');
      });
    }
  }

  Future<void> videoDownloadClickLog() async {
    // AppConstants.showLoaderDialog(context);
    {
      var body = {
        "user": {
          "name": userName,
          "email": userEmail,
          "mobile": userMobile
        },
        "device": {
          "model": deviceModel,
          "make": deviceMake,
          "os": deviceOS
        },
        "app": {
          "version_name": versionName,
          "version_code": versionCode
        },
        "type": "content-log",
        "content-type": "video-download",
        "course": {
          "name":AppConstants.myCourseName,
          "id": AppConstants.myCourseId
        },
        "content": {
          "timeline_name": widget.title.toString(),
          "timeline_id": widget.vid.toString()
        }
      };
      Map<String, String> header = {
        "x-auth-token": AppConstants.serviceLogToken,
        "Content-Type": "application/json",
        "app-version":AppConstants.versionCode
      };
      AppConstants.printLog(body);
      await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((
          response) {
       // AppConstants.printLog(header);
        AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        AppConstants.printLog(response.body);
        AppConstants.printLog('video-downloading-click');
      });
    }
  }
}
