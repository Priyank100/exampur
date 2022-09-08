import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notifications.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotificationCourses extends StatefulWidget {
  Function callback;
   JobNotificationCourses(this.callback) : super();

  @override
  State<JobNotificationCourses> createState() => _JobNotificationCoursesState();
}

class _JobNotificationCoursesState extends State<JobNotificationCourses> {
  List<JobNotificationCourseModel> jobNotificationCourseList = [];
  List<FgBgColor> selectedColorList = [];
  String selectedCourseId = '';

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    jobNotificationCourseList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationCourseList(context))!;
    jobNotificationCourseList.insert(0, JobNotificationCourseModel(id: 0, name: 'ALL EXAM', description: '', order: 0, isActive: true));

    if(jobNotificationCourseList != null && jobNotificationCourseList.length > 0) {
      for (int i = 0; i < jobNotificationCourseList.length; i++) {
        selectedColorList.add(FgBgColor(MaterialStateProperty.all<Color>(AppColors.black), MaterialStateProperty.all<Color>(AppColors.white)));
      }
    }
    selectedColorList[0].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
    selectedColorList[0].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
    selectedCourseId = '';
    this.widget.callback(selectedCourseId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: jobNotificationCourseList.length,
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
              jobNotificationCourseList[index].name.toString(),
              style: TextStyle(fontSize: 12)
          ),
          style: ButtonStyle(
              foregroundColor: selectedColorList[index].fgColor,
              backgroundColor: selectedColorList[index].bgColor,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)
                  )
              )
          ),
          onPressed: () {
            for(int i=0; i<selectedColorList.length; i++) {
              selectedColorList[i].fgColor = MaterialStateProperty.all<Color>(AppColors.black);
              selectedColorList[i].bgColor = MaterialStateProperty.all<Color>(AppColors.white);
            }
            selectedColorList[index].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
            selectedColorList[index].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
            selectedCourseId = jobNotificationCourseList[index].id.toString();
            this.widget.callback(selectedCourseId);
            setState(() {});
          }
      ),
    );
  }
}

class FgBgColor {
  MaterialStateProperty<Color> fgColor;
  MaterialStateProperty<Color> bgColor;
  FgBgColor(this.fgColor, this.bgColor);
}
