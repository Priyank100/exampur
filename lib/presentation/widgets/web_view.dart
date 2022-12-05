import 'dart:async';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/analytics_constants.dart';

class WebViewOpen extends StatefulWidget {
  final String url;
  final String token;
  const WebViewOpen(this.url,this.token) : super();

  @override
  State<WebViewOpen> createState() => _WebViewOpenState();
}

class _WebViewOpenState extends State<WebViewOpen> {
  bool isLoading=true;
  final _key = UniqueKey();
  WebViewController? _controller;


  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();

  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    if(_controller != null) {
      if (await _controller!.canGoBack()) {
        _controller!.goBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }else {
      return Future.value(true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var map = {
      'Page_Name':'My_Courses_Test_Series',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Name':AppConstants.courseName,
      'Course_Type':AppConstants.mycourseType == 0 ? 'Paid_Course' : AppConstants.mycourseType == 1 ? 'Free_Course':'Demo'

    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.My_Courses_Test_Series,map);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body:widget.url == null ||widget.url=='null'||widget.url.isEmpty ? AppConstants.noDataFound():
        Stack(
          children: <Widget>[
            WebView(
              key: _key,
              gestureRecognizers: {
              Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer()
               ),
                Factory<HorizontalDragGestureRecognizer>(
                        () => HorizontalDragGestureRecognizer()
                )
              },
              initialUrl: widget.url.replaceAll('<token>', widget.token),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controllerCompleter.future.then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
              },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
              // navigationDelegate: (NavigationRequest request) {
              //   if (request.url == 'https://exampur.com/e-app/test-series/') {
              //     Navigator.pop(context);
              //     return NavigationDecision.prevent;
              //   }
              //   return NavigationDecision.navigate;
              // }
            ),
            isLoading ? Center( child: CircularProgressIndicator(color: AppColors.amber,),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}