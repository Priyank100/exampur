import 'dart:convert';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/data/model/promo_code.dart';
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
  bool isCouponValid = false;

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();
  final TextEditingController _cuponCodeController = TextEditingController();

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
              getTranslated(context, StringConstant.provideFurtherDetailsForDeliveryOfCourses)!,
              maxLines: 2,softWrap: true,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, StringConstant.address),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, StringConstant.enterAddress)!,
              textInputType: TextInputType.text,
              controller: _billingAddressController,
              value: (value) {},
            ),
            SizedBox(
              height: 15,
            ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, StringConstant.city),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, StringConstant.enterCity)!,
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
              title: getTranslated(context, StringConstant.state),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, StringConstant.enterState)!,
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
              title: getTranslated(context, StringConstant.pinCode),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, StringConstant.enterPinCode)!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.number,
                controller:_billingPincodeController,
              value: (value) {},
            ),
            SizedBox(height: 25,),

            Row(children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 50,
                  child: Container(
                    width: 70,
                    height: 45,
                    padding: EdgeInsets.only(left: 8,top: 4),
                    decoration: BoxDecoration(
                      color: AppColors.grey300,

                      borderRadius:  BorderRadius.all(const Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
                      ],
                    ),
                    child: TextField(
                      maxLines: 1,
                      cursorColor:AppColors.amber ,
                      controller: _cuponCodeController,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (value) {
                        isCouponValid = false;
                        if (_cuponCodeController.text != value.toUpperCase())
                          _cuponCodeController.value = _cuponCodeController.value.copyWith(text: value.toUpperCase());
                      },
                      autofocus:true,
                      decoration: new InputDecoration(
                          hintText: getTranslated(context, StringConstant.applyCoupon),
                          hintStyle: TextStyle(color: AppColors.grey500),
                          isDense: true,
                          fillColor: AppColors.grey.withOpacity(0.1),border: InputBorder.none
                      ),
                    ),

                    //hintStyle: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
                ),
              ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(

                child: InkWell(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    String cuponCode = _cuponCodeController.text.toUpperCase();
                    String amount = widget.paidcourseList.amount.toString();

                   if(chechCoupon(cuponCode)){
                     couponApi(cuponCode,amount);
                   }

                  },
                  child: Container(
                    decoration: BoxDecoration(color: AppColors.amber,
                      borderRadius:  BorderRadius.all(const Radius.circular(12)),
                    ),
                    height: 45,child: Center(child: Text(getTranslated(context, StringConstant.apply)!,style: TextStyle(color: AppColors.white),)),
                  ),
                ),
              )
            ]),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: (){
                FocusScope.of(context).unfocus();
                String _address = _billingAddressController.text.trim();
                String _city = _billingCityController.text.trim();
                String _pincode = _billingPincodeController.text.trim();
                String _state = _billingStateController.text.trim();
                String _promocode = _cuponCodeController.text.trim();
                if(checkValidation(_address, _state, _city, _pincode,_promocode)) {
                  saveDeliveryAddress(_address, _pincode, _city, _state);
                }
              },

              child: Container(
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: AppColors.amber),

                child: Center(
                    child: Text(
                      getTranslated(context, StringConstant.continueToBuyCourse)!,
                      style: TextStyle(color: AppColors.white,fontSize: 18),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  couponApi(promoCode, amount) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    String url = API.CouponCode_URL + promoCode + '/' + amount;
    AppConstants.printLog(url);

    await Service.get(url).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());

      if(response != null && response.statusCode == 200) {
        var jsonObject =  jsonDecode(response.body);

        if(jsonObject['statusCode'].toString() == '200') {
          AppConstants.printLog('anchal'+ jsonObject['data']['promo_code']);
          isCouponValid = true;
        } else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          isCouponValid = false;
        }

      } else {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
        isCouponValid = false;
      }
    });
  }



  saveDeliveryAddress(_address, _pincode, _city,_state) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    final  body= {
      "course_id": widget.paidcourseList.id.toString(),
      //"promo_code":
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
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);

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

  bool checkValidation(_address, _state, _city,_pincode,_promocode) {
    if (_address.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.address_REQUIRED)!, Colors.black);
      return false;
    }
    else if (_state.isEmpty) {
      AppConstants.showBottomMessage(context,  getTranslated(context, StringConstant.state_REQUIRED)!, Colors.black);
      return false;
    }
    else if (_city.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.CITY_REQUIRED)!, Colors.black);
      return false;
    }else if (_pincode.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.pincode_REQUIRED)!, Colors.black);
      return false;
    } else if(_promocode.toString().isNotEmpty && !isCouponValid) {
      AppConstants.showBottomMessage(context,getTranslated(context, StringConstant.applyCoupon)!, Colors.black);
      return false;
    }
    else {
      return true;
    }
  }

  bool chechCoupon(_promocode){
    if (_promocode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, StringConstant.PromoCode_REQUIRED)!), backgroundColor:AppColors.black));
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
          style: TextStyle(color: AppColors.red),
        )
      ],
    );
  }
}
