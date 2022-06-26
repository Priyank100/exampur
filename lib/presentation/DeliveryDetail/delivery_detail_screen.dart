import 'dart:convert';
import 'package:exampur_mobile/data/model/billing_model.dart';
import 'package:exampur_mobile/data/model/delivery_model.dart';
import 'package:exampur_mobile/data/model/delivery_upsell_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model_new.dart';
import 'package:exampur_mobile/data/model/upsell_book.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/payment_screen.dart';
import 'package:exampur_mobile/presentation/PaymentRecieptpage/Receiptpage.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final String type;
  final String id;
  final String title;
  final String salePrice;
  final List<UpsellBook>? upsellBookList;
  final String? emiPlan;

  const DeliveryDetailScreen(this.type, this.id, this.title, this.salePrice, {this.upsellBookList, this.emiPlan}) ;

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
  String LandMark='';
  bool isCouponValid = false;

  bool isBookSelected = false;
  List<String> selectedBookIdList = [];

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();
  final TextEditingController _cuponCodeController = TextEditingController();
  final TextEditingController _billinglandMarkController = TextEditingController();

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
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.type == 'Course'|| widget.type=='Combo' ?
             Text(
              getTranslated(context, StringConstant.use_coupon)!,
              maxLines: 2, softWrap: true,
              style: TextStyle(fontSize: 25),
            ) : widget.type == 'TestSeries' ? Text('Test Series', style: TextStyle(fontSize: 25)) :
            Text(
              getTranslated(context, StringConstant.provideFurtherDetailsForDeliveryOfBooks)!,
              maxLines: 2,softWrap: true, style: TextStyle(fontSize: 25),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, StringConstant.address),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, StringConstant.enterAddress)!,
                textInputType: TextInputType.text,
                controller: _billingAddressController,
                value: (value) {},
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, StringConstant.landmarkTehsil),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, StringConstant.landmarkTehsil)!,
                textInputType: TextInputType.text,
                controller: _billinglandMarkController,
                value: (value) {},
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, StringConstant.city),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, StringConstant.enterCity)!,
                //focusNode: _phoneNode,
                textInputType: TextInputType.text,
                controller: _billingCityController,
                value: (value) {},
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, StringConstant.state),
              ),
            ),

            widget.type == 'Course'|| widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, StringConstant.enterState)!,
                //focusNode: _phoneNode,
                textInputType: TextInputType.text,
                controller: _billingStateController,
                value: (value) {},
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, StringConstant.pinCode),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, StringConstant.enterPinCode)!,
                //focusNode: _phoneNode,
                textInputType: TextInputType.number,
                  controller:_billingPincodeController,
                value: (value) {},
              ),
            ),

            SizedBox(height: 20),

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
                        setState(() {});
                        },
                     
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
                    // String id = widget.paidcourseList.id.toString();
                    String id = widget.id.toString();

                   if(checkCoupon(cuponCode)){
                     FirebaseAnalytics.instance.logEvent(name:'PROMOCODE_APPLIED_',parameters: {
                       'promocode':_cuponCodeController.text.toString().replaceAll(' ', '_'),
                     });
                     couponApi(API.CouponCode_URL, cuponCode,id);
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
            isCouponValid ? Text('Coupon applied successfully', style: TextStyle(color: AppColors.green, fontSize: 10),) : SizedBox(),
            widget.upsellBookList == null ? SizedBox() : widget.upsellBookList!.length > 0 ? showUpsellBookList() : SizedBox(),
            SizedBox(height: 30),
            InkWell(
              onTap: (){
                FocusScope.of(context).unfocus();
                String _address = _billingAddressController.text.trim();
                String _city = _billingCityController.text.trim();
                String _pincode = _billingPincodeController.text.trim();
                String _state = _billingStateController.text.trim();
                String _landmark = _billinglandMarkController.text.trim();
                String _promocode = _cuponCodeController.text.trim();
                if(checkValidation(_address, _state, _city, _pincode,_landmark,_promocode)) {
                  saveDeliveryAddress(true, _address, _pincode, _city, _state,_landmark, _promocode);
                }
              },

              child: Container(
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: AppColors.amber),

                child: Center(
                    child: widget.type == 'Course'||widget.type=='Combo' ?
                    Text(
                      getTranslated(context, StringConstant.continueToBuyCourse)!,
                      style: TextStyle(color: AppColors.white,fontSize: 18),
                    ) :  widget.type == 'TestSeries' ?
                    Text(
                      'Continue to Buy Test Series',
                      style: TextStyle(color: AppColors.white,fontSize: 18),
                    ) :
                    Text(getTranslated(context, StringConstant.continueToBuyBook)! ,
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

  couponApi(couponUrl, promoCode, id ) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    String url = '';
    widget.type == 'Course' ?
    url = couponUrl + promoCode + '/' +'Course' +'/'+id :
    widget.type == 'TestSeries' ?
    url = couponUrl + promoCode + '/' +'TestSeries' +'/'+id :
    url = couponUrl + promoCode + '/' +'Book' +'/'+id;
    AppConstants.printLog(url);

    await Service.get(url).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());

      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        if (jsonObject['statusCode'].toString() == '200') {
          AppConstants.printLog('anchal' + jsonObject['data']['promo_code']);
          AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.apply), AppColors.black);
          isCouponValid = true;
          setState(() {});
        } else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          isCouponValid = false;
          _cuponCodeController.text = '';
          setState(() {});
        }
      }else if(response.statusCode==429) {
        couponApi(API.CouponCode_URL_2, promoCode, id);

      } else {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
        isCouponValid = false;
        _cuponCodeController.text = '';
      }
    });
  }

  Widget showUpsellBookList() {
    return Column(
      children: [
        SizedBox(height: 20),
        Text('Recommend book with this course', style: TextStyle(fontSize: 18)),
        Text('Click on the check box to add this book', style: TextStyle(fontSize: 12)),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.upsellBookList!.length,
            itemBuilder: (context, index) {
            return upsellBookContainer(index);
          })
      ],
    );
  }

  Widget upsellBookContainer(i) {
    return Row(
      children: [
        AppConstants.image(
            widget.upsellBookList![0].bannerPath.toString().contains('https') ?
            widget.upsellBookList![0].bannerPath.toString() :
            AppConstants.BANNER_BASE + widget.upsellBookList![0].bannerPath.toString(),
            height: 80.0, width: 100.0),
        SizedBox(width: 10),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.upsellBookList![0].title.toString()),
                Text('Regular: ₹${widget.upsellBookList![0].regularPrice}, Sale : ₹${widget.upsellBookList![0].salePrice}',
                style: TextStyle(fontSize: 10))
              ],
            )
        ),
        Checkbox(
          value: isBookSelected,
          onChanged: (bool? value) {
            isBookSelected = !isBookSelected;
            if(isBookSelected) {
              selectedBookIdList.add(widget.upsellBookList![0].id.toString());
            } else {
              selectedBookIdList.remove(widget.upsellBookList![0].id.toString());
              // selectedBookIdList.clear();
            }
            setState(() {});
          })
      ],
    );
  }

  saveDeliveryAddress(bool flag, _address, _pincode, _city, _state,_landmark, _promocode) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    final param;
    String url = '';
    if(widget.type == 'Course' || widget.type=='Combo') {
      // param = {
      //   "course_id": widget.id.toString(),
      //   "promo_code": _promocode,
      //   "billing_address": _address,
      //   "billing_city": _city,
      //   "billing_state": _state,
      //   "billing_country": AppConstants.defaultCountry,
      //   "billing_pincode": _pincode
      // };

      if(widget.emiPlan != null && widget.emiPlan!.isNotEmpty) {
        param = {
          "course_id": widget.id.toString(),
          "emi_title":widget.emiPlan.toString(),
          "promo_code": _promocode
        };
      } else {
        param = {
          "course_id": widget.id.toString(),
          "promo_code": _promocode,
          "book_selected":isBookSelected,
          "upsell_book": selectedBookIdList
        };
      }
    }
    else if(widget.type == 'TestSeries') {
      param = {
        "testseries_id": widget.id.toString(),
        "promo_code": _promocode,
        "billing_address": _address,
        "billing_city": _city,
        "billing_state": _state,
        "billing_country": AppConstants.defaultCountry,
        "billing_pincode": _pincode
      };
    } else {
      param = {
        "book_id": widget.id.toString(),
        "promo_code": _promocode,
        "billing_address": _address,
        "billing_city":  _city,
        "billing_state": _state,
        "billing_country": AppConstants.defaultCountry,
        "billing_landmark":_landmark,
        "billing_pincode":  _pincode
      };
    }

    if(flag) {
      if(widget.type == 'Course' || widget.type=='Combo') {
        // url = API.order_course;
        url = widget.emiPlan != null && widget.emiPlan!.isNotEmpty ?
        API.order_course_with_emi :
        API.order_course_with_upsell;
      }
      // else if(widget.type=='Combo') {
      //   url = API.order_combo_course;
      // }
      else if(widget.type == 'TestSeries') {
        url = API.order_test_series;
      }
      else {
        url = API.order_book;
      }
    } else {
      if(widget.type == 'Course') {
        url = API.order_course_2;
      }
      else if(widget.type=='Combo') {
        url = API.order_combo_course_2;
      }
      else if(widget.type == 'TestSeries') {
        url = API.order_test_series_2;
      }
      else {
        url = API.order_book_2;
      }
    }

    await Service.post(url, body: param).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());

      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        if (jsonObject['statusCode'].toString() == '200') {
          // Delivery_model deliveryModel = Delivery_model.fromJson(jsonObject);
          DeliveryUpsellModel deliveryUpsellModel = DeliveryUpsellModel.fromJson(jsonObject);
          String status = deliveryUpsellModel.data!.status.toString();

          if (status == "Pending" || status == 'EMI') {
            BillingModel billingModel = BillingModel(
                Name,
                Email,
                Mobile,
                _address,
                _city,
                _state,
                AppConstants.defaultCountry,
                _pincode,
                _landmark,
                // widget.paidcourseList.title.toString(), widget.paidcourseList.salePrice.toString()
                widget.title.toString(),
                widget.salePrice.toString()
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        PaymentScreen(
                            widget.type,
                            billingModel,
                            deliveryUpsellModel,
                            isCouponValid ? _cuponCodeController.text.toUpperCase() : '',
                            widget.emiPlan??''
                        )
                )
            );
          } else {
            AppConstants.printLog('yes');
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                PaymentReceiptPage(
                    widget.type,
                    deliveryUpsellModel.data!.orderId.toString(),
                    deliveryUpsellModel.data!.paymentOrderId.toString(),
                    'signature',
                    deliveryUpsellModel.data!.orderNo.toString(),
                    deliveryUpsellModel.data!.bookSelected??false)
            ));
          }
        } else {
          AppConstants.showBottomMessage(
              context, jsonObject['data'].toString(), AppColors.black);
        }
      } else if(response.statusCode==429) {
        saveDeliveryAddress(false, _address, _pincode, _city, _state,_landmark, _promocode);

      } else {
        AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);
        isCouponValid = false;
      }
    });
  }

  bool checkValidation(_address, _state, _city,_pincode,_landmark,_promocode) {
    if (widget.type == 'Book' && _address.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.address_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _state.isEmpty) {
      AppConstants.showBottomMessage(context,  getTranslated(context, StringConstant.State_Required)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _city.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.CITY_REQUIRED)!, AppColors.black);
      return false;
    }else if (widget.type == 'Book' && _pincode.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.pincode_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _landmark.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.landmarkTehsil)!, AppColors.black);
      return false;
    }else if(_promocode.toString().isNotEmpty && !isCouponValid) {
      AppConstants.showBottomMessage(context,getTranslated(context, StringConstant.applyCoupon)!, AppColors.black);
      return false;
    }
    else {
      return true;
    }
  }

  bool checkCoupon(_promocode){
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
