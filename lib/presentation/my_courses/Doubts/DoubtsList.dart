import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/api.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';


class DoubtsPage extends StatefulWidget {
  final  String token;
  final  String firebaseId;
  const DoubtsPage(this.token,this.firebaseId) : super();

  @override
  State<DoubtsPage> createState() => _DoubtsPageState();
}

class _DoubtsPageState extends State<DoubtsPage> {
  String courseId = '';

  // getDocumentData () async {
  //   print('anchal');
  //   final DocumentReference result =
  //   await FirebaseFirestore.instance.collection('doubts_courses_id').doc('6254b133b2097d80b3af932d');
  // }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<Map<String, dynamic>> firebaseGetData({required String documentID}) async {
    DocumentSnapshot ds =
    await _firestore.collection("doubts_courses_id").doc(documentID).get();
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

    print(data["id"]);
    setState(() {
      courseId = data["id"];
    });// check if it null or not
    return data;

  }
  @override
  void initState() {
    super.initState();
    firebaseGetData( documentID: widget.firebaseId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2,
              onPressed: () {
                if(courseId.isEmpty || courseId == null){
                  showBottomMessage(context, 'Something Wrong', Colors.red);
                }else{
                  AppConstants.platform.invokeMethod(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', courseId));
                }

                //AppConstants.makeCallEmail(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', courseId));
                // AppConstants.goTo(context, DoubtWebview(API.doubtsUrl,widget.token));
              },
              color: AppColors.amber,
              child: Text(
                'Doubts',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void showBottomMessage(context, message, bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bgColor,
      duration: Duration(milliseconds: 700),
    ));
  }
}
