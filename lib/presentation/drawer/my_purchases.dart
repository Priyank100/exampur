import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/video_card_app_tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPurchases extends StatefulWidget {
  MyPurchases({
    Key? key,
  }) : super(key: key);

  @override
  _MyPurchasesState createState() => _MyPurchasesState();
}

class _MyPurchasesState extends State<MyPurchases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text("Logo", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "My Purchases",
                          style: CustomTextStyle.headingBold(context),
                        ))
                  ],
                ))),
        body: SingleChildScrollView(
            child: Column(
          children: [Text("My Purcahses")],
        )));
  }
}
