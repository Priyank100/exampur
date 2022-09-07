import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';


class TitleRow extends StatelessWidget {
  final String title;
  final Function() onTap;
  //final Duration eventDuration;
  //final bool isDetailsPage;
  TitleRow({required this.title, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    // int days, hours, minutes, seconds;
    // if (eventDuration != null) {
    //   days = eventDuration.inDays;
    //   hours = eventDuration.inHours - days * 24;
    //   minutes = eventDuration.inMinutes - (24 * days * 60) - (hours * 60);
    //   seconds = eventDuration.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    // }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Text(title,style: CustomTextStyle.headingBold(context)),

      onTap != null
          ? InkWell(
        onTap: onTap,
        child: Row(children: [
         // isDetailsPage == null
          Text(getTranslated(context, LangString.viewAll)!,

              ),
             // : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.amber,
              size: Dimensions.FONT_SIZE_SMALL,
            ),
          ),
        ]),
      )
          : SizedBox.shrink(),
    ]);
  }
}

class TimerBox extends StatelessWidget {
  final int time;
  final bool isBorder;

  TimerBox({required this.time, this.isBorder = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.all(isBorder ? 0 : 2),
      decoration: BoxDecoration(
        color: isBorder ? null : AppColors.amber,
        border: isBorder ? Border.all(width: 2, color: AppColors.amber) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(time < 10 ? '0$time' : time.toString(),
          style: TextStyle(
            color: isBorder ? AppColors.amber : Theme.of(context).accentColor,
            fontSize: Dimensions.FONT_SIZE_SMALL,
          ),
        ),
      ),
    );
  }
}
