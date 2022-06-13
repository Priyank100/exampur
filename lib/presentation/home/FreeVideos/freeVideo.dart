import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/Free_video_content_model.dart';
import 'package:exampur_mobile/data/model/free_video_list_model.dart';
import 'package:exampur_mobile/data/model/free_video_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeVideos extends StatefulWidget {
  final String url ;
   FreeVideos(this.url) : super();

  @override
  State<FreeVideos> createState() => _FreeVideosState();
}

class _FreeVideosState extends State<FreeVideos> {
  List<FreeVideoModel> freeVideo = [];
  FreeVideoListModel? freeVideoListModel;
  FreeVideoContentModel? freeVideoContentModel;
  String Videodata = '';
  bool isLoading = false;
  @override
  void initState() {
    getfreeVideos();
    super.initState();
  }
  Future<void> getfreeVideos() async {
    isLoading = true;
    freeVideo = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideo(context, widget.url))!;
    freeVideoListModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoList(context,'3'))!;
    freeVideoContentModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoContentList(context,'2'))!;
    print(freeVideoListModel!.name);
    isLoading =false;
    setState(() {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Free Video by Exampur',
                style: TextStyle(fontSize: 19),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Exam : ', style: TextStyle(fontSize: 15)),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: freeVideo.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return courseButton(index);
                        }),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Select Subject : ', style: TextStyle(fontSize: 15)),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: freeVideoListModel!.subject!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return subjectButton(index);
                        }),
                  ),
                )
              ],
            ),
            ListView.builder(
                itemCount: freeVideoContentModel!.chapter!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return chapterButton(index);
                }),

          ],
        )
    );
  }
  Widget courseButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(freeVideo[index].name.toString(),
              style: TextStyle(fontSize: 12)),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.black),
              backgroundColor:
               MaterialStateProperty.all<Color>(AppColors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)))),
          onPressed: () {

          }),
    );
  }
  Widget subjectButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(freeVideoListModel!.subject![index].name.toString(),
              style: TextStyle(fontSize: 12)),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.black),
              backgroundColor:  MaterialStateProperty.all<Color>(AppColors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)))),
          onPressed: () {


          }),
    );
  }
  Widget chapterButton(index) {
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              offset: Offset(0.0, 0.0),
              blurRadius: 1.0,
              spreadRadius: 0.0,
            ),
          ],
          color: AppColors.white,
        ),
      child:ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(freeVideoContentModel!.chapter![index].name.toString()),
            SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                for(var i =0;i<freeVideoContentModel!.chapter![index].videoContent!.length;i++)
              CustomAmberButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => YoutubeVideo(freeVideoContentModel!.chapter![index].videoContent![i].videoUrl.toString(),
                            freeVideoContentModel!.chapter![index].videoContent![i].title.toString())));
              },
                text:getTranslated(context, StringConstant.watch)!,),

              // CustomRoundButton(onPressed: (){},
              //     text:getTranslated(context, StringConstant.viewPdf)!),
              //   CustomSmallerElevatedButton(
              //     onPressed: (){},color: AppColors.green,text: 'Give Test',
              //   )
            ],)
          ],
        ),
      )
    );
  }
}
