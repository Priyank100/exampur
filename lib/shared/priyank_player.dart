import 'dart:async';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class PriyankPlayer extends StatefulWidget {
  final String appBarTitle;
  final String url;
  const PriyankPlayer(this.appBarTitle, this.url) : super();

  @override
  State<PriyankPlayer> createState() => _PriyankPlayerState();
}

class _PriyankPlayerState extends State<PriyankPlayer> {
  late VideoPlayerController _playerController;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  int _time = 4;
  bool controllerVisibility = true;
  bool isFullscreen = false;

  @override
  void initState() {
    _playerController = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
    _playerController.addListener(() {
      if (isFullscreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
    _playerController.setPlaybackSpeed(1.0);
    _playerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: isFullscreen ? null : AppBar(title: Text(widget.appBarTitle)),
      body: _playerController.value.isInitialized ?
      AspectRatio(
          aspectRatio: 3/4,
          child: Stack(
              children: [
                player(),
                centerController(),
                bottomController()
              ]
          )
      )
          : Center(child: CircularProgressIndicator(color: AppColors.amber))
      );
  }

  Widget player() {
    return InkWell(
      onTap: () {
        setState(() {
          if(controllerVisibility) {
            controllerVisibility = false;
            _timer.cancel();
          } else {
            controllerVisibility = true;
            startTimer();
          }
        });
      },
      child: VideoPlayer(_playerController),
    );
  }

  Widget centerController() {
    return Center(
      child: controllerVisibility ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              onTap: () {
                _playerController.seekTo(Duration(
                    seconds: _playerController.value.position.inSeconds - 10));
                },
              child: const Icon(Icons.replay_10_rounded, color: AppColors.grey, size: 30)
          ),
          InkWell(
              onTap: () {
                setState(() {
                  if(_playerController.value.isPlaying) {
                    _playerController.pause();
                    startTimer();

                  } else {
                    _playerController.play();
                    startTimer();
                  }
                });
              },
              child: Icon(_playerController.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: AppColors.grey, size: 50)
          ),
          InkWell(
              onTap: () {
                _playerController.seekTo(Duration(
                    seconds: _playerController.value.position.inSeconds + 10));
              },
              child: const Icon(Icons.forward_10_outlined, color: AppColors.grey, size: 30)
          ),
        ],
      ) : SizedBox()
    );
  }

  Widget bottomController() {
    return controllerVisibility ? Positioned(
        bottom: 0.0,
        right: 0.0,
        left: 0.0,
        child: Container(
          color: AppColors.black.withOpacity(0.5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            children: [
              progressBar(),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                      child: playbackTime()
                  ),
                  playSpeedButton(),
                  SizedBox(width: 5),
                  fullscreenButton(),
                ],
              )
            ],
          ),
        )
    ) : SizedBox();
  }

  Widget progressBar() {
    return VideoProgressIndicator(
      _playerController,
      allowScrubbing: true,
      colors: const VideoProgressColors(
          backgroundColor: AppColors.grey,
          bufferedColor: AppColors.blueGrey,
          playedColor: AppColors.amber),
    );
  }

  Widget playbackTime() {
    return ValueListenableBuilder(
      valueListenable: _playerController,
      builder: (context, VideoPlayerValue value, child) {
        return Text(formatDuration(value.position) + ' / ' + formatDuration(value.duration),
            style: TextStyle(fontSize: 10, color: AppColors.white));
      },
    );
  }

  Widget fullscreenButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isFullscreen = !isFullscreen;
          isFullscreen ? SystemChrome.setEnabledSystemUIOverlays([]) : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
        });
      },
      child: Icon(isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: AppColors.white),
    );
  }

  Widget playSpeedButton() {
    return DropdownButton<VideoSpeed>(
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
    );
  }

  void startTimer() {
    _time = 4;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec, (Timer timer) {
        if (_time == 0) {
          setState(() {
            controllerVisibility = false;
            timer.cancel();
          });
        } else {
          setState(() {
            _time--;
          });
        }
      },
    );
  }

  String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds~/Duration.secondsPerDay;
    seconds -= days*Duration.secondsPerDay;
    final hours = seconds~/Duration.secondsPerHour;
    seconds -= hours*Duration.secondsPerHour;
    final minutes = seconds~/Duration.secondsPerMinute;
    seconds -= minutes*Duration.secondsPerMinute;


    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days.toString().padLeft(2, '0')}');
    }
    if (tokens.isNotEmpty || hours != 0){
      tokens.add('${hours.toString().padLeft(2, '0')}');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes.toString().padLeft(2, '0')}');
    }
    tokens.add('${seconds.toString().padLeft(2, '0')}');

    return tokens.join(':');
  }

  void changeSpeed(VideoSpeed videoSpeed) {
    setState(() {
      _playerController.setPlaybackSpeed(videoSpeed.speed);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _playerController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
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
