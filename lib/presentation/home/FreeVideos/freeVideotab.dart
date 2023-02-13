
import 'package:exampur_mobile/presentation/home/FreeVideos/freeVideoListing.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/utils/analytics_constants.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/free_video_model.dart';
import '../../../utils/app_constants.dart';


class FreeVideosTab extends StatefulWidget {

  FreeVideosTab() : super();

  @override
  State<FreeVideosTab> createState() => _FreeVideosTabState();
}

class _FreeVideosTabState extends State<FreeVideosTab> {
  List<FreeVideoModel> ? freeVideoTabtModel;
  bool isLoading = true;

  Future<void> getFreeCourseTab() async {
    freeVideoTabtModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoTab(context))!;
    isLoading = false;
    setState((){});
  }

  void gettab(){}
  @override
  void initState() {
    var map = {
      'Page_Name':'channel_page_landed',
      'Mobile_Number':AppConstants.userMobile,
      'Language':'en',
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.channel_page_landed, map);
   getFreeCourseTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: isLoading ? Center(child: CircularProgressIndicator()):
            MyCourseTabBar(
              length: freeVideoTabtModel!.length,
              names:freeVideoTabtModel!.map((item) => item.name.toString()).toList(),
              title: '',
              routes: freeVideoTabtModel!.map((e) => FreeVideoListing(e.id.toString())).toList()

            ),
          );

  }

}
