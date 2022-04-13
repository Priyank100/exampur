import 'dart:async';

import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(onTap:(){
        print('anchal');
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyWebView(
              selectedUrl: "https://docs.google.com/forms/d/e/1FAIpQLScCCm43CYzI4C0h4HgFCg5XB5dYa0my6q8rDif8IR_3RGuACQ/viewform",
            )
        ));},child: Center(child: Container(height: 40,width: 200,color: AppColors.amber,child: Center(child: Text('FeedBack',style: TextStyle(color: AppColors.white),)),))),
    );
  }
}


class MyWebView extends StatelessWidget {

  final String? selectedUrl;

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  MyWebView({
    @required this.selectedUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ));
  }
}


