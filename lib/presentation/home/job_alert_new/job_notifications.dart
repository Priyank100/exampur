import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_list_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_courses.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_listing.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notificaton_tag.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotifications extends StatefulWidget {
  const JobNotifications() : super();

  @override
  State<JobNotifications> createState() => _JobNotificationsState();
}

class _JobNotificationsState extends State<JobNotifications> {
  String courseId = '';
  String tagSlug = '';
  JobNotificationListModel? jobNotificationListModel;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child:  JobNotificationCourses(this.callback)
          ),
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child:  JobNotificationTag(this.callback2)
          ),
           tagSlug.isEmpty ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
           Expanded(
              child: isLoading ?
              Center(child: CircularProgressIndicator(color: AppColors.amber)) :
              JobNotificationListing(jobNotificationListModel!)
          )
        ],
      ),
    );
  }

  void callback(String courseId) {
    this.courseId = courseId;
    getJobNotificationListing();
    setState(() {});
  }

  void callback2(String tagSlug) {
    this.tagSlug = tagSlug;
    getJobNotificationListing();
    setState(() {});
  }

  Future<void> getJobNotificationListing() async {
    isLoading = true;
    jobNotificationListModel = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationData(context, tagSlug, courseId))!;
    isLoading = false;
    setState(() {});
  }
}
