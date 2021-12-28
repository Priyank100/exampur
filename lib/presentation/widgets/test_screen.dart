import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TestingScreen extends StatefulWidget {
  @override
  TestingScreenState createState() => TestingScreenState();
}

class TestingScreenState extends State<TestingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Testing screen"),)
    );
  }
}