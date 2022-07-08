import 'dart:io';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDownloadPdf extends StatefulWidget {
  const MyDownloadPdf() : super();

  @override
  State<MyDownloadPdf> createState() => _MyDownloadPdfState();
}

class _MyDownloadPdfState extends State<MyDownloadPdf> {
  Directory _pdfDir = Directory(AppConstants.filePath);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Container(
    //           child: Padding(
    //             padding: EdgeInsets.all(20),
    //             child: Text('Downloaded PDF files are inside "Downloads -> Exampur" folder in your File Manager'),
    //           ),
    //         )
    // );
    return pdfList();
    }

    Widget pdfList() {
      if(Directory("${_pdfDir.path}").existsSync()) {
        var pdfList = _pdfDir.listSync().map((item) => item).toList(growable: false);

        return Scaffold(
          body: pdfList.length > 0 ?
          ListView.builder(
              itemCount: pdfList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    AppConstants.goTo(context, ViewPdf('',pdfList[index].path));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.grey,
                          width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(Images.pdfIcon, scale: 4),
                        SizedBox(width: 10),
                        Expanded(child: Text(pdfList[index].path.split('/').last, maxLines: 2,overflow: TextOverflow.ellipsis)),
                        InkWell(
                          onTap: (){
                            File file = File(pdfList[index].path);
                            file.delete();
                            setState(() {});
                          },
                            child: Icon(Icons.clear, color: AppColors.red)
                        )
                      ],
                    ),
                  ),
                );
              }
          ) :
          Center(
              child: AppConstants.noDataFound()
          ),
        );
      } else {
        return Scaffold(
          body: Center(
              child: AppConstants.noDataFound()
          ),
        );
      }
    }
}
