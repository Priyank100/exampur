
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class One2OneVideo extends StatefulWidget {
  final One2OneCourses one2oneList;

  const One2OneVideo(this.one2oneList) : super();

  @override
  _One2OneVideoState createState() => _One2OneVideoState();
}

class _One2OneVideoState extends State<One2OneVideo> {
  bool flag = true;
  late String firstHalf;
  late String secondHalf;
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    if ( widget.one2oneList.description!.length > 150) {
      firstHalf = widget.one2oneList.description! .substring(0, 150);
      secondHalf = widget.one2oneList.description! .substring(150,  widget.one2oneList.description! .length);
    } else {
      firstHalf =  widget.one2oneList.description! ;
      secondHalf = "";
    }
    String videoId = (YoutubePlayer.convertUrlToId(widget.one2oneList.videoPath.toString()) == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId(widget.one2oneList.videoPath.toString())!;

    _controller = YoutubePlayerController(
      initialVideoId: videoId, //widget.url,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        //forceHD: widget.fullHD ??= false,
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
    // Pauses video while navigating to next page.
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
    return YoutubePlayerBuilder(
      // onExitFullScreen: () {
      //   // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },

      player: YoutubePlayer(
        //aspectRatio: 19 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          //todo: change video quality
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        // onEnded: (data) {
        //   _showSnackBar('Video over!');
        // },
      ),
      builder: (context, player) => Scaffold(
        appBar:CustomAppBar()
        ,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.one2oneList.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),

            Container(
              padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: secondHalf.isEmpty
                  ? new Text(firstHalf, style: new TextStyle(color: AppColors.grey,fontSize: 12),)
                  : new Column(
                children: <Widget>[
                  new Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf), style: new TextStyle(color: AppColors.grey600,fontSize: 13),),
                  new InkWell(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          flag ? getTranslated(context, StringConstant.showmore) !: getTranslated(context, StringConstant.showless) !,
                          style: new TextStyle(color: AppColors.blue300,fontSize: 12),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],

            )

        ),




            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: RichText(
            //     text: TextSpan(
            //        // style: CustomTextStyle.headingSemiBold(context),
            //         text: widget.paidcourseList.title.toString()),
            //   ),
            // ),
            // SizedBox(height: 5),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
            //   child: RichText(
            //     text: TextSpan(
            //         //style: CustomTextStyle.subHeading2(context),
            //         ),
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar:MediaQuery.of(context).orientation == Orientation.landscape ?  null: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  '\u{20B9}',
                  style: TextStyle(color: AppColors.black, fontSize: 25),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                widget.one2oneList.regularPrice.toString(),
                  style: TextStyle(color: AppColors.grey, fontSize: 18,decoration: TextDecoration.lineThrough),
                ),
                SizedBox(width: 5,),
                Text(
                  widget.one2oneList.salePrice.toString(),
                  style: TextStyle(color: AppColors.black, fontSize: 18),
                ),
              ],
            ),


          ],
        ),
      ),
      ),
    );
}
}
