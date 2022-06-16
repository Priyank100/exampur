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
  List<FgBgColor> selectedColorList = [];
  String selectedTagSlug = '';

  @override
  void initState() {
    getCoursesList();
    super.initState();
  }

  Future<void> getCoursesList() async {
    freeVideoListModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoList(context,'3'))!;
    if(freeVideoListModel != null && freeVideoListModel!.subject!.length > 0) {
      for (int i = 0; i < freeVideoListModel!.subject!.length; i++) {
        selectedColorList.add(FgBgColor(MaterialStateProperty.all<Color>(AppColors.black), MaterialStateProperty.all<Color>(AppColors.white)));
      }
    }
    selectedColorList[0].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
    selectedColorList[0].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
    selectedTagSlug =freeVideoListModel!.subject![0].id.toString();

   // this.widget.callback2(selectedTagSlug);
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
            for(int i=0; i<selectedColorList.length; i++) {
              selectedColorList[i].fgColor = MaterialStateProperty.all<Color>(AppColors.black);
              selectedColorList[i].bgColor = MaterialStateProperty.all<Color>(AppColors.white);
            }
            selectedColorList[index].fgColor = MaterialStateProperty.all<Color>(AppColors.white);
            selectedColorList[index].bgColor = MaterialStateProperty.all<Color>(AppColors.amber);
            selectedTagSlug = freeVideoListModel!.subject![0].id.toString();
           // this.widget.callback2(selectedTagSlug);
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