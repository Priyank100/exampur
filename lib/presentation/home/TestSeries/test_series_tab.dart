import 'package:exampur_mobile/presentation/home/TestSeries/test_series_listing.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestSeriesTab extends StatefulWidget {

  @override
  TestSeriesTabState createState() => TestSeriesTabState();
}

class TestSeriesTabState extends State<TestSeriesTab> with TickerProviderStateMixin{
  late TabController _controller;
  int _selectedIndex = 0;
  List<String> tabNames = [
    "Live Test Series",
    "My Test Series",
    "All Test Series"
  ];
  // String testSeriesType = '';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabNames.length, vsync: this);

  //   _controller.addListener(() {
  //     setState(() {
  //       _selectedIndex = _controller.index;
  //     });
  //     AppConstants.printLog("Selected Index: " + _controller.index.toString());
  //     switch( _controller.index) {
  //       case 0:
  //         testSeriesType = 'LIVE';
  //         break;
  //       case 1:
  //         testSeriesType = 'MY';
  //         break;
  //       case 2:
  //         testSeriesType = 'ALL';
  //         break;
  // }  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarDemo(
            controller: _controller,
            length: tabNames.length,
            names: tabNames,
            title: '',
            routes: [
              TestSeriesListing('LIVE'),
              TestSeriesListing('MY'),
              TestSeriesListing('ALL')
            ]
        )
    );
  }
}
