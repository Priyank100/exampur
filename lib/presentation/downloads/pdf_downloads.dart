import 'dart:core';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadedPdf extends StatefulWidget with WidgetsBindingObserver {
  const DownloadedPdf() : super();

  @override
  _DownloadedPdfState createState() => _DownloadedPdfState();
}

class _DownloadedPdfState extends State<DownloadedPdf> {
  ReceivePort _port = ReceivePort();
  List<Map<dynamic, dynamic>> downloadsListMaps = [];

  @override
  void initState() {
    super.initState();
    task();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    setState(() {});
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
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
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
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
      if(_task.savedDir.contains('.pdf'))
        downloadsListMaps.add(_map);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: downloadsListMaps.length == 0
          ? AppConstants.noDataFound()
          // ? Center(child: Text("No Downloads yet"))
          : Container(
        child: ListView.builder(
          itemCount: downloadsListMaps.length,
          itemBuilder: (BuildContext context, int i) {
            Map _map = downloadsListMaps[i];
            String _filename = _map['filename'];
            int _progress = _map['progress'];
            DownloadTaskStatus _status = _map['status'];
            String _id = _map['id'];
            String _savedDirectory = _map['savedDirectory'];
            List<FileSystemEntity> _directories = Directory(_savedDirectory).listSync(followLinks: true);
            File? _file = (_directories.isNotEmpty ? _directories.first : null) as File?;
            return  Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      isThreeLine: false,
                      leading: Image.asset(Images.pdfIcon),
                      title: Text(_filename),
                     // subtitle: downloadStatus(_status),
                      trailing: SizedBox(
                        child: buttons(_status, _id, i),
                        width: 60,
                      ),
                      subtitle: Row(children: [

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomRoundButton(text: getTranslated(context, StringConstant.viewPdf)!, onPressed: (){
            if (_status == DownloadTaskStatus.complete) {
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
            ViewPdf('',_file!.path)
            ));
            }
            },),
                        ),
                        // InkWell(
                        //   onTap: (){
                        //     if (_status == DownloadTaskStatus.complete) {
                        //       Navigator.push(context, MaterialPageRoute(builder: (_) =>
                        //           ViewPdf('',_file!.path)
                        //       ));
                        //     }
                        //   },
                        //   child: Container(margin: EdgeInsets.only(top: 8), decoration: BoxDecoration(
                        //       color:Color(0xFF060929),
                        //       borderRadius: BorderRadius.all(Radius.circular(5))),
                        //    height: 30,width: 90,child: Center(child: Text(getTranslated(context, StringConstant.viewPdf)!,style: TextStyle(color: AppColors.white,fontSize: 12),)),),
                        // ),
              // InkWell(
              //   onTap: (){
              //     // buttons(_status, _id, i);
              //     FlutterDownloader.cancel(taskId: _id);
              //     downloadsListMaps.removeAt(i);
              //     FlutterDownloader.remove(taskId: _id, shouldDeleteContent: true);
              //     setState(() {});
              //   },child: Container( margin:EdgeInsets.only(top: 8,left: 8),color: AppColors.white,height: 30,width: 70,child: Center(child: Text('Remove',style: TextStyle(color: AppColors.red)))))
                      ],),
                    ),
                    _status == DownloadTaskStatus.complete
                        ? Container()
                        : SizedBox(height: 5),
                    _status == DownloadTaskStatus.complete
                        ? Container()
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('$_progress%'),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: LinearProgressIndicator(
                                  color: Colors.amber,
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

            );
          },
        ),
      ),
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

  Widget buttons(DownloadTaskStatus _status, String taskid, int index) {
    void changeTaskID(String taskid, String newTaskID) {
      Map? task = downloadsListMaps.firstWhere((element) => element['taskId'] == taskid
       orElse: () => {},
      );
      task['taskId'] = newTaskID;
      setState(() {});
    }

    return _status == DownloadTaskStatus.canceled
        ? GestureDetector(
      child: Icon(Icons.cached, size: 20, color: AppColors.green),
      onTap: () {
        FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
          changeTaskID(taskid, newTaskID!);
        });
      },
    )
        : _status == DownloadTaskStatus.failed
        ? GestureDetector(
      child: Icon(Icons.cached, size: 20, color: AppColors.green),
      onTap: () {
        FlutterDownloader.retry(taskId: taskid).then((newTaskID) {
          changeTaskID(taskid, newTaskID!);
        });
      },
    )
        : _status == DownloadTaskStatus.paused
        ? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: Icon(Icons.play_arrow,
              size: 20, color: AppColors.blue),
          onTap: () {
            FlutterDownloader.resume(taskId: taskid).then(
                  (newTaskID) => changeTaskID(taskid, newTaskID!),
            );
          },
        ),
        GestureDetector(
          child: Icon(Icons.close, size: 20, color: AppColors.red),
          onTap: () {
            FlutterDownloader.cancel(taskId: taskid);
          },
        )
      ],
    )
        : _status == DownloadTaskStatus.running
        ? Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: Icon(Icons.pause,
              size: 20, color: AppColors.green),
          onTap: () {
            FlutterDownloader.pause(taskId: taskid);
          },
        ),
        GestureDetector(
          child:
          Icon(Icons.close, size: 20, color: AppColors.red),
          onTap: () {
            FlutterDownloader.cancel(taskId: taskid);
            downloadsListMaps.removeAt(index);
            FlutterDownloader.remove(taskId: taskid, shouldDeleteContent: true);
            setState(() {});
          },
        )
      ],
    )
        : _status == DownloadTaskStatus.complete
        ? GestureDetector(
      child:
      Icon(Icons.close, size: 20, color:AppColors.red),
      onTap: () {
        downloadsListMaps.removeAt(index);
        FlutterDownloader.remove(taskId: taskid, shouldDeleteContent: true);
        setState(() {});
      },
    )
        : Container();
  }

  Future<bool> _openDownloadedFile(String taskId) {
    AppConstants.printLog(taskId);
    if (taskId != null) {
      return FlutterDownloader.open(taskId: taskId);
    } else {
      return Future.value(false);
    }
  }
}