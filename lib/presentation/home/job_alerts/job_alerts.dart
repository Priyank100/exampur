import 'dart:io';
import 'package:exampur_mobile/presentation/home/job%20alerts/admit_card.dart';
import 'package:exampur_mobile/presentation/home/job%20alerts/results.dart';
import 'package:exampur_mobile/presentation/home/job%20alerts/vacancy.dart';
import 'package:exampur_mobile/presentation/home/quiz/single_card.dart';
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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          //title: Text(AppLocalizations.of(context)!.courses),
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
                    "Job Alerts",
                    style: CustomTextStyle.headingBold(context),
                  ),
                ),
                Align(
                  alignment:Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme
                        .of(context)
                        .primaryColor,
                    labelColor: Theme
                        .of(context)
                        .primaryColor,
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
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[Vacancy(), Results(), AdmitCard()],
        ),
      ),

    );
  }
}
