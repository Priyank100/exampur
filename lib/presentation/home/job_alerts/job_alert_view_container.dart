import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/presentation/home/job_alerts/job_alert_detail_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobAlertViewContainer extends StatefulWidget {
  final ListData dataList;
  const  JobAlertViewContainer(this.dataList) : super();

  @override
  _JobAlertViewContainerState createState() => _JobAlertViewContainerState();
}

class _JobAlertViewContainerState extends State<JobAlertViewContainer> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Image.asset(Images.exampur_logo, width: 60),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.dataList.title.toString()),
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => JobAlertDetailScreen(widget.dataList.id.toString())));
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
              SizedBox(width: 15,),
              Row(children: [
                Image.asset(Images.share,height: 15,width: 15,),
                SizedBox(width: 5,),
                Text(getTranslated(context, 'share')!, style: TextStyle(fontSize: 10))
              ],)
            ],
          ),
        ],
      ),
    );
  }
}

