import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_courses.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_listing.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notificaton_tag.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';

class JobNotifications extends StatefulWidget {
  const JobNotifications() : super();

  @override
  State<JobNotifications> createState() => _JobNotificationsState();
}

class _JobNotificationsState extends State<JobNotifications> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child: const JobNotificationCourses()
          ),
          Container(
              padding: const EdgeInsets.all(5),
              height: 60,
              child: const JobNotificationTag()
          ),
          const Expanded(
              child: JobNotificationListing()
          )
        ],
      ),
    );
  }
}
