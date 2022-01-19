// //
// // import 'dart:async';
// // import 'dart:io';
// //
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:flutter_pdfview/flutter_pdfview.dart';
// // import 'package:http/http.dart' as http;
// //
// // class Pdfview extends StatefulWidget {
// //   const Pdfview({Key? key}) : super(key: key);
// //
// //   @override
// //   _PdfviewState createState() => _PdfviewState();
// // }
// //
// // class _PdfviewState extends State<Pdfview> {
// //   String assetPDFPath = "";
// //   String urlPDFPath = "";
// //   String remotePDFpath = "";
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //    //  getFileFromAsset("assets/mypdf.pdf").then((f) {
// //    //    setState(() {
// //    //      assetPDFPath = f.path;
// //    //      print(assetPDFPath);
// //    //    });
// //    // });
// //
// //     createFileOfPdfUrl().then((f) {
// //       setState(() {
// //         remotePDFpath = f.path;
// //       });
// //     });
// //   }
// //
// //   Future<File> createFileOfPdfUrl() async {
// //     Completer<File> completer = Completer();
// //     print("Start download file from internet!");
// //     try {
// //       // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
// //       // final url = "https://pdfkit.org/docs/guide.pdf";
// //       final url = "http://www.pdf995.com/samples/pdf.pdf";
// //       final filename = url.substring(url.lastIndexOf("/") + 1);
// //       var request = await HttpClient().getUrl(Uri.parse(url));
// //       var response = await request.close();
// //       var bytes = await consolidateHttpClientResponseBytes(response);
// //       var dir = await getApplicationDocumentsDirectory();
// //       print("Download files");
// //       print("${dir.path}/$filename");
// //       File file = File("${dir.path}/$filename");
// //
// //       await file.writeAsBytes(bytes, flush: true);
// //       completer.complete(file);
// //     } catch (e) {
// //       throw Exception('Error parsing asset file!');
// //     }
// //
// //     return completer.future;
// //   }
// //   // Future<File> getFileFromAsset(String asset) async {
// //   //   try {
// //   //     var data = await rootBundle.load(asset);
// //   //     var bytes = data.buffer.asUint8List();
// //   //     var dir = await getApplicationDocumentsDirectory();
// //   //     File file = File("${dir.path}/mypdf.pdf");
// //   //
// //   //     File assetFile = await file.writeAsBytes(bytes);
// //   //     return assetFile;
// //   //   } catch (e) {
// //   //     throw Exception("Error opening asset file");
// //   //   }
// //   // }
// //
// //   Future<File> getFileFromUrl(String url) async {
// //     try {
// //       var data = await http.get(Uri.parse(url));
// //       var bytes = data.bodyBytes;
// //       var dir = await getApplicationDocumentsDirectory();
// //       File file = File("${dir.path}/mypdfonline.pdf");
// //
// //       File urlFile = await file.writeAsBytes(bytes);
// //       return urlFile;
// //     } catch (e) {
// //       throw Exception("Error opening url file");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter PDF View',
// //       debugShowCheckedModeBanner: false,
// //       home: Scaffold(
// //         appBar: AppBar(title: const Text('Plugin example app')),
// //         body: Center(child: Builder(
// //           builder: (BuildContext context) {
// //             return Column(
// //               children: <Widget>[
// //                 // TextButton(
// //                 //   child: Text("Open PDF"),
// //                 //   onPressed: () {
// //                 //     // if (pathPDF.isNotEmpty) {
// //                 //     //   Navigator.push(
// //                 //     //     context,
// //                 //     //     MaterialPageRoute(
// //                 //     //       builder: (context) => PDFScreen(path: pathPDF),
// //                 //     //     ),
// //                 //     //   );
// //                 //     // }
// //                 //   },
// //                 // ),
// //                 // TextButton(
// //                 //   child: Text("Open Landscape PDF"),
// //                 //   onPressed: () {
// //                 //     // if (landscapePathPdf.isNotEmpty) {
// //                 //     //   Navigator.push(
// //                 //     //     context,
// //                 //     //     MaterialPageRoute(
// //                 //     //       builder: (context) =>
// //                 //     //           PDFScreen(path: landscapePathPdf),
// //                 //     //     ),
// //                 //     //   );
// //                 //    // }
// //                 //   },
// //                 // ),
// //                 TextButton(
// //                   child: Text("Remote PDF"),
// //                   onPressed: () {
// //                     if (remotePDFpath.isNotEmpty) {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => PDFScreen(path: remotePDFpath),
// //                         ),
// //                       );
// //                     }
// //                   },
// //                 ),
// //                 // TextButton(
// //                 //   child: Text("Open Corrupted PDF"),
// //                 //   onPressed: () {
// //                 //     // if (pathPDF.isNotEmpty) {
// //                 //     //   Navigator.push(
// //                 //     //     context,
// //                 //     //     MaterialPageRoute(
// //                 //     //       builder: (context) =>
// //                 //     //           PDFScreen(path: corruptedPathPDF),
// //                 //     //     ),
// //                 //     //   );
// //                 //     // }
// //                 //   },
// //                 // )
// //               ],
// //             );
// //           },
// //         )),
// //       ),
// //     );
// //   }
// // }
// //
// // class PDFScreen extends StatefulWidget {
// //   final String? path;
// //
// //   PDFScreen({Key? key, this.path}) : super(key: key);
// //
// //   _PDFScreenState createState() => _PDFScreenState();
// // }
// //
// // class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
// //   final Completer<PDFViewController> _controller =
// //   Completer<PDFViewController>();
// //   int? pages = 0;
// //   int? currentPage = 0;
// //   bool isReady = false;
// //   String errorMessage = '';
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Document"),
// //         actions: <Widget>[
// //           IconButton(
// //             icon: Icon(Icons.share),
// //             onPressed: () {},
// //           ),
// //         ],
// //       ),
// //       body: Stack(
// //         children: <Widget>[
// //           PDFView(
// //             filePath: widget.path,
// //             enableSwipe: true,
// //             swipeHorizontal: true,
// //             autoSpacing: false,
// //             pageFling: true,
// //             pageSnap: true,
// //             defaultPage: currentPage!,
// //             fitPolicy: FitPolicy.BOTH,
// //             preventLinkNavigation:
// //             false, // if set to true the link is handled in flutter
// //             onRender: (_pages) {
// //               setState(() {
// //                 pages = _pages;
// //                 isReady = true;
// //               });
// //             },
// //             onError: (error) {
// //               setState(() {
// //                 errorMessage = error.toString();
// //               });
// //               print(error.toString());
// //             },
// //             onPageError: (page, error) {
// //               setState(() {
// //                 errorMessage = '$page: ${error.toString()}';
// //               });
// //               print('$page: ${error.toString()}');
// //             },
// //             onViewCreated: (PDFViewController pdfViewController) {
// //               _controller.complete(pdfViewController);
// //             },
// //             onLinkHandler: (String? uri) {
// //               print('goto uri: $uri');
// //             },
// //             onPageChanged: (int? page, int? total) {
// //               print('page change: $page/$total');
// //               setState(() {
// //                 currentPage = page;
// //               });
// //             },
// //           ),
// //           errorMessage.isEmpty
// //               ? !isReady
// //               ? Center(
// //             child: CircularProgressIndicator(),
// //           )
// //               : Container()
// //               : Center(
// //             child: Text(errorMessage),
// //           )
// //         ],
// //       ),
// //       floatingActionButton: FutureBuilder<PDFViewController>(
// //         future: _controller.future,
// //         builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
// //           if (snapshot.hasData) {
// //             return FloatingActionButton.extended(
// //               label: Text("Go to ${pages! ~/ 2}"),
// //               onPressed: () async {
// //                 await snapshot.data!.setPage(pages! ~/ 2);
// //               },
// //             );
// //           }
// //
// //           return Container();
// //         },
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:io';
//
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
//
//
//
// import 'package:flutter/material.dart';
//
//
// class PdfViewerPage extends StatefulWidget {
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }
//
// class _PdfViewerPageState extends State<PdfViewerPage> {
//   late final String localPath;
//
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     ApiServiceProvider.loadPDF().then((value) {
//       setState(() {
//         localPath = value;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("CodingBoot Flutter PDF Viewer",style: TextStyle(fontWeight: FontWeight.bold),),
//       ),
//       body: localPath != null
//           ? PDFView(
//         filePath: localPath,
//       )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
//
//
// class ApiServiceProvider {
//   static final String BASE_URL = "https://www.ibm.com/downloads/cas/GJ5QVQ7X";
//
//   static Future<String> loadPDF() async {
//     var response = await http.get(Uri.parse(BASE_URL));
//
//     var dir = await getApplicationDocumentsDirectory();
//     File file = new File("${dir.path}/data.pdf");
//     file.writeAsBytesSync(response.bodyBytes, flush: true);
//     return file.path;
//   }
// }



import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({Key? key}) : super(key: key);

  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  FocusNode textFocusController = FocusNode();
  var msg;
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    City = jsonValue[0]['data']['city'].toString();
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => textFocusController.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Razor Pay"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextField(
                  focusNode: textFocusController,
                  cursorRadius: Radius.zero,
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                  decoration: const InputDecoration(hintText: "Amount",),
                  style: const TextStyle(fontSize: 35.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  color: Colors.deepPurple,
                  child: Text(
                    "Pay",
                    style: const TextStyle(color: Colors.white,fontSize: 30),
                  ),
                  onPressed: () {
                    openCheckout();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openCheckout() {
    // call apis
    var options = {
      "key": Keys.Rozar_pay_key,
      "amount": num.parse(textEditingController.text) * 100, // Convert Paisa to Rupees
      "name": "Exampur",
      "description": "This is a Test Payment",//from apis
     // "order_id":        //fromapi
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
      "prefill": {"contact":  Mobile, "email": Email},

    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Pament success");
    msg = "SUCCESS: " + response.paymentId!;
    showToast(msg);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    showToast(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName!;
    showToast(msg);
  }

  showToast(msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.black54,
    );
  }

}