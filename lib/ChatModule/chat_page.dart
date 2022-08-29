import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//---------------- Not Used ---------------------------------

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String collectionName = 'live_chat';
  String userName = 'Priyank';
  String videoId = '12345';
  String videoTitle = 'qwerty';
  TextEditingController _sendchat = TextEditingController();
  Map<String, dynamic> map = Map();


  @override
  void initState() {
    getChat();
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
    String time = DateFormat('hh:mm:ss a').format(DateTime.now());
    if(text.isNotEmpty) {

      bool docExists = await checkIfDocExists(videoId);

      if(docExists) {
        FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
        firestoreInstance.collection(collectionName).doc(videoId).update(
            {
              'chat.$userName-$time': text
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
                '$userName-$time': text
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
              map.addAll(res.doc.data()!);
              AppConstants.printLog(map);
              setState(() {});
            });
          });
    } catch(ex) {
      AppConstants.printLog(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Text('Chat'),

            // ListView.builder(
            //   itemCount: map.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     String key = map.keys.elementAt(index);
            //     return new Column(
            //       children: <Widget>[
            //         new ListTile(
            //           title: new Text("$key"),
            //           subtitle: new Text("${map[key]}"),
            //         ),
            //         new Divider(
            //           height: 2.0,
            //         ),
            //       ],
            //     );
            //   },
            // ),

            Row(
              children: [
                Expanded(child: CustomTextField(
                    hintText: "Type your doubt here",
                    controller: _sendchat,
                    value: (value) {}),
                ),
                MaterialButton(onPressed: () {
                  FocusScope.of(context).unfocus();
                  addVideoTitle(_sendchat.text.toString());
                  },
                child: Text('Send'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
