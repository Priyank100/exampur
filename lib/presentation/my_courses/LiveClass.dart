import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class LiveClass extends StatelessWidget {
  const LiveClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView.builder(itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context,int index){
            return Container(
              //color: AppColors.amber,
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Row(
                  children: [
                    Container(
                      width: Dimensions.AppTutorialImageWidth,
                      height: Dimensions.AppTutorialImageHeight,
                      child: Image.asset(Images.studymaterial,fit: BoxFit.fill,),
                      // child: Image.network(AppConstants.BANNER_BASE+widget.demoList[widget.index].bannerPath.toString(), fit: BoxFit.fill)
                      //child: AppConstants.image(AppConstants.BANNER_BASE+widget.demoList[widget.index].bannerPath.toString(), boxfit: BoxFit.fill)
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Example',overflow: TextOverflow.ellipsis, maxLines: 2,),
                          SizedBox(height: 25,),
                          Row(
                            children: [
                              Container(
                                width: Dimensions.AppTutorialImageHeight,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:AppColors.dark),
                                child: MaterialButton(

                                  child: Row(
                                    children: [
                                      Icon(Icons.play_arrow, color: AppColors.white,size: 10,),
                                      Text(getTranslated(context, StringConstant.watch)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white))
                                    ],
                                  ),
                                  onPressed: () {

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AppTutorialVideo(widget.list[widget.index].videoPath.toString(),
                                    //             widget.list[widget.index].title.toString())));
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
          } ),
    );
  }
}
