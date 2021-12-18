import 'dart:io';
import 'package:exampur_mobile/presentation/home/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
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
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back,color: Colors.black,)),
            title: Text(
              'Downloads',
              style: CustomTextStyle.headingBold(context),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  tabs: <Widget>[
                    Tab(
                      text: "Videos",
                      //'My Courses',
                    ),
                    Tab(
                      text: "PDF s",
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              VideosCA(),
              DailyCA(),
            ],
          ),
        ),
      ),
    );
  }
}
