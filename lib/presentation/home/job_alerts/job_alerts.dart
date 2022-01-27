import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_model.dart';
import 'package:exampur_mobile/data/model/job_alert_post_api.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/admit_card.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/results.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/vacancy.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/JobAlertprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exampur_mobile/data/model/job_alert_tab__model.dart';

class JobAlerts extends StatefulWidget {
  @override
  JobAlertsState createState() => JobAlertsState();
}

class JobAlertsState extends State<JobAlerts> with TickerProviderStateMixin {
  Set<String> selected = new Set<String>();
  List<JobAlertModel > vaccancy = [];
  List<Data> jobalertTabList = [];
   TabController? _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // _controller = TabController(length: jobalertTabList.length, vsync: this);
     getLists();
    // _controller.addListener(() {
    //   setState(() {
    //     _selectedIndex = _controller.index;
    //   });
    //   print("Selected Index: " + _controller.index.toString());
    //   switch( _controller.index) {
    //     case 0:
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
    //       break;
    //     case 1:
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
    //       break;
    //     case 3:
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't1',target: 'tg1'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't2',target: 'tg2'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't3',target: 'tg3'));
    //       vaccancy.add(JobAlertModel(imagePath: Images.exampur_logo,title: 't4',target: 'tg4'));
    //       break;
    //   }
    // });
  }

  Future<void> getLists() async {
    jobalertTabList = (await Provider.of<JobAlertsProvider>(context, listen: false).getjobalertsTabList(context))!;
    AppConstants.printLog(jobalertTabList.length);
  }

  Widget build(BuildContext context) {
  return FutureBuilder(
      // future: getLists(),
      future: Future.delayed(Duration.zero, () => getLists()),
    builder: (context, snapshot) {
    return Scaffold(

        body: TabBarDemo(
            controller: _controller,
            length:jobalertTabList.length,
            names:jobalertTabList.map((item) => item.name.toString()).toList(),
            routes: [
             // Vacancy(vaccancy),Vacancy(vaccancy),Vacancy(vaccancy)
            ],
          title: getTranslated(context, 'job_alerts')!,
         // children: <Widget>[Vacancy(), Results(), AdmitCard()],
        ),


    );
    });
  }
  // _updateUserAccount(_message) async {
  //
  //   // CreateUserModel updateUserInfoModel = Provider.of<AuthProvider>(context, listen: false).uerupdate;
  //   JobAlertPostApi jobAlertPostApiModel = JobAlertPostApi();
  //
  //   jobAlertPostApiModel.category;
  //   jobAlertPostApiModel.alertCategoryId =j;
  //
  //
  //   await Provider.of<JobAlertsProvider>(context, listen: false).jobalert(jobAlertPostApiModel).then((response) {
  //     isLoading = false;
  //     if(response) {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, 'issue_submitted_sucessfully')!), backgroundColor: AppColors.green));
  //       Navigator.pop(context);
  //     }else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context,'server_error')!), backgroundColor: AppColors.red));
  //     }
  //     setState(() {});
  //   }
  //   );
  // }
  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }
  }
