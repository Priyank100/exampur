import 'dart:convert';

import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/final_order_pay_model.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentReceiptPage extends StatefulWidget {
  final String orderId;
  final String paymentId;
  final String signature;

  const PaymentReceiptPage(this.orderId, this.paymentId, this.signature);

  @override
  _PaymentReceiptPageState createState() => _PaymentReceiptPageState();
}

class _PaymentReceiptPageState extends State<PaymentReceiptPage> {
  FinalOrderPayModel model = FinalOrderPayModel();
  bool isLoad = true;

  @override
  void initState() {
    getReceipt();
  }

  void getReceipt() async {
    final param = {
      "order_id": widget.orderId,
      "transaction_id": widget.paymentId,
      "payment_signature": widget.signature,
    };

    await Service.post(API.finalize_order, body: param).then((response) {
      AppConstants.printLog(response.body.toString());

      if (response == null) {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);
      } else if (response.statusCode == 200) {
        model =
            FinalOrderPayModel.fromJson(json.decode(response.body.toString()));
        setState(() {
          isLoad = false;
        });
      } else {
        final body = json.decode(response.body);
        AppConstants.showAlertDialog(context, body['data'].toString());
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()));
            },
            child: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Image.asset(
          Images.exampur_title,
          width: Dimensions.ICON_SIZE_Title,
          height: Dimensions.ICON_SIZE_Title,
        ),
      ),
      body: isLoad
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Transaction Receipt ',
                    style: TextStyle(fontSize: 23),
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        Images.done,
                        height: 70,
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Thank You ',
                        style: TextStyle(fontSize: 30, color: Colors.green),
                      )),
                  SizedBox(
                    height: 38,
                  ),
                  Container(
                      padding: EdgeInsets.all(14),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        border: Border.all(
                            color: Colors.grey, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: Column(
                        children: [
                          TextUse(
                            title: 'Course  :',
                            text: 'course title',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextUse(
                            title: 'Order Date :',
                            text: 'date',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextUse(
                            title: 'Transcation Id  :',
                            text: model.data!.paymentTransactionId.toString(),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextUse(
                            title: 'Payment Mode:',
                            text: 'RazorPay',
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(model.data!.finalAmount.toString(),
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16)),
                            ],
                          ),
                          // Expanded(
                          //   flex: 1,
                          //     child: ListTile(
                          //   leading: Text('View invoice'),
                          //   trailing: Icon(Icons.arrow_forward_ios_sharp,size: 20,),
                          // ))
                        ],
                      )),
                ],
              ),
            ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BottomNavigation()));
        },
        child: Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              //borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              // boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300], blurRadius: 15, spreadRadius: 1)],
            ),
            child: Center(
                child: Text(
              'Back to home page',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ))),
      ),
    );
  }
}

class TextUse extends StatelessWidget {
  final String? text;
  final String? title;

  TextUse({
    this.text,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!,
          style: TextStyle(),
        ),
        Text(
          text!,
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
