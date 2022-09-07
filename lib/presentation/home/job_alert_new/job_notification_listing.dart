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
  List<NotificationData> dataList = [];
  String nextUrl = '';
  var scrollController = ScrollController();
  bool isBottomLoading = false;

  @override
  void initState() {
    dataList = widget.jobNotificationListModel.notification??[];
    nextUrl = widget.jobNotificationListModel.next.toString();
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        nextPage();
      });
    }
  }

  Future<void> nextPage() async {
    if(widget.jobNotificationListModel.count! > 10 && nextUrl != 'null' && nextUrl != '') {
      isBottomLoading = true;
      JobNotificationListModel model = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationNext(context, nextUrl))!;
      dataList.insertAll(dataList.length, model.notification!);
      nextUrl = model.next.toString();
      isBottomLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.jobNotificationListModel == null || dataList.length == 0 ?
    AppConstants.noDataFound() :
    Container(
      height: MediaQuery.of(context).size.height/1.5,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
             Radius.circular(20)
          ),
        border: Border.all(color: AppColors.grey400)
      ),
      // elevation: 10,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
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
              controller: scrollController,
              itemCount: dataList.length,
                itemBuilder: (context,i) {
                  return dataListItem(i);
            }),
          ),
          isBottomLoading ? CircularProgressIndicator(color: AppColors.amber,) : SizedBox()
        ],
      ),
    );
  }

  Widget dataListItem(i){
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(dataList[i].updated.toString());
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('MMM dd\nyyyy');
    var outputDate = outputFormat.format(inputDate);
    return InkWell(
      onTap: () {
        AppConstants.goTo(context, JobNotificationDetails(dataList[i].id.toString()));
      },
      child: Column(
        children: [
          Row(
            children: [
              Text(outputDate, textAlign: TextAlign.center),
              SizedBox(width: 10),
              Flexible(child: Text(dataList[i].title.toString(),)),
            ],
          ),
          Divider(color: AppColors.grey500),

        ],
      ),
    );
  }
}
