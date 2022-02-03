import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_content_model.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';

class DailyMonthlyCard extends StatefulWidget {
  final List<CaContentModel> list;
  final int index;
  const DailyMonthlyCard(this.list, this.index) : super();

  @override
  _DailyMonthlyCardState createState() => _DailyMonthlyCardState();
}

class _DailyMonthlyCardState extends State<DailyMonthlyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0
          ? Theme.of(context).backgroundColor
          : AppColors.transparent,
     // margin: EdgeInsets.all(5),
     //  child: Card(
        //elevation: 2,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              Container(
                  width: Dimensions.DailyMonthlyImageWidth,
                  height: Dimensions.DailyMonthlyImageHeight,
                  child: Image.asset(widget.list[widget.index].imagePath.toString())
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.list[widget.index].title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            // viewId
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            width: Dimensions.DailyMonthlyViewBtnWidth,
                            height: Dimensions.DailyMonthlyViewBtnHeight,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.black)
                            ),
                            child: Text(getTranslated(context, 'view')!, style: TextStyle(fontSize: 12)),
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.remove_red_eye, size: 10),
                        SizedBox(width: 5),
                        Text(widget.list[widget.index].viewCount.toString(), style: TextStyle(fontSize: 10)),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: (){
                            // shareText
                          },
                          child: Row(
                            children: [
                              Icon(Icons.share_outlined, size: 15),
                              SizedBox(width: 5),
                              Text(getTranslated(context, 'share')!, style: TextStyle(fontSize: 10)),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
     // ),
    );
  }
}
