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
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';

import '../../utils/analytics_constants.dart';

class DeliveryDetailScreen extends StatefulWidget {
  final String type;
  final String id;
  final String title;
  final String salePrice;
  final List<UpsellBook>? upsellBookList;
  final String? emiPlan;
  final String? pre_booktype;
  final PreBookDetail? preBookDetail;

  const DeliveryDetailScreen(this.type, this.id, this.title, this.salePrice,{this.upsellBookList, this.emiPlan,this.pre_booktype,this.preBookDetail}) ;

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
  String preBookTypeCoupon = '';
  bool isBookSelected = false;
  List<String> selectedBookIdList = [];
  String prebookButtonText = 'Pre-book Now';
  String subMsg = '';
  bool preBooked = false;

  final TextEditingController _billingAddressController = TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingStateController = TextEditingController();
  final TextEditingController _billingPincodeController = TextEditingController();
  final TextEditingController _cuponCodeController = TextEditingController();
  final TextEditingController _billinglandMarkController = TextEditingController();

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
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
    subMsg = AppConstants.langCode == 'hi' ? LangString.preBookSubTextHi : LangString.preBookSubTextEng;
    // if(widget.pre_booktype == 'Prebook') {
    if(widget.type == 'Course' || widget.type=='Combo') {
      Future.delayed(Duration.zero, () {
        checkPreBookOpted();
      });
    }
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
              getTranslated(context, LangString.use_coupon)!,
              maxLines: 2, softWrap: true,
              style: TextStyle(fontSize: 25),
            ) : widget.type == 'TestSeries' ? Text('Test Series', style: TextStyle(fontSize: 25)) :
            Text(
              getTranslated(context, LangString.provideFurtherDetailsForDeliveryOfBooks)!,
              maxLines: 2,softWrap: true, style: TextStyle(fontSize: 25),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TextUse(
                image: Icons.location_city,
                title: getTranslated(context, LangString.address),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterAddress)!,
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
                title: getTranslated(context, LangString.landmarkTehsil),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox():
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.landmarkTehsil)!,
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
                title: getTranslated(context, LangString.city),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterCity)!,
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
                title: getTranslated(context, LangString.state),
              ),
            ),

            widget.type == 'Course'|| widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterState)!,
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
                title: getTranslated(context, LangString.pinCode),
              ),
            ),

            widget.type == 'Course'||widget.type=='Combo' || widget.type == 'TestSeries' ? SizedBox() :
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: CustomTextField(
                hintText: getTranslated(context, LangString.enterPinCode)!,
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
                          hintText: getTranslated(context, LangString.applyCoupon),
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
                    AnalyticsConstants.moengagePlugin.setUserAttribute('Coupon_Course',widget.title);
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
                    height: 45,child: Center(child: Text(getTranslated(context, LangString.apply)!,style: TextStyle(color: AppColors.white),)),
                  ),
                ),
              )
            ]),
            isCouponValid ? Text('Coupon applied successfully', style: TextStyle(color: AppColors.green, fontSize: 10),) : SizedBox(),
            widget.upsellBookList == null ? SizedBox() : widget.upsellBookList!.length > 0 ? showUpsellBookList() : SizedBox(),
            widget.type == 'Book' ? SizedBox() : widget.pre_booktype ==null || widget.pre_booktype =='null' || widget.pre_booktype =='Published'? SizedBox(): SizedBox(height: 20),
            widget.type == 'Book' ? SizedBox() : widget.pre_booktype ==null || widget.pre_booktype =='null' || widget.pre_booktype =='Published'? SizedBox():Center(child: Text(preBooked ? getTranslated(context, LangString.preBookAlertAlreadyHead)!: subMsg.replaceAll('X', widget.preBookDetail!.percentOff.toString()),style: TextStyle(color:AppColors.grey),)),
            widget.type == 'Book' ? SizedBox(height: 20,) : widget.pre_booktype ==null || widget.pre_booktype =='null' || widget.pre_booktype =='Published'? SizedBox(height: 30): SizedBox(height: 10),
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
                  'Book_Name':widget.title.toString()
                };
                widget.type == 'Book' ?  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Confirm_Purchase_Books,map):null;
                if(widget.pre_booktype == null ||widget.pre_booktype == 'Published')
                {
                  if(checkValidation(_address, _state, _city, _pincode,_landmark,_promocode)) {
                    saveDeliveryAddress(true, _address, _pincode, _city, _state,_landmark, _promocode);
                  }
                }
                else{
                  String message = AppConstants.langCode== 'hi'? LangString.preBookAlertAlreadyHi : LangString.preBookAlertAlreadyEng;
                  preBooked ? AppConstants.showAlertDialogOkButton(context, getTranslated(context, LangString.preBookAlertAlreadyHead)!,
                      message.replaceAll('X', widget.preBookDetail!.percentOff.toString()),
                      (){
                    Navigator.pop(context);
                  }) : preBookOrder();
              }},

              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                height: 50,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: AppColors.amber),

                child: Center(
                    child: widget.type == 'Course'||widget.type=='Combo' ?
                    Text(
                      widget.pre_booktype == null || widget.pre_booktype =='Published'?
                      getTranslated(context, LangString.continueToBuyCourse)!:prebookButtonText,textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.white,fontSize: widget.pre_booktype =='Published'? 16:12),
                    ) :  widget.type == 'TestSeries' ?
                    Text(
                      'Continue to Buy Test Series',
                      style: TextStyle(color: AppColors.white,fontSize: 16),
                    ) :
                    Text(getTranslated(context, LangString.continueToBuyBook)! ,
                      style: TextStyle(color: AppColors.white,fontSize: 16),
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
          AppConstants.showBottomMessage(context, getTranslated(context, LangString.apply), AppColors.black);
          isCouponValid = true;
          var map = {
            'Page_Name':'Coupon_Code_Page',
            'Course_Category':AppConstants.paidTabName,
            'Course_Name':widget.title.toString(),
            'Mobile_Number':AppConstants.userMobile,
            'Language':AppConstants.langCode,
            'User_ID':AppConstants.userMobile,

          };
          widget.type == 'Book' ? null: AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Coupon_Code_Successfully_Applied,map);
          setState(() {});
        } else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          isCouponValid = false;
          _cuponCodeController.text = '';
          var map = {
            'Page_Name':'Coupon_Code_Page',
            'Course_Category':AppConstants.paidTabName,
            'Course_Name':widget.title.toString(),
            'Mobile_Number':AppConstants.userMobile,
            'Language':AppConstants.langCode,
            'User_ID':AppConstants.userMobile,
          };
          widget.type == 'Book' ? null: AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Coupon_Code_Failed,map);
          setState(() {});
        }
      }else if(response.statusCode==429) {
        couponApi(API.CouponCode_URL_2, promoCode, id);

      } else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
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
                Row(children: [
                  Text('Regular: ',
                      style: TextStyle(fontSize: 10)),
                  Text('₹${widget.upsellBookList![0].regularPrice}',
                      style: TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough,)),
                  Text(' Sale : ',
                      style: TextStyle(fontSize: 10)),
                  Text('₹${widget.upsellBookList![0].salePrice}',
                      style: TextStyle(fontSize: 10))
                ],),
                Text(AppConstants.langCode == 'hi'?'इस course के साथ NOTES खरीदते समय आप "200 अतिरिक्त" बचा रहे हैं':'You are saving "200 extra" while purchasing book with this course',
                    style: TextStyle(fontSize: 10,color: Colors.green), )

              ],
            )
        ),
        Checkbox(
          value: isBookSelected,
          onChanged: (bool? value) {
            isBookSelected = !isBookSelected;
            if(isBookSelected) {
              selectedBookIdList.add(widget.upsellBookList![0].id.toString());
              var map = {
                'Page_Name':'Coupon_Code_Page',
                'Course_Category':AppConstants.paidTabName,
                'Course_Name':widget.title.toString(),
                'Mobile_Number':AppConstants.userMobile,
                'Language':AppConstants.langCode,
                'User_ID':AppConstants.userMobile,
                'Book_Name':widget.upsellBookList![0].title.toString()
              };
              AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Recommended_Book,map);
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
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
        //isCouponValid = false;
      }
    });
  }

  bool checkValidation(_address, _state, _city,_pincode,_landmark,_promocode) {
    if (widget.type == 'Book' && _address.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.address_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _state.isEmpty) {
      AppConstants.showBottomMessage(context,  getTranslated(context, LangString.State_Required)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _city.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.CITY_REQUIRED)!, AppColors.black);
      return false;
    }else if (widget.type == 'Book' && _pincode.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.pincode_REQUIRED)!, AppColors.black);
      return false;
    }
    else if (widget.type == 'Book' && _landmark.isEmpty) {
      AppConstants.showBottomMessage(context, getTranslated(context, LangString.landmarkTehsil)!, AppColors.black);
      return false;
    }else if(_promocode.toString().isNotEmpty && !isCouponValid) {
      AppConstants.showBottomMessage(context,getTranslated(context, LangString.applyCoupon)!, AppColors.black);
      return false;
    }
    else {
      return true;
    }
  }

  bool checkCoupon(_promocode){
    if (_promocode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, LangString.PromoCode_REQUIRED)!), backgroundColor:AppColors.black));
      return false;
    }
    else {
      return true;
    }
  }

  Future<void> checkPreBookOpted() async {
    var course_type = '';
    if(widget.type == 'Course') {
      course_type = "course";
    } else if(widget.type=='Combo') {
      course_type = "combo_course";
    }
    AppConstants.showLoaderDialog(context);
    await Service.get(API.preBookOptedUrl.replaceAll('COURSE_ID',widget.id) + '?course_type=' + course_type).then((response) async {
      Navigator.pop(context);
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        preBooked = jsonObject['status'];
        if (jsonObject['status'] == true) {
          setState(() {
            String off = jsonObject['prebook_details']['percentage_off'].toString();
            _cuponCodeController.text = jsonObject['prebook_details']['coupon_code'].toString();
            String btnText = AppConstants.langCode == 'hi' ? LangString.preBookDelBtnHi : LangString.preBookDelBtnEng;
            prebookButtonText = btnText.replaceAll('X', off);
          });
        }
        setState(() {});
      }
      else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      }
    }
    );
  }

  Future<void> preBookOrder() async {
    var bodyParam = {};
    if(widget.type == 'Course') {
      bodyParam = {
        "course_type": "course"
      };
    } else if(widget.type=='Combo') {
      bodyParam = {
        "course_type": "combo_course"
      };
    }
    await Service.post(API.preBookOptedUrl.replaceAll('COURSE_ID',widget.id), body: bodyParam).then((response) async {
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject['statusCode'].toString() == '200') {
          await FirebaseAnalytics.instance.logEvent(name: 'PreBookClicked',parameters: {
            'name':userName,
            'course':widget.title.toString(),
            'mobile_number':Mobile
          });
          String message = AppConstants.langCode== 'hi'? LangString.preBookAlertHi : LangString.preBookAlertEng;
          AppConstants.showAlertDialogOkButton(context,getTranslated(context, LangString.preBookAlertSuccessHead)!,message.replaceAll('X', widget.preBookDetail!.percentOff.toString()),(){
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      }
      else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
      }
    }
    );
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
