import 'dart:io' show Platform;
import 'package:exampur_mobile/presentation/quiz/test_series.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,

              title: Text(
                "Exampur",
                style: TextStyle(color: Colors.black),
              )),
        ),
        body: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TestSeries(),
              ),
            );
          }, child: Text("Test Series"),
        ));
  }
}
