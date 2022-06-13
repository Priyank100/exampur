import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotificationCourses extends StatefulWidget {
  List<JobNotificationCourseModel> jobNotificationCourseList;
   JobNotificationCourses(this.jobNotificationCourseList) : super();

  @override
  State<JobNotificationCourses> createState() => _JobNotificationCoursesState();
}

class _JobNotificationCoursesState extends State<JobNotificationCourses> {
  // List<JobNotificationCourseModel> jobNotificationCourseList = [];
  //
  // @override
  // void initState() {
  //   getCoursesList();
  //   super.initState();
  // }
  //
  // Future<void> getCoursesList() async {
  //   jobNotificationCourseList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationCourseList(context))!;
  //   jobNotificationCourseList.insert(0, JobNotificationCourseModel(id: 0, name: 'ALL EXAM', description: '', order: 0, isActive: true));
  //   setState(() {});
  // }
  //
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.jobNotificationCourseList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return courseButton(index);
        }
    );
  }

  Widget courseButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(
              widget.jobNotificationCourseList[index].name.toString(),
              style: TextStyle(fontSize: 12)
          ),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(AppColors.black),
              backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)
                  )
              )
          ),
          onPressed: () {
            if(index == 0){

            }
          }
      ),
    );
  }
}
