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
  final contentCatId;
  const CurrentAffairs(this.type, this.contentCatId) : super();

  @override
  CurrentAffairsState createState() => CurrentAffairsState();
}

class CurrentAffairsState extends State<CurrentAffairs> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<Data> videoList = [];
  List<Data> contentList = [];
  bool isLoading = false;

  Future<List> getVideosList() async {
    isLoading = true;
    videoList = (await Provider.of<CaProvider>(context, listen: false)
        .getCaSmList(context, widget.contentCatId, 'video', AppConstants.encodeCategory()))!;
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
          contentList = (await Provider.of<CaProvider>(context, listen: false)
              .getCaSmList(context, widget.contentCatId, 'content', AppConstants.encodeCategory()))!;
          isLoading = false;
          break;
      }
      setState(() {});
    });
  }

  @override
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
                  title: widget.type.toString())
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
