import 'dart:async';


import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController controllerGlobal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitApp,
      child: Scaffold(
            appBar: CustomAppBar(
            ),
            body:   WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl:API.TermsConditions_URL,
              gestureNavigationEnabled: true,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.future.then((value) => controllerGlobal = value);
                _controller.complete(webViewController);
              },
              onPageStarted: (String url) {
                AppConstants.printLog('Page started loading: $url');
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (String url) {
                AppConstants.printLog('Page finished loading: $url');
                setState(() {
                  _isLoading = false;
                });
              },
            ),



      ),
    );
  }
  Future<bool> _exitApp() async {
    if(controllerGlobal != null) {
      if (await controllerGlobal.canGoBack()) {
        controllerGlobal.goBack();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }else {
      return Future.value(true);
    }
  }
}