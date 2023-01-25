
import 'package:exampur_mobile/presentation/home/FreeVideos/freeVideoListing.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/free_video_model.dart';
import '../../widgets/custom_tab_bar.dart';


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

  @override
  void initState() {
    getFreeCourseTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration.zero, () => getFreeCourseTab()),
    builder: (context, snapshot) {
          return Scaffold(
            body: isLoading ? Center(child: CircularProgressIndicator()): MyCourseTabBar(
              length: freeVideoTabtModel!.length,
              names:freeVideoTabtModel!.map((item) => item.name.toString()).toList(),
              title: '',
              routes: freeVideoTabtModel!.map((e) => FreeVideoListing()).toList()

            ),
          );
    });
  }

}
