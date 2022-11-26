import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/custom_bottomsheet.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';


class DoubtsPage extends StatefulWidget {
  final String token;
  final String firebaseId;
  final String purchase;
  const DoubtsPage(this.token, this.firebaseId, this.purchase) : super();

  @override
  State<DoubtsPage> createState() => _DoubtsPageState();
}

class _DoubtsPageState extends State<DoubtsPage> with WidgetsBindingObserver {
  String courseId = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var nativeData;

  Future<Map<String, dynamic>> firebaseGetData({required String documentID}) async {
    DocumentSnapshot ds = await _firestore.collection("doubts_courses_id").doc(documentID).get();
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;

    setState(() {
      courseId = data["id"];
    });
    return data;

  }
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    firebaseGetData( documentID: widget.firebaseId);
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if(nativeData != null && nativeData == 'Done')
        ModalBottomSheet.moreModalBottomSheet(context);
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

            SizedBox(height: 30),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2,
              onPressed: () async {
                if(courseId.isEmpty || courseId == null){
                  AppConstants.showBottomMessage(context, 'Something Wrong', Colors.red);
                }else{
                  // print('>>>>>>>>>>>>>>');
                  // print(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', courseId).replaceAll('TF', widget.purchase));
                  nativeData = await AppConstants.platform.invokeMethod(API.doubtsUrl.replaceAll('TOKEN', widget.token).replaceAll('id', courseId).replaceAll('TF', widget.purchase));
                  setState((){});
                }
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
}
