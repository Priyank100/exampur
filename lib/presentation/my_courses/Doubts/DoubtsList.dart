import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/api.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class DoubtsPage extends StatefulWidget {
  final  String token;
  const DoubtsPage(this.token) : super();

  @override
  State<DoubtsPage> createState() => _DoubtsPageState();
}

class _DoubtsPageState extends State<DoubtsPage> {
  getDocumentData () async {
    final QuerySnapshot result =
    await FirebaseFirestore.instance.collection('doubts_courses_id').get();
    final List<DocumentSnapshot> documents = result.docs;
    documents.forEach((data) {
      print(data.id);
      print('anchal');
    }
    );
  }
  @override
  void initState() {
    super.initState();
    getDocumentData();
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
                  AppConstants.makeCallEmail(API.doubtsUrl.replaceAll('TOKEN', widget.token));
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
}
