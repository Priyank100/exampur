import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DownloadsDrawer extends StatefulWidget {
  const DownloadsDrawer({Key? key}) : super(key: key);

  @override
  _DownloadsDrawerState createState() => _DownloadsDrawerState();
}

class _DownloadsDrawerState extends State<DownloadsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Downloads drawer"),
    );
  }
}
