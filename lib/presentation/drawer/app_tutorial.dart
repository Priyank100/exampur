import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/video_card_app_tutorial.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTutorial extends StatefulWidget {
  AppTutorial({
    Key? key,
  }) : super(key: key);

  @override
  _AppTutorialState createState() => _AppTutorialState();
}

class _AppTutorialState extends State<AppTutorial> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //     appBar: AppBar(
    //         iconTheme: IconThemeData(
    //           color: Colors.black,
    //         ),
    //         centerTitle: true,
    //         title:  Image.asset(Images.exampur_title,
    //             width: Dimensions.ICON_SIZE_Title,
    //             height: Dimensions.ICON_SIZE_Title,
    //         ),
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //         bottom: PreferredSize(
    //             preferredSize: Size.fromHeight(35.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 15),
    //                   child: Text(
    //                     "App Tutorial",
    //                     style: CustomTextStyle.headingBigBold(context),
    //                   ))],
    //             ))
    // ),
      appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.FONT_SIZE_SMALL,bottom: Dimensions.FONT_SIZE_SMALL),
                  child: Text(
                    'App Tutorial',
                    style: CustomTextStyle.headingBigBold(context),
                  ),
                ),
            VideoCardAT()],
        )));
  }
}
