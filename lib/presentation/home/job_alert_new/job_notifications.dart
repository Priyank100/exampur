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
  List<JobNotificationCourseModel> jobNotificationCourseList = [];
  List<JobNotificationTagModel> jobNotificationTagList = [];
  JobNotificationListModel? jobNotificationListModel;
  bool isLoading = false;

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    isLoading = true ;
    jobNotificationCourseList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationCourseList(context))!;
    jobNotificationCourseList.insert(0, JobNotificationCourseModel(id: 0, name: 'ALL EXAM', description: '', order: 0, isActive: true));
    jobNotificationTagList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationTagList(context))!;
    jobNotificationListModel = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationData(context,'latest-jobs',''))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:  isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
      jobNotificationCourseList == null || jobNotificationCourseList.length == 0 ||jobNotificationTagList == null || jobNotificationTagList.length == 0 || jobNotificationListModel == null || jobNotificationListModel!.notification!.length == 0  ?
      AppConstants.noDataFound() :
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child:  JobNotificationCourses(jobNotificationCourseList)
          ),
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child:  JobNotificationTag(jobNotificationTagList)
          ),
           Expanded(
              child: JobNotificationListing(jobNotificationListModel)
          )
        ],
      ),
    );
  }
}
