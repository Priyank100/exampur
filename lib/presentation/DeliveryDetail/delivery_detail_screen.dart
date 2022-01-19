import 'dart:convert';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
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
  late Razorpay razorpay;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  var msg;
  bool isLoading = false;

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(AppConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    City = jsonValue[0]['data']['city'].toString();
    setState(() {
    });
  }

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingCountryController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();


  @override
  void initState()  {
    super.initState();

    getSharedPrefData();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
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
            //Flexible(child: Text('Provide Further Detalis for Delivery of Course',maxLines:2,style: TextStyle(fontSize: 25),)),
            SizedBox(
              height: 20,
            ),
            // TextUse(
            //   image: Icons.person,
            //   title: getTranslated(context, 'first_name'),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // CustomTextField(
            //   hintText: getTranslated(context, 'enter_first_name')!,
            //   //focusNode: _phoneNode,
            //   textInputType: TextInputType.text,
            //   //controller: _phoneController,
            //   value: (value) {},
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // TextUse(
            //   image: Icons.person,
            //   title: getTranslated(context, 'last_name')
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // CustomTextField(
            //   hintText: getTranslated(context, 'enter_your_last_name')!,
            //   //focusNode: _phoneNode,
            //   textInputType: TextInputType.text,
            //   //controller: _phoneController,
            //   value: (value) {},
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // TextUse(
            //   image: Icons.phone,
            //   title: getTranslated(context, 'phone_number'),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // CustomTextField(
            //   hintText: getTranslated(context, 'enter_phone_number')!,
            //   //focusNode: _phoneNode,
            //   textInputType: TextInputType.number,
            //   //controller: _phoneController,
            //   value: (value) {},
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // TextUse(
            //   image: Icons.phone,
            //   title: ' Alternate Phone Number',
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // CustomTextField(
            //   hintText: "Enter Alternate Phone Number",
            //   //focusNode: _phoneNode,
            //   textInputType: TextInputType.number,
            //   //controller: _phoneController,
            //   value: (value) {},
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            TextUse(
              image: Icons.location_city,
              title: getTranslated(context, 'address'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_address')!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              controller: _billingAddressController,
              value: (value) {},
            ),
            // SizedBox(
            //   height: 15,
            // ),
            // TextUse(
            //   image: Icons.location_city,
            //   title: 'Post',
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // CustomTextField(
            //   hintText: "Enter Post",
            //   //focusNode: _phoneNode,
            //   textInputType: TextInputType.text,
            //   //controller: _phoneController,
            //   value: (value) {},
            // ),

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
              title: getTranslated(context, 'landmark_teshil'),
            ),
            SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: getTranslated(context, 'enter_landmark')!,
              //focusNode: _phoneNode,
              textInputType: TextInputType.text,
              controller:_billingCountryController,
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
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: (){
                String _address = _billingAddressController.text.trim();
                String _city = _billingCityController.text.trim();
                String _pincode = _billingPincodeController.text.trim();
                String _state = _billingStateController.text.trim();
                UpdateChoosecategory(_address, _pincode, _city,_state);

      //           String _address = _billingAddressController.text.trim();
      // String _city = _billingCityController.text.trim();
      // String _pincode = _billingPincodeController.text.trim();
      // String _state = _billingStateController.text.trim();
      //
      // if(!checkValidation(_address, _pincode, _city)) {
      //   setState(() {
      //     isLoading = false;
      //   });
      // } else {
      //   setState(() {
      //     isLoading = true;
      //   });
      //   _orderAccount(_address, _pincode, _city,_state);
      // }
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
 // Future<OrderDetails?> createUser(String billingAddress, String billingCity,String billingpincode,String billingstate,String billingCountry) async{
   // final String apiUrl = "https://reqres.in/api/users";
  UpdateChoosecategory(_address, _pincode, _city,_state) async {
    final  body= {
      "course_id": widget.paidcourseList.id.toString(),
      "billing_address":_address,
      "billing_city":  _city,
      "billing_state": _state,
      "billing_country": "India",
      "billing_pincode":  _pincode
    };


print(body);
    await Service.post(
      AppConstants.order_course,
      body: body,
    ).then((response) async {
      print(response.body.toString());
      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: Text('Server Error'),backgroundColor: Colors.red,);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 200) {
        AppConstants.printLog('anchal');
        AppConstants.printLog(response.body.toString());
        final body = json.decode(response.body);
        final data= body['data']['status'];
        print(data);
        if(data == "Pending"){
          print('ok');
          openCheckout();
        }
        else{
          print('yes');
        }
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder:
        //         (context) =>
        //         BottomNavigation()
        //     )
        // );
      } else {

      }
    });
  }




  void openCheckout() {
    // call apis
    var options = {
      "key": AppConstants.Rozar_pay_key,
      "amount": widget.paidcourseList.amount.toString() ,// Convert Paisa to Rupees
      "name": "Exampur",
      "description": "This is a Test Payment",//from apis
      // "order_id":  widget.paidcourseList.id.toString(),      //fromapi
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
      "prefill": {"contact":  Mobile, "email": Email},

    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Pament success");
    msg = "SUCCESS: " + response.paymentId!;
    showToast(msg);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    showToast(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: " + response.walletName!;
    showToast(msg);
  }

  showToast(msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.2),
      textColor: Colors.black54,
    );
  }













    // if(response.statusCode == 200){
    //   final String responseString = response.body;
    //
    //   return userModelFromJson(responseString);
    // }else{
    //   return null;
    // }




  bool checkValidation(_aadress, _city,_pincode) {
    if (_aadress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Address_FIELD_MUST_BE_REQUIRED'), backgroundColor: Colors.black));
      return false;
    }
    // else if (_state.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sate_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
    //   return false;
    // }
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

  _orderAccount(_address, _pincode, _city,_state) async {

    // CreateUserModel updateUserInfoModel = Provider.of<AuthProvider>(context, listen: false).uerupdate;
    OrderDetails updateUserInfoModel = OrderDetails();
    updateUserInfoModel.courseId='61c98d223a7d50ce67803edb';
    updateUserInfoModel.billingAddress =_address;
    updateUserInfoModel.billingCity = _city;
    updateUserInfoModel.billingpincode = _pincode;
    updateUserInfoModel.billingstate = _state;
    updateUserInfoModel.billingCountry = 'India';


     await Provider.of<OrderDetailsprovider>(context, listen: false).orderdetails(updateUserInfoModel);
         //.then((response) {
  //     isLoading = false;
  //     if(response) {
  //       print(response.toString());
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(''), backgroundColor: Colors.green));
  //       //Navigator.pop(context);
  //     }else {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server error'), backgroundColor: Colors.red));
  //     }
  //     setState(() {});
  //   }
  //   );
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
