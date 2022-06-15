import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/Free_video_content_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FreeVideoListing extends StatefulWidget {
  FreeVideoListing() : super();

  @override
  State<FreeVideoListing> createState() => _FreeVideoListingState();
}

class _FreeVideoListingState extends State<FreeVideoListing> {
  FreeVideoContentModel? freeVideoContentModel;
  bool isLoading = true;

  @override
  void initState() {
    getNotificationList();
    super.initState();
  }

  Future<void> getNotificationList() async {
    isLoading = true;
    freeVideoContentModel = (await Provider.of<FreeVideoProvider>(context, listen: false).getfreeVideoContentList(context,'2'))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        freeVideoContentModel == null || freeVideoContentModel!.chapter!.length == 0 ?
      AppConstants.noDataFound() :
        ListView.builder(
            itemCount: freeVideoContentModel!.chapter!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return chapterButton(index);
            });
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
