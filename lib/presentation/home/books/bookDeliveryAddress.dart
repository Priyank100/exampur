import 'dart:convert';

import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Localization/language_constrants.dart';
import '../../../SharePref/shared_pref.dart';
import '../../../data/model/state_json.dart';
import '../../../utils/analytics_constants.dart';
import '../../../utils/api.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/lang_string.dart';
import '../../DeliveryDetail/delivery_detail_screen.dart';
import '../../PaymentRecieptpage/Receiptpage.dart';
import '../../widgets/custom_text_field.dart';

class BookDeliveryAddress extends StatefulWidget {
   String? type;
   String? id;
   String? promocode;
   String? orderNo;
   String? orderId;
   String? paymentId;
   String? signature;
   String? bookTitle;
   BookDeliveryAddress(this.id,this.promocode,this.orderNo,this.orderId,this.paymentId,this.signature,this.bookTitle,{Key? key,this.type}) : super(key: key);

  @override
  State<BookDeliveryAddress> createState() => _BookDeliveryAddressState();
}

class _BookDeliveryAddressState extends State<BookDeliveryAddress> {
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  // String City='';
  // String State='';
  String LandMark='';
  String selectedState='';
  List<States> stateList = [];

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();
  final TextEditingController _cuponCodeController = TextEditingController();
  final TextEditingController _billinglandMarkController = TextEditingController();
  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/State.json');
  }

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    // City = jsonValue[0]['data']['city'].toString();
    // State = jsonValue[0]['data']['state'].toString();
    //
    // _billingCityController.text = City;
    // _billingStateController.text = State;

    setState(() {
    });
  }
  Future<bool> _onWillPop(BuildContext context) async {
    AppConstants.showAlertDialogWithYesBack(context, getTranslated(context, LangString.Are_you_Sure_you_want_to_back)!);
      return Future.value(true);
    }
  void getStateList() async {
    String jsonString = await loadJsonFromAssets();
    final StateResponse = stateJsonFromJson(jsonString);
    stateList = StateResponse.states!;
    selectedState = stateList[0].name.toString();
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    getStateList();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: CustomAppBar(),
        body:ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              getTranslated(context, LangString.provideFurtherDetailsForDeliveryOfBooks)!,
              maxLines: 2,softWrap: true, style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, LangString.address),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterAddress)!,
                textInputType: TextInputType.text,
                controller: _billingAddressController,
                value: (value) {},
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15.0),
            //   child: TextUse(
            //     image: Icons.location_city,
            //     title: getTranslated(context, LangString.landmarkTehsil),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15.0),
            //   child: CustomTextField(
            //     hintText: getTranslated(context, LangString.landmarkTehsil)!,
            //     textInputType: TextInputType.text,
            //     controller: _billinglandMarkController,
            //     value: (value) {},
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, LangString.city),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterCity)!,
               // focusNode: _phoneNode,
                textInputType: TextInputType.text,
                controller: _billingCityController,
                value: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, LangString.state),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15.0),
            //   child: CustomTextField(
            //     hintText: getTranslated(context, LangString.enterState)!,
            //     //focusNode: _phoneNode,
            //     textInputType: TextInputType.text,
            //     controller: _billingStateController,
            //     value: (value) {},
            //   ),
            // ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius:  BorderRadius.all(const Radius.circular(8)),
                boxShadow: [
                  BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1))
                ],
              ),

              padding: EdgeInsets.only(left: 10),

              child: DropdownButton(
                underline: SizedBox(),
                isExpanded: true,
                value: selectedState,
                items: stateList.map((value) {
                  return DropdownMenuItem(
                    value: value.name,
                    child: Text(value.name.toString()),
                  );
                }).toList(),
                onChanged: (selected) {
                  setState(() {
                    selectedState = selected.toString();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, LangString.pinCode),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterPinCode)!,
                //focusNode: _phoneNode,
                maxLength: 6,
                textInputType: TextInputType.number,
                controller:_billingPincodeController,
                value: (value) {},
              ),
            ),
            InkWell(
              onTap:  (){
                FocusScope.of(context).unfocus();
                String _address = _billingAddressController.text.trim();
                String _city = _billingCityController.text.trim();
                String _pincode = _billingPincodeController.text.trim();
                String _state = _billingStateController.text.trim();
                String _landmark = _billinglandMarkController.text.trim();
                String _promocode = _cuponCodeController.text.trim();
                var map = {
                  'Page_Name':'Delivery_Details',
                  'Mobile_Number':AppConstants.userMobile,
                  'Language':AppConstants.langCode,
                  'User_ID':AppConstants.userMobile,
                  'Book_Name':widget.bookTitle.toString()
                };
            AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Confirm_Purchase_Books,map);
                if(checkValidation(_address, _state, _city, _pincode,)) {
                  saveDeliveryAddress(true, _address, _pincode, _city, selectedState);
                }
      },

              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                margin:EdgeInsets.only(top: 30) ,
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: AppColors.amber),
                  child: Center(
                    child:
                    Text(
                getTranslated(context, LangString.submit)!,style: TextStyle(color: AppColors.white,fontSize: 16)),
                    )
                ),
              ),

          ],
        )
      ),
    );
  }
  bool checkValidation(_address, _state, _city,_pincode) {
    if (widget.type == 'Book' && _address.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.address_REQUIRED)!, AppColors.black);
      return false;
    }
    // else if (widget.type == 'Book' && _landmark.isEmpty) {
    //   AppConstants.showBottomMessage(context, getTranslated(context, LangString.landmarkTehsil)!, AppColors.black);
    //   return false;
    // }
    else if (widget.type == 'Book' && _city.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.CITY_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (selectedState=='Select States') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text( getTranslated(context,LangString.State_Required)!), backgroundColor:AppColors.black));
      return false;
    }
  else if (widget.type == 'Book' && _pincode.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.pincode_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _pincode.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter 6 Digit Pincode'),
        backgroundColor: AppColors.black,
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
      ));
      return false;
    }
  else {
      return true;
    }
  }
  saveDeliveryAddress(bool flag, _address, _pincode, _city,selectedState) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    final param;
    String url = '';
    param = {
    //  "book_id": widget.id.toString(),
  //    "promo_code": widget.promocode,
      "billing_address": _address,
      "billing_city":  _city,
      "billing_state": selectedState,
      "billing_country": AppConstants.defaultCountry,
    //  "billing_landmark":_landmark,
      "billing_pincode":  _pincode
    };
    url = API.new_update_address_book.replaceAll('ORDER_ID', widget.orderId.toString());
    await Service.patch(url, body: param).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
      if (jsonObject['statusCode'].toString() == '200') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentReceiptPage('Book',widget.orderId.toString(),widget.paymentId.toString(),widget.signature.toString(),widget.orderNo.toString(),false)
            ));
      } else {
        AppConstants.showBottomMessage(
            context, jsonObject['data'].toString(), AppColors.black);
      }
      }else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
        //isCouponValid = false;
      }
    });
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