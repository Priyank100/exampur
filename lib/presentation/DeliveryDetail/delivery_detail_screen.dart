import 'dart:convert';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/payment_screen.dart';
import 'package:exampur_mobile/presentation/PaymentRecieptpage/Receiptpage.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/order_details.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/provider/OrderDetailsProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final Courses paidcourseList;
  const DeliveryDetailScreen(this.paidcourseList) ;

  @override
  _DeliveryDetailScreenState createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  String State='';
  bool isLoading = false;

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPrefConstants.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    City = jsonValue[0]['data']['city'].toString();
    State = jsonValue[0]['data']['state'].toString();

    _billingCityController.text = City;
    _billingStateController.text = State;

    setState(() {
    });
  }

  @override
  void initState()  {
    super.initState();
    getSharedPrefData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       // resizeToAvoidBottomInset: false,
       // resizeToAvoidBottomPadding: false,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              getTranslated(context, 'provide_further_detalis_for_delivery_of_books')!,
              maxLines: 2,softWrap: true,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, 'address'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_address')!,
              textInputType: TextInputType.text,
              controller: _billingAddressController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, 'city'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_city')!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              controller: _billingCityController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, 'state'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_state')!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              controller: _billingStateController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, 'pin_code'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_pin_code')!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.number,
                controller:_billingPincodeController,
              value: (value) {},
            ),
            SizedBox(height: 15,),
            Row(children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextField(
                      //controller: _controller,
                      decoration: InputDecoration(
                    hintText: 'Have a coupon?',

                    //hintStyle: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    border: InputBorder.none,
                  )),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
             ElevatedButton(
                onPressed: () {
                  // if(_controller.text.isNotEmpty) {
                  //   Provider.of<CouponProvider>(context, listen: false).initCoupon(_controller.text, _order).then((value) {
                  //     if(value > 0) {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                  //       Text('You got ${PriceConverter.convertPrice(context, value)} discount'), backgroundColor: Colors.green));
                  //     }else {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         content: Text(getTranslated('invalid_coupon_or', context)),
                  //         backgroundColor: Colors.red,
                  //       ));
                  //     }
                  //   });
                  // }
                },

                style: ElevatedButton.styleFrom(
                  primary: AppConstants.Dark,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('APPLY',),

              )
                 // : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
            ]),


            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                String _address = _billingAddressController.text.trim();
                String _city = _billingCityController.text.trim();
                String _pincode = _billingPincodeController.text.trim();
                String _state = _billingStateController.text.trim();
                if(checkValidation(_address, _state, _city, _pincode)) {
                  saveDeliveryAddress(_address, _pincode, _city, _state);
                }
              },

              child: Container(
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: Colors.amber),

                child: Center(
                    child: Text(
                  getTranslated(context, 'continue_to_buy_course')!,
                  style: TextStyle(color: Colors.white,fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveDeliveryAddress(_address, _pincode, _city,_state) async {
    AppConstants.showLoaderDialog(context);
    final  body= {
      "course_id": widget.paidcourseList.id.toString(),
      "billing_address":_address,
      "billing_city":  _city,
      "billing_state": _state,
      "billing_country": "India",
      "billing_pincode":  _pincode
    };

    await Service.post(API.order_course, body: body).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());

      if (response == null) {
        AppConstants.showBottomMessage(context, 'Server Error', Colors.red);

      } else if (response.statusCode == 200) {
        AppConstants.printLog('anchal');
        AppConstants.printLog(response.body.toString());
        Delivery_model deliveryModel = Delivery_model.fromJson(json.decode(response.body.toString()));
        AppConstants.printLog('status>> ' + deliveryModel.data!.status.toString());
        String status = deliveryModel.data!.status.toString();

        if(status == "Pending"){
          BillingModel billingModel = BillingModel(
              Name, Email, Mobile, _address, _city, _state, AppConstants.defaultCountry, _pincode,
              widget.paidcourseList.title.toString(), widget.paidcourseList.amount.toString()
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentScreen(billingModel, deliveryModel)
              )
          );

        } else{
          AppConstants.printLog('yes');
          Navigator.push(context, MaterialPageRoute(builder:
              (context) =>
              PaymentReceiptPage(deliveryModel.data!.orderId.toString(),
                  deliveryModel.data!.paymentOrderId.toString(),
                  'signature')
          ));
        }
      } else {
        final body = json.decode(response.body);
        AppConstants.showAlertDialog(context, body['data'].toString());
        return;
      }
    });
  }

  bool checkValidation(_aadress, _state, _city,_pincode) {
    if (_aadress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ADDRESS_FIELD_MUST_BE_REQUIRED'), backgroundColor: Colors.black));
      return false;
    }
    else if (_state.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('STATE_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }
    else if (_city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CITY_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }else if (_pincode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PinCode_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }
    else {
      return true;
    }
  }


}

class TextUse extends StatelessWidget {
  final IconData? image;
  final String? title;

  TextUse({
    this.image,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          image,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title!,
          style: TextStyle(),
        ),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
