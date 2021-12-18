import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/video_card_ca.dart';
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
            child: Text('Fetured Course',  style: CustomTextStyle.headingBold(context),),
          ),
          VideoCardCA()
        ],
      ),
    ));
  }
}

