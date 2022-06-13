import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotificationTag extends StatefulWidget {
  List<JobNotificationTagModel> jobNotificationTagList;
   JobNotificationTag(this.jobNotificationTagList) : super();

  @override
  State<JobNotificationTag> createState() => _JobNotificationTagState();
}

class _JobNotificationTagState extends State<JobNotificationTag> {
 // List<JobNotificationTagModel> jobNotificationTagList = [];

  // @override
  // void initState() {
  //   getCoursesList();
  //   super.initState();
  // }
  //
  // Future<void> getCoursesList() async {
  //   jobNotificationTagList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationTagList(context))!;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.jobNotificationTagList.length,
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
             widget.jobNotificationTagList[index].name.toString(),
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
          onPressed: (){

          }
      ),
    );
  }
}
