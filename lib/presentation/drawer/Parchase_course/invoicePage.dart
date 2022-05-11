import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/mypurchase_innvoice.dart';
import 'package:exampur_mobile/provider/mypurchaseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class InvoiceDetailPage extends StatefulWidget {
  String mypurchaseIDData;
  String mypurchasetypeData;
  InvoiceDetailPage(this.mypurchaseIDData,this.mypurchasetypeData) ;

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  String userName = '';
  InvoiceData? mypurchaseInnvoice;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getDemoList();
  }

  Future<void> getDemoList() async {
    isLoading=true;
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    String token = jsonValue[0]['data']['authToken'].toString();
    userName = jsonValue[0]['data']['first_name'].toString();
    mypurchaseInnvoice= (await Provider.of<MyPurchaseProvider>(context, listen: false).getMyInvoice(context,token, widget.mypurchaseIDData, widget.mypurchasetypeData))!;
    isLoading=false;
    setState(() {});
    // return one2oneList;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)): Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Invoice',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            mypurchaseInnvoice!.transactionId !=null ? ColumnText(text:mypurchaseInnvoice!.transactionId.toString() ,
            title: getTranslated(context, StringConstant.TranscationId,)) : SizedBox(),
            SizedBox(height: 8,),
            ColumnText(text: mypurchaseInnvoice!.orderNo.toString(),
                title: getTranslated(context, StringConstant.BillNumber,)),
            SizedBox(height: 8,),
            ColumnText(text: userName.toString(),
                title: getTranslated(context, StringConstant.StudentName,)),
            SizedBox(height: 8,),
            mypurchaseInnvoice!.product!.title != null ?   ColumnText(text: mypurchaseInnvoice!.product!.title.toString(),
                title: getTranslated(context, StringConstant.itemType,)):SizedBox(),
            SizedBox(height: 8,),
            ColumnText(text: mypurchaseInnvoice!.product!.type.toString(),
                title: getTranslated(context, StringConstant.Course,)),
            SizedBox(height: 8,),
            ColumnText(text:'₹ '+ mypurchaseInnvoice!.finalAmount.toString(),
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

