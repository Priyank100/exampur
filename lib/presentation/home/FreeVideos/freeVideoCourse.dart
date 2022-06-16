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
  List<FgBgColor> selectedColorList = [];
  String selectedCourseId = '';

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    freeVideo = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideo(context,widget.url))!;
    if(freeVideo.length != null && freeVideo.length > 0) {
      for (int i = 0; i < freeVideo.length; i++) {
        selectedColorList.add(FgBgColor(MaterialStateProperty.all<Color>(AppColors.black), MaterialStateProperty.all<Color>(AppColors.white)));
      }
    }
    selectedColorList[0].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
    selectedColorList[0].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
    selectedCourseId = '';
   // this.widget.callback(selectedCourseId);
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
                selectedCourseId = freeVideo[index].slug.toString();
              //  this.widget.callback(selectedCourseId);
                setState(() {});
              }
          ),
        ),
      ],
    );
  }
}
class FgBgColor {
  MaterialStateProperty<Color> fgColor;
  MaterialStateProperty<Color> bgColor;
  FgBgColor(this.fgColor, this.bgColor);
}