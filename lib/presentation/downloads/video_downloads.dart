import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/shared/local_video_screen.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/analytics_constants.dart';

class DownloadedVideo extends StatefulWidget {
  const DownloadedVideo(Key key) : super(key: key);

  @override
  DownloadedVideoState createState() => DownloadedVideoState();
}

class DownloadedVideoState extends State<DownloadedVideo> {
  ReceivePort _port = ReceivePort();
  List<Map<dynamic, dynamic>> downloadsListMaps = [];
  final keyRefresh = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    task();
    _bindBackgroundIsolate();
    setState(() {});
  }

  Future<void> refreshScreen() async {
    downloadsListMaps.clear();
    task();
    _bindBackgroundIsolate();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }

    _port.listen((dynamic data) async {
      AppConstants.printLog('>>>>>>>>>>>>>>>>>');
      AppConstants.printLog(data);
        String id = data[0];
        DownloadTaskStatus status = data[1];
        int progress = data[2];
        var task = downloadsListMaps.where((element) => element['id'] == id);
        task.forEach((element) {
          element['progress'] = progress;
          element['status'] = status;
          setState(() {});
        });
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  Future task() async {
    List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
    getTasks!.forEach((_task) {
      Map _map = Map();
      _map['status'] = _task.status;
      _map['progress'] = _task.progress;
      _map['id'] = _task.taskId;
      _map['filename'] = _task.filename;
      _map['savedDirectory'] = _task.savedDir;
      if (!_task.savedDir.contains('.pdf')) downloadsListMaps.add(_map);
      // Future.delayed(Duration(milliseconds: 1000), () {
      //   if(_task.status == DownloadTaskStatus.enqueued) {
      //     AppConstants.showAlertDialog(context, getTranslated(context, LangString.Memoryspace)!);
      //   }
      // });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshWidget(
            keyRefresh: keyRefresh,
            onRefresh: refreshScreen,
            child: Container(
              child: downloadsListMaps.length == 0
                  ? ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int i) {
                        return Center(
                            child: Image.asset('assets/images/no_data.png')
                        );
                      })
                  // : downloadsListMaps.length==1 && downloadsListMaps[0]['status'] == DownloadTaskStatus.enqueued ? memorySpaceWidget()
                  : ListView.builder(
                      itemCount: downloadsListMaps.length,
                      itemBuilder: (BuildContext context, int index) {
                        int count = downloadsListMaps.length;
                        int i = count - 1 - index;
                        Map _map = downloadsListMaps[i];
                        String _filename = _map['filename'];
                        int _progress = _map['progress'];
                        DownloadTaskStatus _status = _map['status'];
                        String _id = _map['id'];
                        String _savedDirectory = _map['savedDirectory'];
                        List<FileSystemEntity> _directories = Directory(_savedDirectory).listSync(followLinks: true);
                        File? _file = (_directories.isNotEmpty
                            ? _directories.first
                            : null) as File?;
                        return GestureDetector(
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // ListTile(
                                //   isThreeLine: false,
                                //   title: Text(_filename),
                                //   subtitle: downloadStatus(_status),
                                //   trailing: SizedBox(
                                //     child: buttons(_status, _id, i),
                                //     width: 60,
                                //   ),
                                // ),
                                ListTile(
                                  isThreeLine: false,
                                  leading: Image.asset(Images.download_video),
                                  title: Text(_filename.replaceAll('--', '').split('~')[0],maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  // subtitle: downloadStatus(_status),
                                  trailing: SizedBox(
                                    child: buttons(_status, _id, i),
                                    width: 60,
                                  ),
                                  subtitle: Row(
                                    children: [
                                      _status == DownloadTaskStatus.failed ? Text('Failed')
                                      : _status == DownloadTaskStatus.canceled ? Text('Cancelled')
                                      : _status == DownloadTaskStatus.paused ? Text('Paused')
                                      : _status == DownloadTaskStatus.enqueued ? Flexible(child:Text('Download failed due to not enough space'))
                                      : _status == DownloadTaskStatus.running ?  Text('Downloading...')
                                      : _status == DownloadTaskStatus.undefined ? Text('Error')
                                          : _status == DownloadTaskStatus.complete ?
                                      Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0),
                                              child: CustomRoundButton(
                                                text: getTranslated(context,
                                                    LangString.watch)!,
                                                onPressed: () {
                                                  var map = {
                                                    'Page_Name':'Downloads',
                                                    'Mobile_Number':AppConstants.userMobile,
                                                    'Language':AppConstants.langCode,
                                                    'User_ID':AppConstants.userMobile,
                                                    'Course_Name':_filename.replaceAll('--', '').split('~')[0],
                                                    'Topic_Name':_filename.replaceAll('--', '').split('~')[0]

                                                  };
                                                  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Watch_Now,map);
                                                  Navigator.of(context,
                                                      rootNavigator: true)
                                                      .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          LocalVideoScreen(
                                                              _file!,
                                                              _filename.split('~')[0]))
                                                  );
                                                },
                                              ),
                                            ) : SizedBox()
                                    ],
                                  ),
                                ),

                                _status == DownloadTaskStatus.complete
                                    ? SizedBox()
                                    : SizedBox(height: 5),

                                _status == DownloadTaskStatus.complete ||
                                        _status == DownloadTaskStatus.failed ||
                                    _status == DownloadTaskStatus.canceled
                                    ? SizedBox()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text('$_progress%'),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child:
                                                      LinearProgressIndicator(
                                                    color: AppColors.amber,
                                                    backgroundColor:
                                                        AppColors.grey,
                                                    value: _progress / 100,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 10)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            )
        )
    );
  }

  Widget downloadStatus(DownloadTaskStatus _status) {
    return _status == DownloadTaskStatus.canceled
        ? Text('Download canceled')
        : _status == DownloadTaskStatus.complete
            ? Text('Download completed')
            : _status == DownloadTaskStatus.failed
                ? Text('Download failed')
                : _status == DownloadTaskStatus.paused
                    ? Text('Download paused')
                    : _status == DownloadTaskStatus.running
                        ? Text('Downloading..')
                        : Text('Download waiting');
  }

  void changeTaskID(String taskid, String newTaskID) {
    Map? task = downloadsListMaps.firstWhere(
          (element) => element['taskId'] == taskid,
      orElse: () => {},
    );
    task['taskId'] = newTaskID;
    refreshScreen();
    setState(() {});
  }

  Widget buttons(DownloadTaskStatus _status, String taskid, int index) {

    return
      _status == DownloadTaskStatus.canceled ?
      Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child:
              Icon(Icons.replay, size: 20, color: Colors.blue),
              onTap: () {
                retryVideo(taskid);
              },
            ),
        GestureDetector(
          child: Icon(Icons.close, size: 20, color: Colors.red),
          onTap: () {
            deleteVideo(taskid, index);
            },
        )]
      )

        : _status == DownloadTaskStatus.failed ?
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child:
                    Icon(Icons.replay, size: 20, color: Colors.blue),
                    onTap: () {
                      retryVideo(taskid);
                    },
                  ),
                  GestureDetector(
                    child: Icon(Icons.close, size: 20, color: Colors.red),
                    onTap: () {
                      deleteVideo(taskid, index);
                    },
                  )
                ],
              )

            : _status == DownloadTaskStatus.paused ?
                 Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.play_arrow,
                            size: 20, color: Colors.blue),
                        onTap: () async {
                          resumeVideo(taskid);
                        },
                      ),
                      GestureDetector(
                        child: Icon(Icons.close, size: 20, color: Colors.red),
                        onTap: () {
                          deleteVideo(taskid, index);
                        },
                      )
                    ],
                  )

                : _status == DownloadTaskStatus.running ?
                     Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Icon(Icons.pause, size: 20, color: Colors.green),
                            onTap: () {
                              pauseVideo(taskid);
                            },
                          ),
                           GestureDetector(
                            child:
                                Icon(Icons.close, size: 20, color: Colors.red),
                            onTap: () {
                              deleteVideo(taskid, index);
                            },
                          )
                        ],
                      )

                    : _status == DownloadTaskStatus.complete ?
                         GestureDetector(
                            child: Icon(Icons.delete, size: 20, color: Colors.red),
                            onTap: () {
                              deleteVideo(taskid, index);
                            },
                          )
                        :
    GestureDetector(
      child:
      Icon(Icons.close, size: 20, color: Colors.red),
      onTap: () {
        deleteVideo(taskid, index);
      },
    );
  }

  void pauseVideo(taskId) {
    FlutterDownloader.pause(taskId: taskId);
  }

  Future<void> resumeVideo(taskId) async {
    if(await AppConstants.checkInternet()) {
      FlutterDownloader.resume(taskId: taskId).then(
            (newTaskID) => changeTaskID(taskId, newTaskID!));
    } else {
      AppConstants.showAlertDialog(context, 'No Internet');
    }
  }

  Future<void> retryVideo(taskId) async {
    if(await AppConstants.checkInternet()) {
      FlutterDownloader.retry(taskId: taskId).then((newTaskID) {
      changeTaskID(taskId, newTaskID!);
      });
    } else {
      AppConstants.showAlertDialog(context, 'No Internet');
    }
  }

  void deleteVideo(taskId, index) {
    FlutterDownloader.cancel(taskId: taskId);
    downloadsListMaps.removeAt(index);
    FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
    setState(() {});
  }

  Future<void> deleteDir() async {
    final dir = await getApplicationDocumentsDirectory();
    Directory(dir.path).delete(recursive: true);
    await FlutterDownloader.loadTasks().then((list) {
      if(list != null && list.length > 0) {
        for(int i=0; i<list.length; i++) {
          FlutterDownloader.remove(taskId: list[i].taskId, shouldDeleteContent: true);
        }
      }
    });
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    downloadsListMaps.clear();
    refreshScreen();
    setState(() {});
  }

  Widget memorySpaceWidget() {
    return Center(child:
        Container(
          height: MediaQuery.of(context).size.height/6,
          width: MediaQuery.of(context).size.height/3,
          decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(10),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Alert',style: TextStyle(fontSize: 18),),
              SizedBox(height: 30,),
              Text('Your memory is out of space'),
            ]),
        ));
  }

}

// for(var map in downloadsListMaps) {
// FlutterDownloader.pause(taskId: map['id']);
// }
