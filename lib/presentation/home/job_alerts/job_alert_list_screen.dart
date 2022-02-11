import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alert_list_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_alert_view_container.dart';

class JobAlertListScreen extends StatefulWidget {
  final String tabId;
  const JobAlertListScreen(this.tabId) : super();

  @override
  _JobAlertListScreenState createState() => _JobAlertListScreenState();
}

class _JobAlertListScreenState extends State<JobAlertListScreen> {
  List<ListData> alertsDataList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  bool isBottomLoading = false;
  int page = 0;
  bool isData = true;

  @override
  void initState() {
    scrollController.addListener(pagination);
    getLists(page);
    super.initState();
  }

  Future<void> getLists(pageNo) async {
    isLoading = true;

    List<ListData> list = (await Provider.of<JobAlertsProvider>(context, listen: false).
    getJobAlertsList(context, widget.tabId.toString(), AppConstants.encodeCategory(), page))!;

     if(list.length > 0) {
       isData = true;
       alertsDataList = alertsDataList + list;
     } else {
       isData = false;
     }
     isLoading = false;
     isBottomLoading = false;
     setState(() {});
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isBottomLoading = true;
        getLists(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
      alertsDataList.length==0 ?
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline),
          Text(getTranslated(context, StringConstant.noData)!)
        ],
      )) : listing(alertsDataList),
      bottomNavigationBar: isBottomLoading ? Container(
          padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator())) :
      SizedBox(),
    );
  }

  Widget listing(list) {
    return ListView.builder(itemCount:list.length,controller: scrollController,
        itemBuilder: (BuildContext context,int index){
          return JobAlertViewContainer(alertsDataList[index]);
        });
  }
}

