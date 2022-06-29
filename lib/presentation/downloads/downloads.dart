import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/download_model.dart';
import 'package:exampur_mobile/presentation/downloads/video_downloads.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'my_download_pdf.dart';

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
 TabController? _controller;

  void getTabList() async {
    String jsonString = await loadJsonFromAssets();
    final BookResponse = downloadModelFromJson(jsonString);
    tabList = BookResponse.download!;
    // _controller = TabController(length: tabList.length, vsync: this, initialIndex: widget.selectedIndex);
    _controller = TabController(length: tabList.length, vsync: this, initialIndex: 0);
    /*_controller!.index = widget.selectedIndex;
      _controller!.addListener(() {
        setState(() {
          _controller!.index = widget.selectedIndex;
        });

        AppConstants.printLog("Selected Index: " + _controller!.index.toString());
        switch(widget.selectedIndex) {
          case 0:
            DownloadedVideo();
            break;
          case 1:
            MyDownloadPdf();
            break;
        }
      });
    setState(() {});*/
  }

  @override
  void initState() {
    getTabList();
   AppConstants.checkPermission(context, Permission.storage, _createFolder);
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
                    // DownloadedPdf()
                    MyDownloadPdf()
                  ],
                  isVideo: true,
                  onPressed: (){
                    AppConstants.showAlertDialogWithButton(context, 'Are you sure to want to delete all the files?',
                        (){
                          Navigator.pop(context);
                          deleteDir();
                        }
                    );
                  },
                  title: getTranslated(context, StringConstant.downloads)!)
          );
        });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _createFolder() async {
    final path= Directory(AppConstants.filePath);
    bool exist = await path.exists();
    if (!exist) {
      path.create();
    }
  }

  Future<void> deleteDir() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    getTasks!.forEach((_task) {
      Map _map = Map();
      _map['status'] = _task.status;
      _map['progress'] = _task.progress;
      _map['id'] = _task.taskId;
      _map['filename'] = _task.filename;
      _map['savedDirectory'] = _task.savedDir;
      if (!_task.savedDir.contains('.pdf')) {
        Directory(_task.savedDir).exists().then((value) {
          if(value) {
            FlutterDownloader.remove(taskId: _task.taskId, shouldDeleteContent: true);
            Directory(_task.savedDir).delete(recursive: true);
          }
        });
      };
    });
    setState(() {});
  }
}
