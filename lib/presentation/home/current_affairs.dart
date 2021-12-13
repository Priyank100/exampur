import 'dart:io';
import 'package:exampur_mobile/presentation/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/monthly_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/quiz/single_card.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentAffairs extends StatefulWidget {
  @override
  CurrentAffairsState createState() => CurrentAffairsState();
}

class CurrentAffairsState extends State<CurrentAffairs> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            centerTitle: true,
            title: Text(
              'Logo',
              style: TextStyle(color: Colors.black),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(65.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Current Affairs",
                      style: CustomTextStyle.headingBold(context),
                    ),
                  ),
                  Align(
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
                          text: "Daily",
                        ),
                        Tab(
                          text: "Monthly",
                        ),
                        Tab(
                          text: "Quiz",
                        ),
                        Tab(
                          text: "Bytes",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              VideosCA(),
              DailyCA(),
              MonthlyCA(),
              QuizCA(),
              BytesCA(),
            ],
          ),
        ),
      ),
    );
  }
}
