import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class InvoiceDetailPage extends StatefulWidget {
  const InvoiceDetailPage({Key? key}) : super(key: key);

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Invoice',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            ColumnText(text: 'admin',
            title: getTranslated(context, StringConstant.TranscationId,)),
            SizedBox(height: 5,),
            ColumnText(text: 'admin',
                title: getTranslated(context, StringConstant.BillNumber,)),
            SizedBox(height: 5,),
            ColumnText(text: 'admin',
                title: getTranslated(context, StringConstant.StudentName,)),
            SizedBox(height: 5,),
            ColumnText(text: 'admin',
                title: getTranslated(context, StringConstant.itemType,)),
            SizedBox(height: 5,),
            ColumnText(text: 'admin',
                title: getTranslated(context, StringConstant.Course,)),
            SizedBox(height: 5,),
            ColumnText(text: 'admin',
                title: getTranslated(context, StringConstant.Pricegst,)),

        ],),
      ),
bottomSheet: Container(
  height: 70,
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(StringConstant.LearningClosetPvt,style: TextStyle(color: Colors.black.withOpacity(0.7))),
        Text(StringConstant.TermsandConditions,style: TextStyle(color: AppColors.grey)),
        Text(StringConstant.ThisitemnonRefundable,style: TextStyle(color: AppColors.grey))
      ],
    ),
  ),
),

    );
  }
}
class ColumnText extends StatelessWidget {
  final String? text;
  final String? title;

  ColumnText({
    this.text,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        ),
        SizedBox(height: 5,),
        Text(
          text!,
          style: TextStyle(fontSize: 17,color: AppColors.black),
        )
      ],
    );
  }
}

