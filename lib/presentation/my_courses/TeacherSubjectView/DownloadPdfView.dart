import 'dart:io';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';


class DownloadViewPdf extends StatefulWidget {
  final String pdfUrl;
  final String pdfTitleUrl;
  final String pdfFilePath;
  const DownloadViewPdf(this.pdfUrl,this.pdfTitleUrl, this.pdfFilePath) : super();

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

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/" + fileName + ".pdf");
      print(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  void initState() {
    // requestPersmission();
    AppConstants.printLog('Anchal>> ' + widget.pdfUrl);
    if(widget.pdfUrl.isNotEmpty) {
      getFileFromUrl(widget.pdfUrl).then(
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
    } else {
      urlPDFPath = widget.pdfFilePath;
      loaded = true;
      exists = true;
    }

    super.initState();
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
                AppConstants.checkPermission(context, Permission.storage, requestDownload);
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
  Future<void> requestDownload() async {
    final dir = await getApplicationDocumentsDirectory();
    var _localPath = dir.path + '/' + widget.pdfTitleUrl + '.pdf';
    // var _localPath = dir.path + '/' + videoName;
    final savedDir = Directory(_localPath);
    await savedDir.create(recursive: true).then((value) async {
      String? _taskid = await FlutterDownloader.enqueue(
        url: widget.pdfUrl,
        fileName: widget.pdfTitleUrl,
        savedDir: _localPath,
        showNotification: false,
        openFileFromNotification: false,
        saveInPublicStorage: false,
      );
      AppConstants.printLog(_taskid);
      setState(() {

      });
      Navigator.push(context, MaterialPageRoute(builder: (_) =>
          Downloads(1)
      ));
    });
  }
}
