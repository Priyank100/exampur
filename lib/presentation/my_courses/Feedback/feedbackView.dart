import 'dart:async';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FeedbackView extends StatelessWidget {
  final String userName;
  final String userMobile;
  final String token;
  const FeedbackView(this.userName, this.userMobile, this.token) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MyWebView(
                      selectedUrl: AppConstants.googleFeedbackFormUrl.replaceAll('USER_NAME', userName).replaceAll('USER_MOBILE', userMobile),
                    )
                ));
              },
              color: AppColors.amber,
              child: Text(
                getTranslated(context, LangString.feedBack)!,
                style: TextStyle(color: AppColors.white),
              ),
            ),
            /*MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2,
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => MyWebView(
                //       selectedUrl: 'https://exampur.com/e-app/login?token=$token&path=/e-app/doubt-session/',
                //     )
                // ));
                AppConstants.makeCallEmail('https://exampur.com/e-app/login?token=$token&path=/e-app/doubt-session/');
              },
              color: AppColors.amber,
              child: Text(
                'Doubt',
                style: TextStyle(color: AppColors.white),
              ),
            ),*/
          ],
        ),
      )
    );
  }
}


class MyWebView extends StatefulWidget {

  final String? selectedUrl;


  MyWebView({
    @required this.selectedUrl,
  });

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Permission.mediaLibrary.request();
    // Permission.phone.request();
    // Permission.photos.request();
    // Permission.storage.request();
    // Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: WebView(
          initialUrl: widget.selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        )
    );
  }
}


