import 'dart:convert';

import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/data/model/final_order_pay_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final BillingModel billingModel;
  final Delivery_model deliveryModel;
  const PaymentScreen(this.billingModel, this.deliveryModel) : super();

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay razorpay;

  @override
  void initState()  {
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
              textUse('Billing Address : ', 25),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              textUse('Name : ' + widget.billingModel.name.toString(), 15),
              SizedBox(height: 10),
              textUse('Mobile : ' + widget.billingModel.mobile.toString(), 15),
              SizedBox(height: 10),
              textUse('E-Mail : ' + widget.billingModel.eMail.toString(), 15),
              SizedBox(height: 10),
              textUse('Address : ' + widget.billingModel.address.toString(), 15),
              SizedBox(height: 10),
              textUse('City : ' + widget.billingModel.city.toString(), 15),
              SizedBox(height: 10),
              textUse('State : ' + widget.billingModel.state.toString(), 15),
              SizedBox(height: 10),
              textUse('Country : ' + widget.billingModel.country.toString(), 15),
              SizedBox(height: 10),
              textUse('Pincode : ' + widget.billingModel.pincode.toString(), 15),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              textUse('Course Name : ' + widget.billingModel.itemName.toString(), 15),
              SizedBox(height: 10),
              textUse('Total Amount : ' + widget.billingModel.itemAmount.toString(), 15),
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
                  child: Text('Pay Now', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
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
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    AppConstants.printLog("Pament success");
    AppConstants.printLog(response.orderId);
    AppConstants.printLog(response.paymentId);
    AppConstants.printLog(response.signature);

    AppConstants.showLoaderDialog(context);
    getReceipt(widget.deliveryModel.data!.orderId.toString(), response.paymentId.toString(), response.signature.toString());
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    String msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }

  void getReceipt(orderId, paymentId, signature) async {
    final param = {
      "order_id": orderId,
      "transaction_id":paymentId,
      "payment_signature":  signature,
    };

    await Service.post(API.finalize_order, body: param).then((response) {
      Navigator.pop(context);
      AppConstants.printLog('Priyank>>');
      AppConstants.printLog(response.body.toString());

      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Server Error'),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } else if (response.statusCode == 200) {
        FinalOrderPayModel model = FinalOrderPayModel.fromJson(json.decode(response.body.toString()));
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PaymentReceiptPage(model)
        //     )
        // );

      } else {
        final body = json.decode(response.body);
        AppConstants.showAlertDialog(context, body['data'].toString());
        return;
      }
    });
  }
}
