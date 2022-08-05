import 'dart:async';
import 'dart:io';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestSeriesNew extends StatefulWidget {
  final String url;
   final String token;
  const TestSeriesNew(this.url,this.token) : super();

  @override
  State<TestSeriesNew> createState() => _TestSeriesNewState();
}

class _TestSeriesNewState extends State<TestSeriesNew> {
  bool isLoading=true;
  final _key = UniqueKey();
  WebViewController? _controller;
  String jsMsg = '';
  bool showBackLoader = false;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();

  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    if(_controller != null) {
      if (await _controller!.canGoBack()) {
        AppConstants.printLog('>>>>>>>>>>>>>');
        AppConstants.printLog(jsMsg);
        if(jsMsg.isNotEmpty) {
          if(jsMsg == 'finish') {
            // AppConstants.printLog('>>>>>>>>>>>>>');
            // AppConstants.printLog(jsMsg);
            Navigator.pop(context);
          } else {
            AppConstants.showLoaderDialog(context);
            showBackLoader = true;
            _controller!.loadUrl(jsMsg);
          }
        } else {
          _controller!.goBack();
        }
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
    if(Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: CustomAppBar(
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              key: _key,
              initialUrl: widget.url.replaceAll('TOKEN', widget.token),
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: {
                JavascriptChannel(
                    name: 'messageHandler',
                    onMessageReceived: (JavascriptMessage jsMessage) {
                      setState(() {
                        jsMsg = jsMessage.message;
                      });
                    })
              },
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _controllerCompleter.future.then((value) => _controller = value);
                _controllerCompleter.complete(webViewController);
                },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                  if(showBackLoader) {
                    showBackLoader = false;
                    Navigator.pop(context);
                  }
                });
              },
              // onPageStarted: (start){
              //   setState(() {
              //     isLoading = true;
              //   });
              // },

                // navigationDelegate: (NavigationRequest request) {
                //   AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>');
                // AppConstants.printLog(request.url);
                //   if (request.url == 'https://exampur.com/e-app/test-series/') {
                //     Navigator.pop(context);
                //     return NavigationDecision.prevent;
                //   }
                //   return NavigationDecision.navigate;
                // }
            ),
            isLoading ? Center( child: CircularProgressIndicator(color: AppColors.amber),)
                : Stack(),
          ],
        ),
      ),
    );
  }
}