import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:flutter/material.dart';

import 'offlinebatchesview.dart';

class OfflineBatchesExam extends StatefulWidget {
  const OfflineBatchesExam({Key? key}) : super(key: key);

  @override
  _OfflineBatchesExamState createState() => _OfflineBatchesExamState();
}

class _OfflineBatchesExamState extends State<OfflineBatchesExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: InkWell(onTap:(){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text('Offline Batches',
                style: CustomTextStyle.headingBold(context),
              ),
            ),
            SizedBox(height: 5,),
            OfflineBatches()
          ],
        ),

    );
  }
}
