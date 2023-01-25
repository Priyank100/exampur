import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';

class FreeCoursePlaylist extends StatefulWidget {
  const FreeCoursePlaylist({Key? key}) : super(key: key);

  @override
  State<FreeCoursePlaylist> createState() => _FreeCoursePlaylistState();
}

class _FreeCoursePlaylistState extends State<FreeCoursePlaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 4,
          itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(12)),
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
        );
      }),
    );
  }
}
