import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/data/model/delivery_upsell_model.dart';
import 'package:exampur_mobile/presentation/PaymentRecieptpage/Receiptpage.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../utils/analytics_constants.dart';

class PaymentScreen extends StatefulWidget {
  final String type;
  final BillingModel billingModel;
  // final Delivery_model deliveryModel;
  final DeliveryUpsellModel deliveryUpsellModel;
  final String couponCode;
  final String emiPlan;
  const PaymentScreen(this.type, this.billingModel, this.deliveryUpsellModel, this.couponCode, this.emiPlan) : super();

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    var coursemap = {
      'Page_Name':'Check_Out_Course_Purchase',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.billingModel.itemName.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Price':widget.deliveryUpsellModel.data!.amount,
      'Total_Price':widget.deliveryUpsellModel.data!.amount,
      'Book':widget.deliveryUpsellModel.data!.bookSelected == true ? 'Yes':'No'
    };
    if(widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected!) {
      coursemap['Book_Price'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].salePrice;
      coursemap['Book_Name'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].title.toString();
    }

    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.billingModel.itemName.toString(),
      'Book_Price':widget.billingModel.itemAmount
    };
   widget.type == 'Book'?AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Check_Out_Page,bookmap):
   AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Check_Out_Page,coursemap);
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
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

                textUse(getTranslated(context, LangString.name)!, widget.billingModel.name.toString()),
                textUse(getTranslated(context, LangString.phoneNumber)!, widget.billingModel.mobile.toString()),
                textUse(getTranslated(context, LangString.email)!, widget.billingModel.eMail.toString()),
                widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ? SizedBox() :  textUse(getTranslated(context, LangString.address)!, widget.billingModel.address.toString()),
                widget.billingModel.city.toString().isEmpty ? SizedBox() : textUse(getTranslated(context, LangString.city)!, widget.billingModel.city.toString()),
                widget.billingModel.state.toString().isEmpty ? SizedBox() : textUse(getTranslated(context, LangString.state)!, widget.billingModel.state.toString()),
                widget.billingModel.country.toString().isEmpty ? SizedBox() : textUse(getTranslated(context, LangString.country)!, widget.billingModel.country.toString()),
                widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ? SizedBox(): textUse(getTranslated(context, LangString.pinCode)!, widget.billingModel.pincode.toString()),
                widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ?SizedBox(): textUse(getTranslated(context, LangString.landmarkTehsil)!, widget.billingModel.landmark.toString()),

                Divider(),

                widget.type == 'Course' || widget.type == 'Combo' ?
                textUse(getTranslated(context, LangString.coursename)!, widget.billingModel.itemName.toString()) :
                widget.type == 'TestSeries' ?
                textUse('TestSeries Name', widget.billingModel.itemName.toString()) :
                textUse(getTranslated(context, LangString.book_name)!, widget.billingModel.itemName.toString()),
                textUse(getTranslated(context, LangString.TotalAmount)!, widget.deliveryUpsellModel.data!.amount.toString()),

                widget.couponCode.isEmpty ? SizedBox() :Divider(),
                widget.couponCode.isEmpty ? SizedBox() : textUse('Coupon code apply', widget.couponCode),

                widget.emiPlan.isEmpty ? SizedBox() :Divider(),
                widget.emiPlan.isEmpty ? SizedBox() : textUse('Emi Plan', widget.emiPlan),

                widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected! ? Divider() : SizedBox(),
                widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected! ? textUse('Upsell Book', widget.deliveryUpsellModel.data!.upsellBookDetails![0].title.toString()) : SizedBox(),
                widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected! ? textUse('Amount', widget.deliveryUpsellModel.data!.upsellBookDetails![0].salePrice.toString()) : SizedBox(),

                Divider(),

                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {
                    var map = {
                      'Page_Name':'Check_Out_Course_Purchase',
                      'Course_Category':AppConstants.paidTabName,
                      'Course_Name':widget.billingModel.itemName.toString(),
                      'Mobile_Number':AppConstants.userMobile,
                      'Language':AppConstants.langCode,
                      'User_ID':AppConstants.userMobile,
                      'Course_Price':widget.deliveryUpsellModel.data!.amount,
                      'Total_Price':widget.deliveryUpsellModel.data!.amount,
                      'Book':widget.deliveryUpsellModel.data!.bookSelected == true ? 'Yes':'No'
                    };
                    if(widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected!) {
                      map['Book_Price'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].salePrice;
                      map['Book_Name'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].title.toString();
                    }
                    var bookmap ={
                      'Page_Name':'Check_Out_Books_Purchase',
                      'Mobile_Number':AppConstants.userMobile,
                      'Language':AppConstants.langCode,
                      'User_ID':AppConstants.userMobile,
                      'Book_Name':widget.billingModel.itemName.toString(),
                      'Book_Price':widget.billingModel.itemAmount
                    };
                   widget.type=='Book'?AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Pay_Now,bookmap): AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Pay_Now,map);
                    openCheckout();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.maxFinite,
                    color: Colors.amber,
                    child: Text(getTranslated(context, LangString.paynow)!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                  )
                )
              ],
            ),
          ),
        )
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

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {

    var options = {
      "key": Keys.Razar_pay_key,
      "amount": num.parse(widget.billingModel.itemAmount.toString()) * 100,
      "name": "Exampur",
      "description": widget.deliveryUpsellModel.data!.description.toString(),
      "order_id":  widget.deliveryUpsellModel.data!.paymentOrderId.toString(),
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
      "prefill": {"contact":  widget.billingModel.mobile.toString(), "email": widget.billingModel.eMail.toString()},
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

    var map = {
      'Page_Name':'Check_Out_Course_Purchase',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.billingModel.itemName.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Course_Price':widget.deliveryUpsellModel.data!.amount,
      'Total_Price':widget.deliveryUpsellModel.data!.amount,
      'Book':widget.deliveryUpsellModel.data!.bookSelected == true ? 'Yes':'No',
      'Payment_Type':'RazorPay'
    };
    if(widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected!) {
      map['Book_Price'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].salePrice;
      map['Book_Name'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].title.toString();
    }
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.billingModel.itemName.toString(),
      'Book_Price':widget.billingModel.itemAmount
    };
  widget.type == 'Book'?AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Successful,bookmap):  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Successful,map);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentReceiptPage(
                widget.type,
                widget.deliveryUpsellModel.data!.orderId.toString(),
                response.paymentId.toString(),
                response.signature.toString(),
                widget.deliveryUpsellModel.data!.orderNo.toString(),
                widget.deliveryUpsellModel.data!.bookSelected??false
            )
        )
    );
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    String msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    AppConstants.showBottomMessage(context, msg, Colors.red);
    var map = {
      'Page_Name':'Check_Out_Course_Purchase',
      'Course_Category':AppConstants.paidTabName,
      'Course_Name':widget.billingModel.itemName.toString(),
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
     'Course_Price':widget.deliveryUpsellModel.data!.amount,
      'Total_Price':widget.deliveryUpsellModel.data!.amount,
      'Book':widget.deliveryUpsellModel.data!.bookSelected == true ? 'Yes':'No',
      'Payment_Type':'RazorPay'
    };
    if(widget.deliveryUpsellModel.data!.bookSelected!=null && widget.deliveryUpsellModel.data!.bookSelected!) {
      map['Book_Price'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].salePrice;
      map['Book_Name'] = widget.deliveryUpsellModel.data!.upsellBookDetails![0].title.toString();
    }
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name':widget.billingModel.itemName.toString(),
      'Book_Price':widget.billingModel.itemAmount
    };
    widget.type == 'Book'?AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Failed,bookmap):
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Failed,map);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }


}
