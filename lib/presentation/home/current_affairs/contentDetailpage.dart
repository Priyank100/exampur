import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/view_pdf.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ContentDetailPage extends StatefulWidget {
  final Data contentlist;
  final String type;
  const ContentDetailPage(this.contentlist,this.type);

  @override
  _ContentDetailPageState createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:  Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.type.toString(), style: CustomTextStyle.headingMediumBold(context)),
                Expanded(child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Html(data:utf8.decode(base64.decode(widget.contentlist.description.toString()))),

widget.contentlist.type=='PDF'?widget.contentlist.targetLink==null||widget.contentlist.targetLink=='null'?SizedBox():
                            InkWell(
                              onTap: (){

                                Navigator.push(context, MaterialPageRoute(builder: (_) =>
                                    ViewPdf(AppConstants.BANNER_BASE + widget.contentlist.targetLink.toString(),'')
                                ));
                              },
                                child: Text(getTranslated(context, StringConstant.clickHereToViewPDF)!,style: TextStyle(fontSize: 20,color: AppColors.blue),)
                            )
                          //  Container(height: 3,color: AppColors.blue,margin:EdgeInsets.only(left: 15,right: 15) ,)
                          :SizedBox()

                      ],
                    ),

                )
                )
              ]
          )
      ),
    );
  }
}
