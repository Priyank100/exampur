import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/my_course_material_model.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class SelectChapterView extends StatefulWidget {
  final MaterialData data;
  const SelectChapterView(this.data) : super();

  @override
  State<SelectChapterView> createState() => _SelectChapterViewState();
}

class _SelectChapterViewState extends State<SelectChapterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(itemCount: 1,
    padding: EdgeInsets.all(5),
    shrinkWrap: true,
    itemBuilder: (BuildContext context,int index){
        return Container(
          margin: EdgeInsets.all(5),
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: [
                Container(
                    width: Dimensions.AppTutorialImageWidth,
                    height: Dimensions.AppTutorialImageHeight,
                    child: Image.asset(Images.studymaterial,fit: BoxFit.fill,),
                    ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.subjectId!.title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Container(
                            width: Dimensions.AppTutorialImageHeight,
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:AppColors.dark),
                            child: widget.data.videoLink == null || widget.data.videoLink.toString().isEmpty ?
                            SizedBox() :
                            MaterialButton(
                              child: Row(
                                children: [
                                  Icon(Icons.play_arrow, color: AppColors.white,size: 10,),
                                  Text(getTranslated(context, StringConstant.watch)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white))
                                ],
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => YoutubeVideo(widget.data.videoLink.toString(),
                                            widget.data.title.toString())
                                    )
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:Color(0xFF1c1d3b)),
                            child: widget.data.pdfPath == null || widget.data.pdfPath.toString().isEmpty ?
                            SizedBox() :
                            MaterialButton(
                              child:
                              Text(getTranslated(context, StringConstant.viewPdf)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white)),

                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ViewPdf(AppConstants.BANNER_BASE + widget.data.pdfPath.toString(),'')
                                    )
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
