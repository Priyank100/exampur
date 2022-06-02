import 'package:exampur_mobile/data/model/job_notification_list_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JobNotificationListing extends StatefulWidget {
  const JobNotificationListing({Key? key}) : super(key: key);

  @override
  State<JobNotificationListing> createState() => _JobNotificationListingState();
}

class _JobNotificationListingState extends State<JobNotificationListing> {
  JobNotificationListModel? jobNotificationListModel;
  bool isLoading = true;

  @override
  void initState() {
    getNotificationList();
    super.initState();
  }

  Future<void> getNotificationList() async {
    isLoading = true;
    jobNotificationListModel = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationData(context,'latest-jobs',''))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
    jobNotificationListModel == null || jobNotificationListModel!.notification!.length == 0 ?
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
            child: Text(jobNotificationListModel!.tagName.toString(), style: TextStyle(color: AppColors.white)),
          )
        ],
      ),
    );
  }
}
