import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/books_card.dart';
import 'package:exampur_mobile/shared/quiz_card_ca.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AttemptTestSeries extends StatefulWidget {
  const AttemptTestSeries({Key? key}) : super(key: key);

  @override
  _AttemptTestSeriesState createState() => _AttemptTestSeriesState();
}

class _AttemptTestSeriesState extends State<AttemptTestSeries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
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
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext , context){
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: QuizCardCA(),
                    );
                  }),
                )
                

              ],
            )));

  }
}
