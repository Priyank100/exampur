import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/presentation/PaymentRecieptpage/Receiptpage.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String type;
  final BillingModel billingModel;
  final Delivery_model deliveryModel;
  const PaymentScreen(this.type, this.billingModel, this.deliveryModel) : super();

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textUse(getTranslated(context, StringConstant.billingaddress)!+' : ', 25),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.name)!+' : ' + widget.billingModel.name.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.phoneNumber)!+' : ' + widget.billingModel.mobile.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.email)!+' : ' + widget.billingModel.eMail.toString(), 15),
              widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ?SizedBox(): SizedBox(height: 10),
              widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ?SizedBox():  textUse(getTranslated(context, StringConstant.address)!+' : ' + widget.billingModel.address.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.city)!+' : ' + widget.billingModel.city.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.state)!+' : ' + widget.billingModel.state.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.country)!+' : ' + widget.billingModel.country.toString(), 15),
              SizedBox(height: 10),
              widget.type == 'Course' || widget.type == 'Combo' || widget.type == 'TestSeries' ?SizedBox(): textUse(getTranslated(context, StringConstant.pinCode)!+' : ' + widget.billingModel.pincode.toString(), 15),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              widget.type == 'Course' || widget.type == 'Combo' ?
              textUse(getTranslated(context, StringConstant.coursename)!+' : ' + widget.billingModel.itemName.toString(), 15) :
              widget.type == 'TestSeries' ?
              textUse('TestSeries Name'+' : ' + widget.billingModel.itemName.toString(), 15) :
              textUse(getTranslated(context, StringConstant.book_name)! + ' : ' + widget.billingModel.itemName.toString(), 15),
              SizedBox(height: 10),
              textUse(getTranslated(context, StringConstant.TotalAmount)!+' : ' + widget.billingModel.itemAmount.toString(), 15),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  openCheckout();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.maxFinite,
                  color: Colors.amber,
                  child: Text(getTranslated(context, StringConstant.paynow)!, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                )
              )
            ],
          ),
        )
    );
  }

  Widget textUse(String txt, double size) {
    return Text(txt, style: TextStyle(fontSize: size),);
  }


  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {

    var options = {
      "key": Keys.Rozar_pay_key,
      "amount": num.parse(widget.billingModel.itemAmount.toString()) * 100,
      "name": "Exampur",
      "description": widget.deliveryModel.data!.description.toString(),
      "order_id":  widget.deliveryModel.data!.paymentOrderId.toString(),
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
      "prefill": {"contact":  widget.billingModel.mobile.toString(),
        "email": widget.billingModel.eMail.toString()},
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

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentReceiptPage(widget.type, widget.deliveryModel.data!.orderId.toString(),
                response.paymentId.toString(),
                response.signature.toString())
        )
    );
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    String msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }


}
