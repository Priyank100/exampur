import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/mypurchase_innvoice.dart';
import 'package:exampur_mobile/provider/mypurchaseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';


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
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
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
      body:isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)): SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(getTranslated(context, LangString.inVoice)!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 8,),
              mypurchaseInnvoice!.transactionId !=null ? ColumnText(text:mypurchaseInnvoice!.transactionId.toString() ,
              title: getTranslated(context, LangString.TranscationId,)) : SizedBox(),
              SizedBox(height: 10,),
              ColumnText(text: mypurchaseInnvoice!.orderNo.toString(),
                  title: getTranslated(context, LangString.BillNumber,)),
              SizedBox(height: 10,),
              ColumnText(text: userName.toString(),
                  title: getTranslated(context, LangString.StudentName,)),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.product!.title != null ?   ColumnText(text: mypurchaseInnvoice!.product!.title.toString(),
                  title: getTranslated(context, LangString.itemType,)):SizedBox(),
              SizedBox(height: 10,),
              ColumnText(text: mypurchaseInnvoice!.product!.type.toString(),
                  title: getTranslated(context, LangString.Course,)),
              SizedBox(height: 10,),
              ColumnText(text:'₹ '+ mypurchaseInnvoice!.finalAmount.toString(),
                  title: getTranslated(context, LangString.Pricegst,)),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.emiPlans == null ? SizedBox():
              ColumnText(text: mypurchaseInnvoice!.emiPlans!.title.toString(),
                title: 'Emi Plan',),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.emiPaidTill == null ? SizedBox():
              ColumnText(text: mypurchaseInnvoice!.emiPaidTill.toString(),
                title: 'Emi Paid Till',),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.emiTotalAmount == null ? SizedBox():
              ColumnText(text:'₹ '+ mypurchaseInnvoice!.emiTotalAmount.toString(),
                title: 'Emi Total Amount',),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.pendingEmiAmount == null ? SizedBox():
              ColumnText(text:'₹ '+ mypurchaseInnvoice!.pendingEmiAmount.toString(),
                title: 'Pending Emi Amount',),
              SizedBox(height: 10,),
              mypurchaseInnvoice!.totalInstallmentPending == null ? SizedBox():
              ColumnText(text: mypurchaseInnvoice!.totalInstallmentPending.toString(),
                title: 'Total Installment Pending',),
            ],),
        ),
      ),
bottomSheet: Container(
  height: 70,
  child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(LangString.LearningClosetPvt,style: TextStyle(color: Colors.black.withOpacity(0.7))),
        Text(LangString.TermsandConditions,style: TextStyle(color: AppColors.grey)),
        Text(LangString.ThisitemnonRefundable,style: TextStyle(color: AppColors.grey))
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

