import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotificationTag extends StatefulWidget {
  Function callback2;
  final String? tagSlugMoE;
  JobNotificationTag(this.callback2, {this.tagSlugMoE}) : super();

  @override
  State<JobNotificationTag> createState() => _JobNotificationTagState();
}

class _JobNotificationTagState extends State<JobNotificationTag> {
 List<JobNotificationTagModel> jobNotificationTagList = [];
 List<FgBgColor> selectedColorList = [];
 String selectedTagSlug = '';

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    jobNotificationTagList = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationTagList(context))!;

    if(jobNotificationTagList != null && jobNotificationTagList.length > 0) {
      for (int i = 0; i < jobNotificationTagList.length; i++) {
        selectedColorList.add(FgBgColor(MaterialStateProperty.all<Color>(AppColors.black), MaterialStateProperty.all<Color>(AppColors.white)));
      }
    }
    // selectedColorList[0].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
    // selectedColorList[0].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
    // selectedTagSlug = jobNotificationTagList[0].slug.toString();

    if(widget.tagSlugMoE == null) {
      selectedColorList[0].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
      selectedColorList[0].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
      selectedTagSlug = jobNotificationTagList[0].slug.toString();
    } else {
      selectedTagSlug = widget.tagSlugMoE!;
      for(int i=0; i<jobNotificationTagList.length; i++) {
        if(jobNotificationTagList[i].slug == widget.tagSlugMoE) {
          selectedColorList[i].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
          selectedColorList[i].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
        }
      }
    }

    this.widget.callback2(selectedTagSlug);
    setState(() {});

    //   selectedCourseId = widget.courseIdMoE!;
    //   for(int i=0; i<jobNotificationCourseList.length; i++) {
    //     if(jobNotificationCourseList[i].id.toString() == widget.courseIdMoE) {
    //       selectedColorList[i].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
    //       selectedColorList[i].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
    //     }
    //   }
    // }
    // this.widget.callback(selectedCourseId);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: jobNotificationTagList.length,
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
             jobNotificationTagList[index].name.toString(),
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
          onPressed: (){
            for(int i=0; i<selectedColorList.length; i++) {
              selectedColorList[i].fgColor = MaterialStateProperty.all<Color>(AppColors.black);
              selectedColorList[i].bgColor = MaterialStateProperty.all<Color>(AppColors.white);
            }
            selectedColorList[index].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
            selectedColorList[index].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
            selectedTagSlug = jobNotificationTagList[index].slug.toString();
            this.widget.callback2(selectedTagSlug);
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
