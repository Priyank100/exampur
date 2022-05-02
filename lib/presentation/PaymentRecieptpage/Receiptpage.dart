import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/final_order_pay_model.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PaymentReceiptPage extends StatefulWidget {
  final String type;
  final String orderId;
  final String paymentId;
  final String signature;

  const PaymentReceiptPage(this.type, this.orderId, this.paymentId, this.signature);

  @override
  _PaymentReceiptPageState createState() => _PaymentReceiptPageState();
}

class _PaymentReceiptPageState extends State<PaymentReceiptPage> {
  FinalOrderPayModel model = FinalOrderPayModel();
  bool isLoad = true;
  String error = '';

  @override
  void initState() {
    getReceipt(true);
    //subscription();
  }

  void subscription(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    AppConstants.printLog('>>>>>>>>>>>>>>>>>>>>>>>>>>>>'+topic);
  }

  void getReceipt(flag) async {
    String url = '';
    final param = {
      "order_id": widget.orderId,
      "transaction_id": widget.paymentId,
      "payment_signature": widget.signature,
    };

    if(flag) {
      if(widget.type == 'Course')
        url = API.finalize_order_course;
      else if(widget.type == 'Combo')
        url = API.finalize_order_combo_course;
      else if(widget.type == 'TestSeries')
        url = API.finalize_order_test_series;
      else
        url = API.finalize_order_book;

    } else {
      if(widget.type == 'Course')
        url = API.finalize_order_course_2;
      else if(widget.type == 'Combo')
        url = API.finalize_order_combo_course_2;
      else if(widget.type == 'TestSeries')
        url = API.finalize_order_test_series_2;
      else
        url = API.finalize_order_book_2;
    }

    await Service.post(url, body: param).then((response) {
      AppConstants.printLog(response.body.toString());

      if (response != null && response.statusCode == 200) {
        final body = json.decode(response.body);
        var statusCode = body['statusCode'].toString();
        if (statusCode == '200') {
          model = FinalOrderPayModel.fromJson(body);
          subscription(model.data!.product!.id.toString().replaceAll(' ', '_'));
        } else {
          error = body['data'].toString();
          AppConstants.showBottomMessage(context, error, AppColors.black);
        }
      } else if(response.statusCode == 429) {
        getReceipt(false);

      } else {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError)!, AppColors.red);
      }
      setState(() {
        isLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BottomNavigation()),
                  (Route<dynamic> route) => false);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  // Navigator.pushReplacement(context,
                  //     MaterialPageRoute(builder: (context) => BottomNavigation()));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BottomNavigation()),
                          (Route<dynamic> route) => false);
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
              ? Center(child: LoadingIndicator(context)) :
          model.data == null ? Center(child: Text(error)) :
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  getTranslated(context, StringConstant.TransactionReceipt)!,
                  style: TextStyle(fontSize: 23),
                ),
                SizedBox(
                  height: 29,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/DoneLottie.json',height: 70,)),
                SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      getTranslated(context, StringConstant.Thankyou)!  ,
                      style: TextStyle(fontSize: 30, color: AppColors.green),
                    )),
                SizedBox(
                  height: 38,
                ),
                Container(
                    padding: EdgeInsets.all(10),
                   // margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.1),
                      border: Border.all(
                          color: AppColors.grey, // set border color
                          width: 2.0), // set border width
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0)), // set rounded corner radius
                    ),
                    child: Column(
                      children: [
                        TextUse(
                          title: widget.type == 'Course' || widget.type == 'Combo' ?  getTranslated(context, StringConstant.coursename)! + ' :' :
                          widget.type == 'TestSeries' ?  'TestSeries Name' + ' :' :
                          getTranslated(context, StringConstant.books)! +':',
                          text: model.data!.product!.title.toString(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextUse(
                          title:  getTranslated(context, StringConstant.OrderDate)! +' :',
                          text: model.data!.date.toString(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextUse(
                          title: getTranslated(context, StringConstant.TranscationId)! + ' :',
                          text: model.data!.paymentTransactionId.toString(),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextUse(
                          title:  getTranslated(context, StringConstant.PaymentMode)! +' :',
                          text: 'RazorPay',
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              getTranslated(context, StringConstant.TotalAmount)!,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text('₹ '+model.data!.finalAmount.toString(),
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
                    )
                ),
              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          BottomNavigation()),
                      (Route<dynamic> route) => false);
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
                      getTranslated(context, StringConstant.BackToHomePage)!,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),
          ),
        )
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
        SizedBox(width: 5,),
        Flexible(
          child: Text(
            text!,
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
