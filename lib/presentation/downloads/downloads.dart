import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/downloads/pdf_downloads.dart';
import 'package:exampur_mobile/presentation/downloads/video_downloads.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Downloads extends StatefulWidget {
  @override
  DownloadsState createState() => DownloadsState();
}

class DownloadsState extends State<Downloads> with SingleTickerProviderStateMixin {
  late TabController _controller;
  String testVideoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
  var progressString = "";

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);

    _controller.addListener(() async {
      AppConstants.printLog("Selected Index: " + _controller.index.toString());
      switch(_controller.index) {
        case 0:
          getDownloadingVideosList();
          break;
        case 1:
          getDownloadingPdfList();
          break;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDownloadingVideosList(),
    builder: (context, snapshot) {
      return Scaffold(
        body: TabBarDemo(
          // controller: _controller,
            length: 2,
            names: [
              "Videos",
              "PDFs",
            ],
            routes: [
              DownloadedVideo(),
              DownloadedPdf()
            ],
            title: getTranslated(context, StringConstant.downloads)!),
      );
    });
  }

  Future<List> getDownloadingVideosList() async {
    List<String> list = [];
    return list;
  }

  Future<List> getDownloadingPdfList() async {
    List<String> list = [];
    return list;
  }
}
