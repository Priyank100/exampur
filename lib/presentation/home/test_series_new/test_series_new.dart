import 'dart:async';

import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TestSeriesNew extends StatefulWidget {
  const TestSeriesNew({Key? key}) : super(key: key);

  @override
  State<TestSeriesNew> createState() => _TestSeriesNewState();
}

class _TestSeriesNewState extends State<TestSeriesNew> {
  bool isLoading=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body:  Stack(
          children: <Widget>[
            WebView(
              initialUrl: 'https://exampur.com/testseries/',
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: (start) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(color: AppColors.amber,),)
                : Stack(),
          ],
        ),);
  }
}