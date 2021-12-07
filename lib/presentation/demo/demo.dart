import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Demo extends StatefulWidget {
  @override
  DemoState createState() => DemoState();
}

class DemoState extends State<Demo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("Demo"),)
    );
  }
}