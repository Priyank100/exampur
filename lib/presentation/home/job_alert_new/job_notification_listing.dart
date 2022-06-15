import 'package:exampur_mobile/data/model/job_notification_list_model.dart';
import 'package:exampur_mobile/presentation/home/job_alert_new/job_notification_details.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class JobNotificationListing extends StatefulWidget {
  final JobNotificationListModel jobNotificationListModel;
  JobNotificationListing(this.jobNotificationListModel) : super();

  @override
  State<JobNotificationListing> createState() => _JobNotificationListingState();
}

class _JobNotificationListingState extends State<JobNotificationListing> {

  @override
  Widget build(BuildContext context) {
    return widget.jobNotificationListModel == null || widget.jobNotificationListModel.notification!.length == 0 ?
    AppConstants.noDataFound() :
    Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)
              ),
              color: AppColors.amber,
            ),
            height: MediaQuery.of(context).size.width/8,
            alignment: Alignment.center,
            child: Text(widget.jobNotificationListModel.tagName.toString(), style: TextStyle(color: AppColors.white)),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: widget.jobNotificationListModel.notification!.length,
                itemBuilder: (context,i) {
                  return dataList(i);
            }),
          )
        ],
      ),
    );
  }

  Widget dataList(i){
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(widget.jobNotificationListModel.notification![i].updated.toString());
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd\nyyyy');
    var outputDate = outputFormat.format(inputDate);
    return InkWell(
      onTap: () {
        AppConstants.goTo(context, JobNotificationDetails(widget.jobNotificationListModel.notification![i].id.toString()));
      },
      child: Column(
        children: [
          Row(
            children: [
              Text(outputDate, textAlign: TextAlign.center),
              SizedBox(width: 10),
              Flexible(child: Text(widget.jobNotificationListModel.notification![i].title.toString())),
            ],
          ),
          Divider(color: AppColors.grey500)
        ],
      ),
    );
  }
}
