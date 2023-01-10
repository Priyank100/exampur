import 'dart:convert';

import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Localization/language_constrants.dart';
import '../../../SharePref/shared_pref.dart';
import '../../../data/model/delivery_upsell_model.dart';
import '../../../utils/analytics_constants.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/lang_string.dart';
import '../../PaymentRecieptpage/Receiptpage.dart';
import 'bookDeliveryAddress.dart';

class BookPaymentSceen extends StatefulWidget {
  String id;
  String bookName;
 // String amount;
  final String couponCode;
  final DeliveryUpsellModel deliveryUpsellModel;
 final String? finalAmount;
   BookPaymentSceen(this.id,this.bookName,this.couponCode,this.deliveryUpsellModel,{Key? key,this.finalAmount}) : super(key: key);

  @override
  State<BookPaymentSceen> createState() => _BookPaymentSceenState();
}

class _BookPaymentSceenState extends State<BookPaymentSceen> {
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  String State='';
  late Razorpay razorpay;
  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    City = jsonValue[0]['data']['city'].toString();
    State = jsonValue[0]['data']['state'].toString();
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.bookName,
      'Book_Price':widget.deliveryUpsellModel.data!.amount.toString()
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Check_Out_Page,bookmap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
      child: Padding(
      padding: EdgeInsets.all(20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(getTranslated(context, LangString.billingaddress)!,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      Divider(),
      textUse(getTranslated(context, LangString.name)!, userName.toString()),
      textUse(getTranslated(context, LangString.phoneNumber)!, Mobile.toString()),
      textUse(getTranslated(context, LangString.email)!, Email.toString()),
      textUse(getTranslated(context, LangString.country)!, AppConstants.defaultCountry),
      Divider(),
      textUse(getTranslated(context, LangString.book_name)!, widget.bookName),
      textUse(getTranslated(context, LangString.TotalAmount)!,AppConstants.customRound(double.parse(widget.deliveryUpsellModel.data!.amount.toString()))),
      widget.couponCode.isEmpty ? SizedBox() :Divider(),
      widget.couponCode.isEmpty ? SizedBox() : textUse('Coupon code apply', widget.couponCode),
      Divider(),
      SizedBox(height: 20),
      MaterialButton(
          onPressed: () {

            var bookmap ={
              'Page_Name':'Check_Out_Books_Purchase',
              'Mobile_Number':AppConstants.userMobile,
              'Language':AppConstants.langCode,
              'User_ID':AppConstants.userMobile,
              'Book_Name':widget.bookName,
              'Book_Price':widget.deliveryUpsellModel.data!.amount.toString()
            };
            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Pay_Now,bookmap);
           openCheckout();

            //isko hatna hhh
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDeliveryAddress(widget.id.toString(),widget.couponCode,widget.deliveryUpsellModel.data!.orderNo.toString(),widget.deliveryUpsellModel.data!.orderId.toString(),'response.paymentId','response.signature',widget.bookName,type:'Book')
                ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            color: Colors.amber,
            child: Text(getTranslated(context, LangString.paynow)!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
          )
      )
    ]))),
    );
  }
  Widget textUse(String heading, String value) {
    return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: TextStyle(fontSize: 15)),
            Text(' : ', style: TextStyle(fontSize: 15)),
            Expanded(child: Text(value,style: TextStyle(fontSize: 14, color: AppColors.grey)))
          ],
        )
    );
  }
  void openCheckout() {

    var options = {
      "key": Keys.Razar_pay_key,
      "amount": num.parse(widget.deliveryUpsellModel.data!.amount.toString()) * 100,
      "name": "Exampur",
      "description": widget.deliveryUpsellModel.data!.description.toString(),
      "order_id":  widget.deliveryUpsellModel.data!.paymentOrderId.toString(),
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
      "prefill": {"contact":  Mobile.toString(), "email": Email.toString()},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      AppConstants.printLog(e.toString());
    }
  }
  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    AppConstants.printLog("Payment success");
    AppConstants.printLog(response.orderId);
    AppConstants.printLog(response.paymentId);
    AppConstants.printLog(response.signature);
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.bookName,
      'Book_Price':widget.deliveryUpsellModel.data!.amount.toString()
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Successful,bookmap);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
        builder: (context) => BookDeliveryAddress(widget.id.toString(),widget.couponCode,widget.deliveryUpsellModel.data!.orderNo.toString(),widget.deliveryUpsellModel.data!.orderId.toString(),response.paymentId,response.signature,widget.bookName,type:'Book')
    ));
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    String msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    AppConstants.showBottomMessage(context, msg, Colors.red);
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.bookName.toString(),
      'Book_Price':widget.deliveryUpsellModel.data!.amount.toString()
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Failed,bookmap);
   }

  void handlerExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }
  @override
  void dispose() {
    super.dispose();
    var backbutton= {
      'Page_Name':'Check_Out_Course_Purchase',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.bookName.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Price':widget.deliveryUpsellModel.data!.amount,
      'Total_Price':widget.deliveryUpsellModel.data!.amount,
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Payment_Page_Back_Button,backbutton);
    razorpay.clear();
  }
}
