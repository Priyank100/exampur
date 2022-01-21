import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:exampur_mobile/shared/quiz_card_ca.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AttemptSeries extends StatefulWidget {
  const AttemptSeries({Key? key}) : super(key: key);

  @override
  _AttemptSeriesState createState() => _AttemptSeriesState();
}

class _AttemptSeriesState extends State<AttemptSeries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.transparent,
              elevation: 0,
              leading: InkWell(onTap:(){
                Navigator.pop(context);
              },child: Icon(Icons.arrow_back,color: AppColors.black)),
              title: Text(
                "Logo",
                style: TextStyle(color: AppColors.black),
              )),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Test Series',
                  style:  CustomTextStyle.headingBold(context),
                ),
                SizedBox(height: Dimensions.FONT_SIZE_SMALL,),
                QuizCardCA()
              ],
            )));

  }
}
