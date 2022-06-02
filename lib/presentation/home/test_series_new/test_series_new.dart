import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';

class TestSeriesNew extends StatefulWidget {
  const TestSeriesNew({Key? key}) : super(key: key);

  @override
  State<TestSeriesNew> createState() => _TestSeriesNewState();
}

class _TestSeriesNewState extends State<TestSeriesNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('POPULAR TEST SERIES FOR BANKING, SSC, RRB & ALL OTHER GOVT. EXAMS')
      ],),
    );
  }
}
