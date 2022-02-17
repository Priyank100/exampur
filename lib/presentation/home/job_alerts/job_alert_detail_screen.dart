import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class JobAlertDetailScreen extends StatefulWidget {
  final String id;
  const JobAlertDetailScreen(this.id) : super();

  @override
  _JobAlertDetailScreenState createState() => _JobAlertDetailScreenState();
}

class _JobAlertDetailScreenState extends State<JobAlertDetailScreen> {
  DetailsData? jobAlertsData;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    jobAlertsData = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobAlertsDetails(context,widget.id.toString()))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(),
      body: jobAlertsData == null ?
      Center(child: CircularProgressIndicator(color: AppColors.amber)) :
      Padding(
        padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, StringConstant.jobAlerts)!, style: CustomTextStyle.headingMediumBold(context)),
              Expanded(child: SingleChildScrollView(
                  child: Html(data:utf8.decode(base64.decode(jobAlertsData!.description.toString())))
              )
              )
            ]
          )
      )
    );
  }
}
