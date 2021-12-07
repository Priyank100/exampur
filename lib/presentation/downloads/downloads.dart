import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Downloads extends StatefulWidget {
  @override
  DownloadsState createState() => DownloadsState();
}

class DownloadsState extends State<Downloads> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("Downloads"),)
    );
  }
}