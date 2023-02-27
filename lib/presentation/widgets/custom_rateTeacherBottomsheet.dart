import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/widgets/RateTeacher_bottomsheet.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utils/analytics_constants.dart';
import '../../utils/app_constants.dart';

class RateTeacherBottom{
  static void rateTeacherBottomSheet(context, Function refresh) {
    IconData? _selectedIcon;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
    ),
    context: context,
    builder: (BuildContext bc) {
    return Container(
      height: MediaQuery.of(context).size.height/3.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topRight,
                child:Icon(Icons.clear),),
            ),
          ),
          Text(getTranslated(context, LangString.howWasTheLeacture)!, style: TextStyle(fontSize: 20),),
          SizedBox(height: 15,),
          Text(getTranslated(context, LangString.yourRatingHelpUsImprove)!, style: TextStyle(fontSize: 15,color: Colors.grey),),
          SizedBox(height: 10,),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, _) => Icon(
              _selectedIcon ?? Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              Navigator.pop(context);
              var map = {
                'Page_Name':'Recorded_Video',
                'Mobile_Number':AppConstants.userMobile,
                'Language':AppConstants.langCode,
                'User_ID':AppConstants.userMobile,
                "topic":AppConstants.timlineName,
                "class type":AppConstants.teacherRatingType == 0 ? "live":"recorded",
                "rating count":rating.toString()
              };
              AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_rating_count, map);
              RateTeacheFullrBottom.rateTeacherFullBottomSheet(context,rating, refresh);
            },
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(getTranslated(context, LangString.veryPoor)!,style: TextStyle(color: Colors.grey),),
              Text(getTranslated(context, LangString.excellent)!,style: TextStyle(color: Colors.grey)),
            ],
          )
        ],
      ),
    );
        });
  }
}