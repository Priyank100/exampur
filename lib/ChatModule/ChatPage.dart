import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChatPage extends StatefulWidget {

  const ChatPage() : super();

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String collectionName = 'live_chat';
  String userName = '';
  String userPhone = '';
  String videoId = '12345';
  String videoTitle = 'qwerty';
  TextEditingController _sendchat = TextEditingController();
  Map<String, dynamic> map = Map();
//ScrollController _scrollController = new ScrollController();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  final ScrollController _scrollController = ScrollController();
  bool _muted = false;
  bool _isPlayerReady = false;

  String viedo ='https://www.youtube.com/watch?v=bYm3rA83-SU';
  @override
  void initState() {
    getChat();
    getSharedPrefData();
    String videoId = (YoutubePlayer.convertUrlToId(viedo.toString()) == null)
        ? "errorstring"
        : YoutubePlayer.convertUrlToId(viedo.toString())!;

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




  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(
        await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    userPhone = jsonValue[0]['data']['phone'].toString();
    setState(() {});
  }
  Future<bool> checkIfDocExists(String docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance.collection(collectionName);
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addVideoTitle(String text) async {
    String time = DateFormat('hh:mm a').format(DateTime.now());
    if(text.isNotEmpty) {

      bool docExists = await checkIfDocExists(videoId);

      if(docExists) {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance.collection(collectionName).doc(videoId).update(
            {
              'chat.$userName-$userPhone-$time': text
            }).then((value) {
          _sendchat.text = '';
          setState(() {});
        });

      } else {
        FirebaseFirestore.instance.collection(collectionName).doc(videoId).set(
            {
              'id': videoId,
              'title': videoTitle,
              'chat': {
                '$userName-$userPhone-$time': text
              }
            }, SetOptions(merge : false)).then((value) {
          _sendchat.text = '';
          setState(() {});
        });
      }
    } else {
      AppConstants.showBottomMessage(context, 'Enter message', AppColors.black);
    }
  }

  void getChat() {
    map.clear();
    try {
      FirebaseFirestore.instance
          .collection(collectionName)
          .where("id", isEqualTo: videoId)
          .snapshots()
          .listen((result) {
        result.docChanges.forEach((res) {
          map.addAll(res.doc.data()!['chat']);
          AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          AppConstants.printLog(map);
          setState(() {
            _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut
            );
          });
        });
      });
    } catch(ex) {
      AppConstants.printLog(ex.toString());
    }
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
      builder: (context, player) =>
          Scaffold(
        resizeToAvoidBottomInset: false,


        appBar:CustomAppBar()
        ,
        body:  SingleChildScrollView(
          controller:  _scrollController,
          physics: ScrollPhysics(),
        // physics:ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15,bottom: 5),
                  child: Text('Title'+' || '+'title',style: TextStyle(fontSize: 18),),
                ),
                Divider(thickness: 1,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(getTranslated(context, StringConstant.LiveChat)!,style: TextStyle(fontSize: 18)),
                ),
                Divider(thickness: 1,),
                Container(
                  margin: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.width,
                  child:
                  ListView.builder(
                    itemCount: map.length,
                    //scrollDirection: Axis.vertical,
                   //physics: BouncingScrollPhysics(),

                    shrinkWrap: true,

                    itemBuilder: (BuildContext context, int index) {
                      String key = map.keys.elementAt(index);

                      var parts = key.split('-');
                      var name = parts[0].trim();
                      var times =parts[1].trim();
                     // var time =times[2].trim();
                     //  var sec = times.split(':');
                     //  var second1 = sec[0].trim();
                     //  var second2 = sec[2].trim();
                      return new Column(
                        children: <Widget>[
                          Container(
                           // height: 45,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 12,top: 5,right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      new Text(name,style: TextStyle(fontSize: 12,color: AppColors.green),),
                                      new Text(times,style: TextStyle(color: AppColors.grey,fontSize: 12),),

                                    ],
                                  ),
                                Text("${map[key]}")
                              ],),
                            )
                          ),

                          new Divider(
                            height: 2.0,
                          ),
                        ],
                      );
                    },
                  ),
                )



              ],
            ),
        ),
            bottomNavigationBar: Container(
                padding: MediaQuery.of(context).viewInsets,
                color: AppColors.transparent,
                child:  Row(
        children: [
          Expanded(child: CustomTextField(

              hintText: getTranslated(context, StringConstant.TypeYourDoubtHere)!,
              controller: _sendchat,
              value: (value) {}),
          ),
          
          InkWell(
      onTap: () {
       FocusScope.of(context).unfocus();
       //_animateToIndex(height) => _scrollController.animateTo(height, duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
      addVideoTitle(_sendchat.text.toString());
    },
            child: Container(
             // padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
              height: 45,
              width: 90,
              decoration: BoxDecoration(color: AppColors.amber,borderRadius:  BorderRadius.all(const Radius.circular(8)),),

                child: Center(child: Text(getTranslated(context, StringConstant.Send)!,style: TextStyle(color: AppColors.white),))
            ),
          )

        ],
      ),)
            ),

    );

  }

  // void scrollToBottom() {
  //   final bottomOffset = _scrollController.position.maxScrollExtent;
  //   _scrollController.animateTo(
  //     bottomOffset,
  //     duration: Duration(milliseconds: 1000),
  //     curve: Curves.easeInOut,
  //   );
 // }
}