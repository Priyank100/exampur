import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/ChatModule/attendance_controller.dart';
import 'package:exampur_mobile/ChatModule/live_attendance.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class MyTimeTableVideo extends StatefulWidget {
  String url;
  String title;
  String videoId;
  MyTimeTableVideo(this.url,this.title,this.videoId) : super();

  @override
  _MyTimeTableVideoState createState() => _MyTimeTableVideoState();
}

class _MyTimeTableVideoState extends State<MyTimeTableVideo> {
  String docId = 'Exampur';
  String mainCollection = 'live_class';
  String docChat = 'chat';
  String docAttendance = 'attendance';
  String userName = '';
  String userPhone = '';
  String videoTitle = '';
  TextEditingController _sendchat = TextEditingController();
  Map<String, dynamic> map = Map();
  FlickManager? flickManager;

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection(mainCollection);
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> checkIfCollectionExist(String docName, String collectionName) async {
    var value = await FirebaseFirestore.instance
        .collection(mainCollection)
        .doc(docName)
        .collection(collectionName)
        .limit(1)
        .get();
    return value.docs.isNotEmpty;
  }

  Future<void> addVideoTitle(String text) async {
    if(text.isNotEmpty) {
      bool docExists = await checkIfCollectionExist(docChat, widget.videoId);

      if(docExists) {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance.collection(mainCollection).doc(widget.videoId).update(
            {
              'chat.$userName-$userPhone-${Timestamp.now()}': text
            }).then((value) {
          _sendchat.text = '';
          setState(() {
            map = SplayTreeMap<String,dynamic>.from(map, (a, b) => a.split('-')[2].trim().compareTo(b.split('-')[2].trim()));
          });
        });

      } else {
        FirebaseFirestore.instance.collection(mainCollection).doc(docChat).collection(widget.videoId).doc().set(
            {
              'id': widget.videoId,
              'title': widget.title.toString(),
              'createdAt':Timestamp.now(),

              // 'chat': {
              //   '$userName-$userPhone-${Timestamp.now()}': text
              // }
            }, SetOptions(merge : false)).then((value) {
          _sendchat.text = '';
          setState(() {
            map = SplayTreeMap<String,dynamic>.from(map, (a, b) => a.split('-')[2].trim().compareTo(b.split('-')[2].trim()));
          });
        });
      }
    } else {
      AppConstants.showBottomMessage(context, 'Enter message', AppColors.black);
    }
  }

  Future<void> markAttendance() async {
    bool collectionExists = await checkIfCollectionExist(docAttendance, widget.videoId);

    if(collectionExists) {
      FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection(mainCollection).doc(docAttendance).collection(widget.videoId).doc(docId).update(
          {
            'attendance.$userName':'$userPhone'
          }).then((value) {
        // setState(() {});
      });
    } else {
      FirebaseFirestore.instance.collection(mainCollection).doc(docAttendance).collection(widget.videoId).doc(docId).set(
          {
            'id': widget.videoId,
            'title': widget.title.toString(),
            'attendance':{
              '$userName':'$userPhone',
            }
          }, SetOptions(merge : false)).then((value) {
        // setState(() {});
      });
    }
  }

  void getChat() {
    map.clear();
    try {
      FirebaseFirestore.instance
          .collection(mainCollection)
          .where("id", isEqualTo: widget.videoId)
          .snapshots()
          .listen((result) {
        result.docChanges.forEach((res) {
          map.addAll(res.doc.data()!['chat']);
          // AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          // AppConstants.printLog(map);
          setState(() {});
        });
      });

      map = SplayTreeMap<String,dynamic>.from(map, (a, b) => a.split('-')[2].trim().compareTo(b.split('-')[2].trim()));
      setState(() {});

    } catch(ex) {
      AppConstants.printLog(ex.toString());
    }
  }

  Future<void> getSharedPrefData() async {
    var jsonValue = jsonDecode(
        await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    userPhone = jsonValue[0]['data']['phone'].toString();
    markAttendance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getChat();
    getSharedPrefData();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          physics:ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: (MediaQuery.of(context).size.width)/16*9,
                child: FlickVideoPlayer(
                  flickManager: flickManager!,
                  flickVideoWithControls: const FlickVideoWithControls(
                    controls: const FlickPortraitControls(isLive: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child:   Text(widget.title,style: TextStyle(fontSize: 15),),
              ),
              Divider(thickness: 1,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(getTranslated(context, StringConstant.LiveChat)!,style: TextStyle(fontSize: 18)),
              ),
              Divider(thickness: 1,),
              Container(
                height: MediaQuery.of(context).size.height*0.43,
                //height: 400,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child:
                ListView.builder(
                  itemCount: map.length,
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    String key = map.keys.elementAt(map.length-1-index);
                    var parts = key.split('-');
                    var name = parts[0].trim();
                    var mobile = parts[1].trim();
                    var times =parts[2].trim();

                    var sec = times.split(':');
                    var second1 = sec[0].trim();
                    var second2 = sec[1].trim();
                    return new Column(
                      children: <Widget>[
                        Container(
                          //height: 40,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 12,top: 5,right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      new Text(name,style: TextStyle(fontSize: 12,color: AppColors.green),),
                                      new Text(second1+':'+second2,style: TextStyle(color: AppColors.grey,fontSize: 12),),
                                    ],
                                  ),
                                  Text("${map[key]}",style: TextStyle(fontSize: 14))
                                ],),
                            )
                        ),

                        new Divider(
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
              Expanded(
                child: CustomTextField(
                  hintText: getTranslated(context, StringConstant.TypeYourDoubtHere)!,
                  controller: _sendchat,
                  value: (value) {}
                ),
              ),

              InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  addVideoTitle(_sendchat.text.toString());
                },
                child: Container(
                    margin: EdgeInsets.all(8),
                    height: 45,
                    width: 90,
                    decoration: BoxDecoration(color: AppColors.amber,borderRadius:  BorderRadius.all(const Radius.circular(8)),),
                    child: Center(child: Text(getTranslated(context, StringConstant.Send)!,style: TextStyle(color: AppColors.white),))
                ),
              )
            ],
          ),
        )
    );
  }

  @override
  void dispose() {
    flickManager!.dispose();
    super.dispose();
  }
}


