import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/couses_container.dart';
import 'package:exampur_mobile/shared/test_series_card.dart';
import 'package:exampur_mobile/shared/video_card_app_tutorial.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideosCA extends StatefulWidget {
  @override
  _VideosCAState createState() => _VideosCAState();
}

class _VideosCAState extends State<VideosCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Featured Course',  style: CustomTextStyle.headingBold(context),),
          ),
         // ContainerwithBuyandView()
        ],
      ),
    ));
  }
}

