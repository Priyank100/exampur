import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/one_two_one_card.dart';
import 'package:flutter/material.dart';

import 'one2onelistview.dart';

class One2onelist extends StatefulWidget {
  const One2onelist({Key? key}) : super(key: key);

  @override
  _One2onelistState createState() => _One2onelistState();
}

class _One2onelistState extends State<One2onelist> {
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
              padding: const EdgeInsets.only(left: 14.0),
              child: Text('Exampur One2One',
                style: CustomTextStyle.headingBold(context),
              ),
            ),
            SizedBox(height: 5,),
            One2OneListView()
          ],
        ),

    );
  }
}
