import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/contentDetailpage.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class DailyMonthlyCard extends StatefulWidget {
  final Data listData;
  final int index;
  final String type;

  const DailyMonthlyCard(this.listData, this.index,this.type) : super();

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
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            children: [
              widget.listData.type.toString() == 'Content' ?
              Container(
                  width: Dimensions.DailyMonthlyImageWidth,
                  height: Dimensions.DailyMonthlyImageHeight,
                  child: widget.listData.bannerPath.toString().contains('http') ?
                  AppConstants.image( widget.listData.bannerPath.toString()) :
                  AppConstants.image(AppConstants.BANNER_BASE + widget.listData.bannerPath.toString())
              ) :
              Container(
                  width: Dimensions.DailyMonthlyImageWidth,
                  height: Dimensions.DailyMonthlyImageHeight,
                  child: Image.asset(Images.pdfIcon)
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.listData.title.toString(), overflow: TextOverflow.ellipsis, maxLines: 2),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            // viewId
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                ContentDetailPage(widget.listData,widget.type)
                            ));
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
                        // InkWell(
                        //   onTap: (){
                        //     // shareText
                        //   },
                        //   child: Row(
                        //     children: [
                        //       Icon(Icons.share_outlined, size: 15),
                        //       SizedBox(width: 5),
                        //       Text(getTranslated(context, 'share')!, style: TextStyle(fontSize: 10)),
                        //       SizedBox(width: 10),
                        //
                        //     ],
                        //   ),
                        // )
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
