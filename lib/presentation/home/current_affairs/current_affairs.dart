import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_content_model.dart';
import 'package:exampur_mobile/data/model/video_ca_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/contents_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentAffairs extends StatefulWidget {
  final String type;
  const CurrentAffairs(this.type) : super();

  @override
  CurrentAffairsState createState() => CurrentAffairsState();
}

class CurrentAffairsState extends State<CurrentAffairs> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<VideoCaModel> videoList = [];
  List<CaContentModel> contentList = [];
  bool isLoading = false;

  Future<List> getVideosList() async {
    isLoading = true;
    // videoList = (await Provider.of<CaProvider>(context, listen: true).getCaVideoList(context))!;
    isLoading = false;
    return videoList;
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() async {
      switch(_controller.index) {
        case 0:
          getVideosList();
          break;
        case 1:
          isLoading = true;
          // contentList = (await Provider.of<CaProvider>(context, listen: false).getCaContentList(context))!;
          isLoading = false;
          break;
      }
      setState(() {});
    });

    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class 15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    videoList.add(VideoCaModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.no_image,
        title: '15 Days Free Foundation Batch Class'));
    contentList.add(CaContentModel(
      imagePath : Images.exampur_logo,
      title: '15 Days Free Foundation Batch Class',
      viewId: '123',
      viewCount: '100,000+',
      shareText: 'Current affairs daily'
    ));
    contentList.add(CaContentModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    contentList.add(CaContentModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
    contentList.add(CaContentModel(
        imagePath: Images.exampur_logo,
        title: '15 Days Free Foundation Batch Class 15 Days Free Foundation Batch Class',
        viewId: '123',
        viewCount: '100,000+',
        shareText: 'Current affairs daily'
    ));
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getVideosList(),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                  controller: _controller,
                  length: 2,
                  names: [
                    "Videos",
                    "Contents",
                  ],
                  routes: [
                    isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                    VideosCA(videoList),
                    isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                    ContentsCA(contentList)
                  ],
                  title: getTranslated(context, StringConstant.currentAffairs)!)
          );
        });
    // return Scaffold(
    //     body: CustomTabBar(
    //         length: 2,
    //         names: ["Videos", "Contents"],
    //         routes: [
    //           VideosCA(videoList),
    //           ContentsCA(contentList),
    //         ],
    //         title: widget.type
    //     )
    // );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
