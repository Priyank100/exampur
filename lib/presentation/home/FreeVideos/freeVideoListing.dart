import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/Free_video_content_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button_amber_color_watch.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/shared/youtube_video.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/dimensions.dart';
import 'freeVideoCoursedetail.dart';

class FreeVideoListing extends StatefulWidget {
  FreeVideoListing() : super();

  @override
  State<FreeVideoListing> createState() => _FreeVideoListingState();
}

class _FreeVideoListingState extends State<FreeVideoListing> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return chapterButton(index);
            });
  }
  Widget chapterButton(index) {
    return InkWell(
      onTap: (){
        AppConstants.goTo(context, FreeVideoDetail());
      },
      child: Container(
          margin: EdgeInsets.all(10),
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
          child:Row(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green
              ),
                width: 200,
                height: 130,
                // child: Image.network(API.homeBanner_URL + widget.listData.imagePath.toString(), fit: BoxFit.fill)
                child: AppConstants.image('', boxfit: BoxFit.fill)
            ),
            SizedBox(width: 10,),
           Flexible(child: Column(
               mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text('rdtfgyhjkml,.dfghjkm',style: TextStyle(fontSize: 18),),
              SizedBox(height: 30,),
              Text('rdtfgyhjkml,.dfghjkm'),
                SizedBox(height: 10,)
            ],))
          ],)
      ),
    );
  }
}
