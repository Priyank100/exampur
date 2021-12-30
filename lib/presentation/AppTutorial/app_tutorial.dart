import 'package:exampur_mobile/data/model/app_tutorial_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial_card.dart';
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
  List<AppTutorialModel> list = [];

  @override
  void initState() {
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(AppTutorialModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: list.length == 0
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.FONT_SIZE_SMALL,
                        bottom: Dimensions.FONT_SIZE_SMALL),
                    child: Text(
                      'App Tutorial',
                      style: CustomTextStyle.headingBigBold(context),
                    ),
                  ),
                  ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AppTutorialCard(list, index);
                      }),
                ],
              )
        )
    );
  }
}
