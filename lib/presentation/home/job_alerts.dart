import 'dart:io';
import 'package:exampur_mobile/presentation/current_affairs/bytes_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/daily_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/monthly_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/quiz_ca.dart';
import 'package:exampur_mobile/presentation/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/job%20alerts/admit_card.dart';
import 'package:exampur_mobile/presentation/job%20alerts/results.dart';
import 'package:exampur_mobile/presentation/job%20alerts/vacancy.dart';
import 'package:exampur_mobile/presentation/quiz/single_card.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobAlerts extends StatefulWidget {
  @override
  JobAlertsState createState() => JobAlertsState();
}

class JobAlertsState extends State<JobAlerts> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            //title: Text(AppLocalizations.of(context)!.courses),
            backgroundColor: Colors.transparent,

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
                      "Job Alerts",
                      style: CustomTextStyle.headingBold(context),
                    ),
                  ),
                  TabBar(
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    tabs: <Widget>[
                      Tab(
                        text: "Vacancy",
                        //'My Courses',
                      ),
                      Tab(
                        text: "Results",
                      ),
                      Tab(
                        text: "Admit Card",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[Vacancy(), Results(), AdmitCard()],
          ),
        ),
      ),
    );
  }
}
