import 'package:exampur_mobile/data/model/job_alert_model.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JobAlertViewContainer extends StatefulWidget {
  final List<JobAlertModel> list;
  final int index;
  const  JobAlertViewContainer(this.list, this.index) : super();
  @override
  _JobAlertViewContainerState createState() => _JobAlertViewContainerState();
}

class _JobAlertViewContainerState extends State<JobAlertViewContainer> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(5),
      leading: Image.asset(widget.list[widget.index].imagePath.toString(),height: 35,width: 45,),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.list[widget.index].title.toString()),
          SizedBox(height: 5,),
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
                      border: Border.all(color: Colors.black)
                  ),
                  child: Text('View', style: TextStyle(fontSize: 12)),
                ),
              ),
              SizedBox(width: 15,),
              Row(children: [
                Image.asset(Images.share,height: 15,width: 15,),
                SizedBox(width: 5,),
                Text('Share', style: TextStyle(fontSize: 10))
              ],)
            ],
          ),

        ],
      ),
    );


  }
}

