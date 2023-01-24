import 'package:exampur_mobile/data/model/job_notification_detail_model.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobNotificationDetails extends StatefulWidget {
  final String articleId;
  const JobNotificationDetails(this.articleId) : super();

  @override
  State<JobNotificationDetails> createState() => _JobNotificationDetailsState();
}

class _JobNotificationDetailsState extends State<JobNotificationDetails> {
  JobNotificationDetailModel? jobNotificationDetailModel;
  bool isLoading = true;
  String description = '';

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async {
    isLoading = true;
    jobNotificationDetailModel = (await Provider.of<JobAlertsProvider>(context, listen: false).getJobNotificationDetail(context, widget.articleId))!;
    for(int i=0; i<jobNotificationDetailModel!.contentModule!.length; i++) {
      description = description + jobNotificationDetailModel!.contentModule![i].description.toString();
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        jobNotificationDetailModel == null ? AppConstants.noDataFound() :
        SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobNotificationDetailModel!.title.toString(), style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 5),
                Html(
                  // data: jobNotificationDetailModel!.contentModule![0].description.toString(),
                    data: description,
                    onLinkTap: (url,_,__,___) async {
                      if(await canLaunch(url!)) {
                        await launch(url);

                      } else {
                        throw 'Error url> $url';
                      }
                    },
                    customRender: {
                      "table": (context, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                          (context.tree as TableLayoutElement).toWidget(context),
                        );
                      },
                    },
                    style: {
                      'body': Style(
                          lineHeight:LineHeight(2),
                          fontSize: const FontSize(15),
                          fontFamily: 'Noto Sans'
                      ),
                      'table':Style(
                        border: Border.all(width: 1),
                      ),
                      "tr": Style(
                          border: Border.all(width: 1)
                      ),
                      "th": Style(
                        // padding: EdgeInsets.all(6),
                        backgroundColor: AppColors.grey,
                      ),
                      "td": Style(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        width: 200,
                      ),
                    }),
              ]),
        ),
      ),

    );
  }
}
