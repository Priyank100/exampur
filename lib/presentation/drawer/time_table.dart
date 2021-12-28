import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/video_card_app_tutorial.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTimeTable extends StatefulWidget {
  MyTimeTable({
    Key? key,
  }) : super(key: key);

  @override
  _MyTimeTableState createState() => _MyTimeTableState();
}

class _MyTimeTableState extends State<MyTimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.FONT_SIZE_SMALL,bottom: Dimensions.FONT_SIZE_SMALL),
                  child: Text(
                    'My Purcahses',
                    style: CustomTextStyle.headingBigBold(context),
                  ),
                ),],
            )));
  }
}
