import 'dart:convert';
import 'dart:io';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/job_alerts_detail_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class JobAlertDetailScreen extends StatefulWidget {
  final String id;
  const JobAlertDetailScreen(this.id) : super();

  @override
  _JobAlertDetailScreenState createState() => _JobAlertDetailScreenState();
}

class _JobAlertDetailScreenState extends State<JobAlertDetailScreen> {
  DetailsData? jobAlertsData;

  @override
  void initState() {
    callProvider();
    super.initState();
  }

  Future<void> callProvider() async {
    jobAlertsData = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobAlertsDetails(context,widget.id.toString()))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: jobAlertsData == null || jobAlertsData!.pdfPath==null ? CustomAppBar() : null,
      body:
      jobAlertsData == null ?
      Center(child: LoadingIndicator(context)) : jobAlertsData!.pdfPath==null?
      AppConstants.noDataFound():
      jobAlertsData!.pdfPath.toString().contains('http') ?
      ViewPdf(jobAlertsData!.pdfPath.toString(),'') :
      ViewPdf(AppConstants.BANNER_BASE + jobAlertsData!.pdfPath.toString(),'')
      // InkWell(
      //     onTap: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (_) =>
      //           ViewPdf(AppConstants.BANNER_BASE + jobAlertsData!.pdfPath.toString(),'')
      //       ));
      //     },
      //     child: Text(getTranslated(context, StringConstant.clickHereToViewPDF)!,style: TextStyle(fontSize: 20,color: AppColors.blue),)
      // )
      // Padding(
      //   padding: EdgeInsets.all(10),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(getTranslated(context, StringConstant.jobAlerts)!, style: CustomTextStyle.headingMediumBold(context)),
      //         Expanded(child: SingleChildScrollView(
      //             child: Column(
      //               children: [
      //                 Html(data:utf8.decode(base64.decode(jobAlertsData!.description.toString())),
      //                 ),
      //                 jobAlertsData!.pdfPath==null? SizedBox():InkWell(
      //                     onTap: (){
      //                       Navigator.push(context, MaterialPageRoute(builder: (_) =>
      //                           ViewPdf(AppConstants.BANNER_BASE + jobAlertsData!.pdfPath.toString(),'')
      //                       ));
      //                     },
      //                     child: Text(getTranslated(context, StringConstant.clickHereToViewPDF)!,style: TextStyle(fontSize: 20,color: AppColors.blue),)
      //                 )
      //               ],
      //             )
      //         ),
      //
      //         ),
      //
      //       ]
      //     )
      // )
    );
  }
}
