import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exampur_mobile/data/model/job_alert_tab_model.dart';

import 'job_alert_list_screen.dart';

class JobAlerts extends StatefulWidget {

  @override
  JobAlertsState createState() => JobAlertsState();
}

class JobAlertsState extends State<JobAlerts> with TickerProviderStateMixin {
  List<TabData> jobAlertTabList = [];
  TabController? _controller;

  @override
  void initState() {
    getLists();
    // AppConstants.printLog('anchal');
    // AppConstants.printLog(widget.choosecategorylist.first.id.toString());
    super.initState();
  }

  Future<void> getLists() async {
    jobAlertTabList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobAlertsTabList(context))!;
    AppConstants.printLog(jobAlertTabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration.zero, () => getLists()),
        builder: (context, snapshot) {
          return Scaffold(
            body: TabBarDemo(
              controller: _controller,
              length: jobAlertTabList.length,
              names: jobAlertTabList.map((item) => item.name.toString()).toList(),
              routes: jobAlertTabList.map((item) => JobAlertListScreen(item.id.toString())).toList(),
              title: getTranslated(context, LangString.jobAlerts)!,
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
