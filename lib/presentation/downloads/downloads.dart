import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/download_model.dart';
import 'package:exampur_mobile/presentation/downloads/pdf_downloads.dart';
import 'package:exampur_mobile/presentation/downloads/video_downloads.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Downloads extends StatefulWidget {
  final int selectedIndex;
  const Downloads(this.selectedIndex) : super();

  @override
  DownloadsState createState() => DownloadsState();
}

class DownloadsState extends State<Downloads> with SingleTickerProviderStateMixin {
  List<Download> tabList = [];
  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/downloadlist.json');
  }
  late TabController _controller;

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final BookResponse = downloadModelFromJson(jsonString);
    tabList = BookResponse.download!;
    _controller = TabController(length: tabList.length, vsync: this);
    _controller.index = widget.selectedIndex;
      _controller.addListener(() {
        setState(() {
          _controller.index = widget.selectedIndex;
        });

        AppConstants.printLog("Selected Index: " + _controller.index.toString());
        switch(_controller.index) {
          case 0:
            DownloadedVideo();
            break;
          case 1:
            DownloadedPdf();
            break;
        }
      });
    setState(() {});
  }

  @override
  void initState() {
    getTabList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getTabList()),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                controller: _controller,
                  length: tabList.length,
                  names: tabList.map((item) => item.name.toString()).toList(),
                  routes: tabList.length == 0 ? [] : [
                    DownloadedVideo(),
                                DownloadedPdf()
                  ],
                  title: getTranslated(context, StringConstant.downloads)!)
          );
        });
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //       future: getDownloadingVideosList(),
  //   builder: (context, snapshot) {
  //     return Scaffold(
  //       body: TabBarDemo(
  //         // controller: _controller,
  //           length: 2,
  //           names: [
  //             "Videos",
  //             "PDFs",
  //           ],
  //           routes: [
  //             DownloadedVideo(),
  //             DownloadedPdf()
  //           ],
  //           title: getTranslated(context, StringConstant.downloads)!),
  //     );
  //   });
  // }
  //
  // Future<List> getDownloadingVideosList() async {
  //   List<String> list = [];
  //   return list;
  // }
  //
  //
  // Future<List> getDownloadingPdfList() async {
  //   List<String> list = [];
  //   return list;
  }
}
