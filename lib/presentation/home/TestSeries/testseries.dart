import 'dart:io';

import 'package:exampur_mobile/data/model/Test_series.dart';
import 'package:exampur_mobile/presentation/home/TestSeries/testseriesview.dart';
import 'package:exampur_mobile/presentation/home/quiz/single_card.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'aatempttestseries.dart';

class TestSeriesview extends StatefulWidget {
  @override
  TestSeriesviewState createState() => TestSeriesviewState();
}

class TestSeriesviewState extends State<TestSeriesview> with TickerProviderStateMixin{
  late TabController _controller;
  int _selectedIndex = 0;
  List<TestSeriesModel> testseriesList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      AppConstants.printLog("Selected Index: " + _controller.index.toString());
      switch( _controller.index) {
        case 0:
          setState(() {

          });
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
  }  });
  }

  List<String> categories = [
    "Live Test Series",
    "My Test Series",
    "All Test Series",
    "Preivous year Papers"
  ];

  @override
  Widget build(BuildContext context) {
    //return
      //comingSoon();
    return Scaffold(
        body: TabBarDemo(
          controller: _controller,
          length: 4,
          names: [
            "Live Test Series",
            "My Test Series",
            "All Test Series",
            "Preivous year Papers"
          ], title: '', routes: [TestSeriesCardView(),TestSeriesCardView(),TestSeriesCardView(),TestSeriesCardView()
        ],)
    );

  }

  Widget comingSoon() {
    return Scaffold(
      appBar: CustomAppBar(),
      body: AppConstants.comingSoonImage(),
    );
  }
}
