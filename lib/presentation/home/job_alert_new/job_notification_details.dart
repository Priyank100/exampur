import 'package:exampur_mobile/data/model/job_notification_detail_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class JobNotificationDetails extends StatefulWidget {
  final String articleId;
  const JobNotificationDetails(this.articleId) : super();

  @override
  State<JobNotificationDetails> createState() => _JobNotificationDetailsState();
}

class _JobNotificationDetailsState extends State<JobNotificationDetails> {
  JobNotificationDetailModel? jobNotificationDetailModel;
  bool isLoading = true;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async {
    isLoading = true;
    jobNotificationDetailModel = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationDetail(context, widget.articleId))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        jobNotificationDetailModel == null ? AppConstants.noDataFound() :
        SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobNotificationDetailModel!.title.toString(), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Html(
                    data: jobNotificationDetailModel!.contentModule![0].description.toString(),
                    style: {
                      'body': Style(
                        fontSize: const FontSize(12),
                      )}),
              ]),
        ),
      ),

    );
  }
}