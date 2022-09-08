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

import 'freeVideoCourse.dart';
import 'freeVideoListing.dart';
import 'freeVideotag.dart';

class FreeVideos extends StatefulWidget {
  final String url ;
   FreeVideos(this.url) : super();

  @override
  State<FreeVideos> createState() => _FreeVideosState();
}

class _FreeVideosState extends State<FreeVideos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(5),
            height: 60,
            child: FreeVideoCourse(widget.url)
        ),
        Container(
            padding: const EdgeInsets.all(5),
            height: 60,
            child:  FreeVideoTag()
        ),
        Expanded(
            child: FreeVideoListing()
        )
      ],
    ),
    );
  }

}
