import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/api.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/delivery_detail_screen_param.dart';
import '../../../utils/lang_string.dart';
import '../../widgets/custom_bottomsheet.dart';


class DoubtsPage extends StatefulWidget {
  final  String token;
  final  String webId;
  final String purchase;
  const DoubtsPage(this.token,this.webId,this.purchase) : super();

  @override
  State<DoubtsPage> createState() => _DoubtsPageState();
}

class _DoubtsPageState extends State<DoubtsPage> with WidgetsBindingObserver {
  var nativeData;
  // String courseId = '';

  // getDocumentData () async {
  //   print('anchal');
  //   final DocumentReference result =
  //   await FirebaseFirestore.instance.collection('doubts_courses_id').doc('6254b133b2097d80b3af932d');
  // }
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //
  // Future<Map<String, dynamic>> firebaseGetData({required String documentID}) async {
  //   DocumentSnapshot ds =
  //   await _firestore.collection("doubts_courses_id").doc(documentID).get();
  //   Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
  //
  //   setState(() {
  //     courseId = data["id"];
  //   });// check if it null or not
  //   return data;
  //
  // }
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
   // firebaseGetData( documentID: widget.firebaseId);
    var map ={
      'Page_Name':'My_Courses_Doubts',
      'Course_Name':AppConstants.courseName,
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : AppConstants.mycourseType == 1?'Free_Course':'Demo'
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.My_Courses_Doubts,map);
  }
   // void getmethod(){
   //   AppConstants.platform.setMethodCallHandler((call)async{
   //     // you can get hear method and passed arguments with method
   //     if(call.method == 'flutter.native/helper'){
   //       print('>>>>>>>>>>>>>>>>>>>>');
   //       print(call.arguments);
   //     }
   //
   //     return null;
   //   });
   // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if(nativeData != null && nativeData == 'Done') {
        var analytics = {
          'Page_Name': 'Doubts Page',
          'Course_Category': AppConstants.paidTabName,
          'Course_Name': SamplingBottomSheetParam.getDeliveryDetailParam['title'].toString(),
          'Mobile_Number': AppConstants.userMobile,
          'Language': AppConstants.langCode,
          'User_ID': AppConstants.userMobile,
        };
        AnalyticsConstants.trackEventMoEngage(
            AnalyticsConstants.Click_Doubts_Unlock_Sampling, analytics);
        ModalBottomSheet.moreModalBottomSheet(context, 'DoubtPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
               padding: const EdgeInsets.only(left: 20.0,right: 20),
               child: Text(getTranslated(context, LangString.doubtstext)!,style: TextStyle(fontSize: 19), textAlign: TextAlign.center,
            ),
             ),

            SizedBox(height: 30,),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2,
              onPressed: () async {
                var map ={
                  'Page_Name':'My_Courses_Doubts',
                  'Course_Name':AppConstants.courseName,
                  'Mobile_Number':AppConstants.userMobile,
                  'Language':AppConstants.langCode,
                  'User_ID':AppConstants.userMobile,
                  'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : AppConstants.mycourseType == 1?'Free_Course':'Demo'
                };
                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Ask_Doubts,map);

                if(widget.webId.isEmpty || widget.webId == null){
                  showBottomMessage(context, 'Something Wrong', Colors.red);
                }else{
                     AppConstants.printLog(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', widget.webId).replaceAll('TF', widget.purchase))   ;
                    // AppConstants.platform.invokeMethod(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', widget.webId));
                     nativeData = await AppConstants.platform.invokeMethod(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', widget.webId).replaceAll('TF', widget.purchase));
                     setState((){});
                }

                //AppConstants.makeCallEmail(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', courseId));
                // AppConstants.goTo(context, DoubtWebview(API.doubtsUrl,widget.token));
              },
              color: AppColors.amber,
              child: Text(
               getTranslated(context,  LangString.askdoubts)!,
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
