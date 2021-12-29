import 'dart:io';
import 'package:exampur_mobile/presentation/home/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/monthly_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
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
        body: CustomTabBar(
            length: 5,
            names: ["Videos", "Daily", "Monthly", "Quiz", "Bytes"],
            routes: [
              VideosCA(),
              DailyCA(),
              MonthlyCA(),
              QuizCA(),
              BytesCA(),
            ],
            title: "Current Affairs"));
  }
}
