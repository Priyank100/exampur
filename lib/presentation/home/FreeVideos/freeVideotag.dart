import 'package:exampur_mobile/data/model/free_video_list_model.dart';
import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/data/model/job_notification_tag_model.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeVideoTag extends StatefulWidget {

  FreeVideoTag() : super();

  @override
  State<FreeVideoTag> createState() => _FreeVideoTagState();
}

class _FreeVideoTagState extends State<FreeVideoTag> {
  FreeVideoListModel? freeVideoListModel;

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    freeVideoListModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoList(context,'3'))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return freeVideoListModel == null || freeVideoListModel!.subject!.length == 0 ?
   SizedBox() :
      Row(
        children: [
          Text('Select Subject : ',style: TextStyle(fontSize: 15)),
          Expanded(
            child: ListView.builder(
              itemCount:freeVideoListModel!.subject!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return courseButton(index);
              }
    ),
          ),
        ],
      );
  }

  Widget courseButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(
              freeVideoListModel!.subject![index].name.toString(),
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
