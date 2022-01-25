import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_model.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/admit_card.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/results.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/vacancy.dart';
import 'package:exampur_mobile/presentation/home/quiz/single_card.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobAlerts extends StatefulWidget {
  @override
  JobAlertsState createState() => JobAlertsState();
}

class JobAlertsState extends State<JobAlerts> with TickerProviderStateMixin {
  Set<String> selected = new Set<String>();
  List<JobAlertModel > vaccancy = [];

  late TabController _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
      switch( _controller.index) {
        case 0:
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 1:
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
        case 3:
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
          vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
          break;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(

        body: TabBarDemo(
            controller: _controller,
            length:3,
            names:["Vaccancy","Results","Admit Card"],
            routes: [Vacancy(vaccancy),Vacancy(vaccancy),Vacancy(vaccancy)], title: getTranslated(context, 'job_alerts')!,
         // children: <Widget>[Vacancy(), Results(), AdmitCard()],
        ),


    );
  }
}
