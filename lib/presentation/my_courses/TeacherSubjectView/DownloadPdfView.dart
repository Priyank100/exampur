import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../SharePref/shared_pref.dart';
import '../../../data/datasource/remote/http/services.dart';
import '../../../utils/api.dart';


class DownloadViewPdf extends StatefulWidget {
 final String pdfTitle;
  final String pdfUrl;
  final bool? isTimlineRequired;
  const DownloadViewPdf(this.pdfTitle, this.pdfUrl,{this.isTimlineRequired}) : super();

  @override
  _DownloadViewPdfState createState() => _DownloadViewPdfState();
}

class _DownloadViewPdfState extends State<DownloadViewPdf> {

  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;
  String? deviceModel;
  String? deviceMake;
  String? deviceOS;
  String? userName;
  String? userMobile;
  // String? userEmail;
  String? versionName;
  String? versionCode;

  // Future<File> getFileFromUrl(String url, {name}) async {
  Future<File> getFileFromUrl(String url, String name) async {
    // var fileName = 'testonline';
    var fileName = name.replaceAll(' ', '_').replaceAll(RegExp('[^A-Za-z0-9_]'), '');
    // if (name != null) {
    //   fileName = name;
    // }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file> " + e.toString());
    }
  }

  @override
  void initState() {
    // requestPersmission();
    getUserData();
    getDeviceData();
    getAppVersionData();
    AppConstants.printLog('Anchal>> ' + widget.pdfUrl);
    if(widget.pdfUrl.isNotEmpty) {
      getFileFromUrl(widget.pdfUrl, widget.pdfTitle).then(
            (value) => {
          setState(() {
            if (value != null) {
              urlPDFPath = value.path;
              loaded = true;
              exists = true;
            } else {
              exists = false;
            }
          })
        },
      );
    }
    super.initState();
  }

  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
  //  userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
      setState(() {});
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: PDFView(
          filePath: urlPDFPath,
          autoSpacing: true,
          enableSwipe: true,
          pageSnap: true,
          nightMode: false,
          onError: (error) {
            AppConstants.showBottomMessage(context, error.toString(), AppColors.black);
          },
          onRender: (_pages) {
            setState(() {
              _totalPages = _pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
          onPageChanged: (int? page, int? total) {
            setState(() {
              _currentPage = page!;
            });
          },
          onPageError: (page, e) {},
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController!.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController!.setPage(_currentPage);
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.download),
              iconSize: 50,
              color: Colors.black,
              onPressed: () async{
                // AppConstants.checkPermission(context, Permission.storage, downloadPdfFile);
             widget.isTimlineRequired == true ?   downloadPdfLog():null;
                openPermissionDialog();
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return Scaffold(
            body: Center(child:   SizedBox(
              child: CircularProgressIndicator(color: AppColors.amber,strokeWidth: 8,),
              height: 100.0,
              width: 100.0,
            ),)
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: CustomAppBar(),
          body: Text(
            "PDF Not Available",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }

  /*Future<void> requestDownload() async {
    final dir = await getApplicationDocumentsDirectory();
    var _localPath = dir.path + '/' + widget.pdfTitle + '.pdf';
    final savedDir = Directory(_localPath);

    await savedDir.exists().then((alreadyExist) async {
      AppConstants.printLog(alreadyExist);
      if(alreadyExist) {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.ThisFileisAlreadyExist), AppColors.black);
        return;

      } else {
        savedDir.create();
        await savedDir.create(recursive: true).then((value) async {
          String? _taskid = await FlutterDownloader.enqueue(
            url: widget.pdfUrl,
            fileName: widget.pdfTitle,
            savedDir: _localPath,
            showNotification: false,
            openFileFromNotification: false,
            saveInPublicStorage: false,
          );
          AppConstants.printLog(_taskid);
          setState(() {});
          Navigator.push(context, MaterialPageRoute(builder: (_) =>
              Downloads(1)
          ));
        });
      }
    });
  }*/

  /*Future<void> downloadFile() async {
    AppConstants.showLoaderDialog(context, message:'Downloading...');
    String url = widget.pdfUrl;
    String fileName = widget.pdfTitle;
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = Directory(AppConstants.filePath);
      File file = File("${dir.path}/" + fileName + ".pdf");
      await file.writeAsBytes(bytes).then((file) {
        Navigator.pop(context);
        AppConstants.goTo(context, Downloads(1));
      });
    } catch (e) {
      throw Exception("Error downloading url file");
    }
  }*/

  Future<void> openPermissionDialog() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var os = androidInfo.version.release.toString();
    os = os.split(".").take(2).join('.');

    if(double.parse(os) >= 13.0) {
      AppConstants.createExampurFolder();
      // downloadPdfFile();

      var fileName = widget.pdfTitle.replaceAll(' ', '_').replaceAll(RegExp('[^A-Za-z0-9_]'), '');
      File safeFile = File(urlPDFPath);
      await safeFile.copy('${Directory(AppConstants.filePath).path}/' + fileName + '.pdf').then((value) {
        AppConstants.showBottomMessage(context, 'File has been downloaded successfully', AppColors.black);
      });
    } else {
      await Permission.storage.request().then((value) async {
        if(value.isGranted) {
          AppConstants.createExampurFolder();
          // downloadPdfFile();

          var fileName = widget.pdfTitle.replaceAll(' ', '_').replaceAll(RegExp('[^A-Za-z0-9_]'), '');
          File safeFile = File(urlPDFPath);
          await safeFile.copy('${Directory(AppConstants.filePath).path}/' + fileName + '.pdf').then((value) {
            AppConstants.showBottomMessage(context, 'File has been downloaded successfully', AppColors.black);
          });

        } else {
          AppConstants.showAlertDialogWithButton(
              context,
              "To download this file, click on 'Continue' to allow the storage permission from setting",
                  () async {
                Navigator.pop(context);
                await openAppSettings();
              }
          );
        }
      });
    }
  }

  void downloadPdfFile() async {
    final Dio dio = Dio();
    String url = widget.pdfUrl;
    String fileName =widget.pdfTitle.replaceAll(' ', '-').replaceAll('|', '').replaceAll('||', '').replaceAll('/', '').replaceAll('|', '_').replaceAll(':', '_');
   // String fileName = widget.pdfTitle.replaceAll('|', '').replaceAll('||', '').replaceAll('/', '').replaceAll('|', '_').replaceAll(' ', '_').replaceAll(':', '_').trim();
    int progress = 0;
    ProgressDialog pd = ProgressDialog(context: context);

    pd.show(
      max: 100,
      msg: AppConstants.downloadMag,
      msgMaxLines: 10,
      msgFontSize: 12,
      msgFontWeight: FontWeight.normal,
      progressType: ProgressType.valuable,
      progressValueColor: AppColors.amber,
      barrierDismissible: true,
      completed: Completed(completedMsg: 'Downloaded complete')
    );
    var dir = Directory(AppConstants.filePath);
    File file = File("${dir.path}/" + fileName + ".pdf");
    AppConstants.printLog('>>>>>>>>>>>>>>>'+file.toString());
    dio.download(url, file.path, onReceiveProgress: (value1, value2) {
      setState(() {
        progress = ((value1/value2)*100).toInt();
        pd.update(value: progress);
      });
    });
  }

 // ===================================ElasticaApi===========================

  Future<void> downloadPdfLog() async {
    // AppConstants.showLoaderDialog(context);
    {
      var body = {
        "user": {
          "name": userName,
          // "email": userEmail,
          "email": userMobile! + '@nill.com',
          "mobile": userMobile
        },
        "device": {
          "model": deviceModel,
          "make": deviceMake,
          "os": deviceOS
        },
        "app": {
          "version_name": versionName,
          "version_code": versionCode
        },
        "type": "content-log",
        "content-type": "pdf-download",
        "course": {
          "name":AppConstants.myCourseName,
          "id": AppConstants.myCourseId
        },
        "content": {
          "timeline_name": AppConstants.timlineName,
          "timeline_id":AppConstants.timlineId
        }
      };
      Map<String, String> header = {
        "x-auth-token": AppConstants.serviceLogToken,
        "Content-Type": "application/json",
        "app-version":AppConstants.versionCode
      };
      await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((
          response) {
       // AppConstants.printLog(header);
       //  AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        AppConstants.printLog(response.body);
        AppConstants.printLog('pdf-download-click');
      });
    }
  }
}
