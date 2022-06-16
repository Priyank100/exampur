import 'package:exampur_mobile/data/model/free_video_model.dart';
import 'package:exampur_mobile/data/model/job_notification_course_model.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeVideoCourse extends StatefulWidget {
  final String url ;
  FreeVideoCourse(this.url) : super();

  @override
  State<FreeVideoCourse> createState() => _FreeVideoCourseState();
}

class _FreeVideoCourseState extends State<FreeVideoCourse> {
  List<FreeVideoModel> freeVideo = [];

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    freeVideo = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideo(context,widget.url))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Exam : ',style: TextStyle(fontSize: 15),),
        Expanded(
          child: ListView.builder(
              itemCount: freeVideo.length,
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
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: ElevatedButton(
              child: Text(
                  freeVideo[index].name.toString(),
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
        ),
      ],
    );
  }
}
