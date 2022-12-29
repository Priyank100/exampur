import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_list_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_courses.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_listing.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notificaton_tag.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotifications extends StatefulWidget {
  final String? courseIdMoE;
  final String? tagSlugMoE;
  JobNotifications({this.courseIdMoE, this.tagSlugMoE}) : super();

  @override
  State<JobNotifications> createState() => _JobNotificationsState();
}

class _JobNotificationsState extends State<JobNotifications> {
  String courseId = '';
  String tagSlug = '';
  JobNotificationListModel? jobNotificationListModel;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    courseId = widget.courseIdMoE == null ? '' : widget.courseIdMoE!;
    tagSlug = widget.tagSlugMoE == null ? '' : widget.tagSlugMoE!;
    setState((){});
  }

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
              child:  JobNotificationCourses(this.callback, courseIdMoE: widget.courseIdMoE)
          ),
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child:  JobNotificationTag(this.callback2, tagSlugMoE: widget.tagSlugMoE)
          ),
           tagSlug.isEmpty ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
           // Expanded(
           //    child:
              isLoading ?
              Center(child: CircularProgressIndicator(color: AppColors.amber)) :
              JobNotificationListing(jobNotificationListModel!)
         // )
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
    if(tagSlug.isNotEmpty) {
      isLoading = true;
      jobNotificationListModel =
      (await Provider.of<JobAlertsProvider>(context, listen: false)
          .getJobNotificationData(context, tagSlug, courseId))!;
      isLoading = false;
      setState(() {});
    }
  }
}
