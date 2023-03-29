import 'dart:async';
import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/BookBannerDetail.dart';
import 'package:exampur_mobile/presentation/DeliveryDetail/delivery_detail_screen.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../SharePref/shared_pref.dart';
import '../../data/model/delivery_upsell_model.dart';
import '../../utils/analytics_constants.dart';
import '../../utils/api.dart';
import '../../utils/dimensions.dart';
import 'books/bookDeliveryAddress.dart';
import 'books/bookPaymentScreen.dart';

class BannerLinkBookDetailPage extends StatefulWidget {
  final String type;
  final String datalink;
  BannerLinkBookDetailPage(this.type, this.datalink) ;

  @override
  _BannerLinkBookDetailPageState createState() => _BannerLinkBookDetailPageState();
}

class _BannerLinkBookDetailPageState extends State<BannerLinkBookDetailPage> {
  Book? bannerDetailData;
  bool isLoading=false;


  Future<void> getLists() async {
    isLoading=true;
    bannerDetailData= (await Provider.of<HomeBannerProvider>(context, listen: false).getHomeBannnerBookDetail(context, widget.datalink.toString()))!;
    isLoading=false;
    setState(() {});
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLists().then((value) {
      var map = {
        'Page_Name':'Home_Page',
        'Banner_Rank':AppConstants.currentindex,
        'Banner_Name':bannerDetailData!.title.toString(),
        'Mobile_Number':AppConstants.userMobile,
        'Language':AppConstants.langCode,
        'User_ID':AppConstants.userMobile,
        'Course_Category':((bannerDetailData!.category!.map((item) => item.name)).toList()).join(', ')
      };
       AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Banner_Home,map);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:bannerDetailData==null?Center(child: LoadingIndicator(context)):
        BookBannerDetail(bannerDetailData)
      // Viedobanner(bannerDetailData!.videoPath.toString(), bannerDetailData!.title.toString(), bannerDetailData!.id.toString(), bannerDetailData!.salePrice.toString(),)

    );
  }
}



class BookBannerDetail extends StatefulWidget {
  Book? bookDetailData;
  BookBannerDetail(this.bookDetailData) : super();

  @override
  _BookBannerDetailState createState() => _BookBannerDetailState();
}

class _BookBannerDetailState extends State<BookBannerDetail> {
  final TextEditingController _cuponCodeController = TextEditingController();
  bool isCouponValid = false;
  String userName = '';
  String Name ='';
  // String Email='';
  String Mobile='';
  // String City='A';
  // String State='A';
  String LandMark='a';
  String Pincode='123456';
  String Address='A';
  String discountprice = '';
  String finalAmount = '';
  late Razorpay razorpay;
  DeliveryUpsellModel? deliveryUpsellModel;

  final ScrollController _controller = ScrollController();
  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    // AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
   // Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    // City = jsonValue[0]['data']['city'].toString();
    // State = jsonValue[0]['data']['state'].toString();
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3,
              // child: CachedNetworkImage(
              //   imageUrl:
              //       widget.books.bannerPath.toString(),
              //   errorWidget: (context, url, error) => new Icon(Icons.error),
              // ),
              child: widget.bookDetailData!.bannerPath.toString().contains('http') ?
              AppConstants.image(widget.bookDetailData!.bannerPath.toString()) :
              AppConstants.image(AppConstants.BANNER_BASE + widget.bookDetailData!.bannerPath.toString()),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                widget.bookDetailData!.title.toString(),
                softWrap: true,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.bookDetailData!.description.toString(),
                softWrap: true,
                style: TextStyle(fontSize: 12),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                getTranslated(context,LangString.priceBreakdown)!,
                softWrap: true,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context,LangString.Price)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '₹ ${widget.bookDetailData!.regularPrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 12,decoration: TextDecoration.lineThrough,color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context,LangString.sellingPrice)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '₹ ${widget.bookDetailData!.salePrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Divider(thickness: 0,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getTranslated(context, LangString.TotalAmount)!,
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '₹ ${widget.bookDetailData!.salePrice.toString()}',
                    softWrap: true,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            !isCouponValid? SizedBox():     Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discount',
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '₹ ${discountprice}',
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            !isCouponValid? SizedBox():     Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Final Amount',
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '₹ ${AppConstants.customRound(double.parse(finalAmount))}',
                    softWrap: true,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Divider(thickness: 0,),
            ),
            Row(children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 50,
                  child: Container(
                    width: 70,
                    height: 45,
                    padding: EdgeInsets.only(left: 8,top: 4),
                    margin: EdgeInsets.only(left: 8),
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
                      onTap: (){
                        Timer(Duration(milliseconds: 200),(){
                          _controller.jumpTo(_controller.position.maxScrollExtent);
                        });
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      FocusScope.of(context).unfocus();
                      String cuponCode = _cuponCodeController.text.toUpperCase();
                      String id = widget.bookDetailData!.id.toString();

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
                ),
              )
            ]),
            isCouponValid ? Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 8),
              child: Text('Coupon applied successfully', style: TextStyle(color: AppColors.green, fontSize: 10),textAlign: TextAlign.center,),
            ) : SizedBox(),
         //   Spacer(),
         //    Padding(
         //      padding: const EdgeInsets.only(bottom: 10),
         //      child: Align(
         //        alignment: FractionalOffset.bottomCenter,
         //        child: CustomElevatedButton(
         //          onPressed: () {
         //            Navigator.push(
         //              context,
         //              MaterialPageRoute(builder: (context) =>
         //                  DeliveryDetailScreen('Book', widget.bookDetailData!.id.toString(),
         //                      widget.bookDetailData!.title.toString(), widget.bookDetailData!.salePrice.toString()
         //                  )
         //              ),
         //            );
         //          },
         //          text:getTranslated(context, LangString.placeOrder)!,
         //        ),
         //      ),
         //    ),
          ],
          // ),
        ),
      ),
      bottomNavigationBar:Container(height: 60,color: Colors.transparent,
        child:  Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: CustomElevatedButton(
              onPressed: () {
                String _promocode = _cuponCodeController.text.trim();
                var map = {
                  'Page_Name':'Confirm_Book_Purchase',
                  'Mobile_Number':AppConstants.userMobile,
                  'Language':AppConstants.langCode,
                  'User_ID':AppConstants.userMobile,
                  'Book_Name':widget.bookDetailData!.title.toString()
                };
                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Place_Order,map);
                if(_promocode.toString().isNotEmpty && !isCouponValid) {
                  AppConstants.showBottomMessage(context,getTranslated(context, LangString.applyCoupon)!, AppColors.black);

                } else {
                  saveDeliveryAddress(_promocode);
                }
              },
              text:getTranslated(context, LangString.placeOrder)!,
            ),
          ),
        ) ,
      ) ,
    );
  }
  couponApi(couponUrl, promoCode, id ) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    String url = '';
    url = couponUrl + promoCode + '/' +'Book' +'/'+id;
    AppConstants.printLog(url);
    await Service.get(url).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        if (jsonObject['statusCode'].toString() == '200') {
          AppConstants.printLog('anchal' + jsonObject['data']['promo_code']);
          //AppConstants.printLog('anchal' + jsonObject['data']['discount']);
          discountprice = jsonObject['data']['discount'].toString();
          finalAmount = jsonObject['data']['final_amount'].toString();
          AppConstants.printLog(discountprice);
          AppConstants.showBottomMessage(context, getTranslated(context, LangString.apply), AppColors.black);
          isCouponValid = true;
          setState(() {});
        }else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          isCouponValid = false;
          _cuponCodeController.text = '';
          setState(() {});}
      }
    });
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

  saveDeliveryAddress(String _promocode) async {
    FocusScope.of(context).unfocus();
    AppConstants.showLoaderDialog(context);
    var  param = {
      "book_id": widget.bookDetailData!.id.toString(),
      "promo_code": _promocode,
      "billing_address": Address,
      // "billing_city":  City,
      // "billing_state": State,
      "billing_city":  AppConstants.defaultCity,
      "billing_state": AppConstants.defaultState,
      "billing_country": AppConstants.defaultCountry,
      "billing_landmark":LandMark,
      "billing_pincode":  Pincode
    };
    await Service.post(API.order_book, body: param).then((response) async {
      Navigator.pop(context);
      AppConstants.printLog(response.body.toString());
      if(response != null && response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        if (jsonObject['statusCode'].toString() == '200') {
           deliveryUpsellModel = DeliveryUpsellModel.fromJson(jsonObject);
          AppConstants.printLog(jsonObject['data']);
          openCheckout();
          // Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //     BookPaymentSceen(widget.bookDetailData!.id.toString(),
          //         widget.bookDetailData!.title.toString(),isCouponValid ? _cuponCodeController.text.toUpperCase() : '',deliveryUpsellModel)
          // )
          // );
        }else {
          AppConstants.showBottomMessage(
              context, jsonObject['data'].toString(), AppColors.black);
        }
      }
      else {
        AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError), AppColors.red);
        //isCouponValid = false;
      }
    });
  }
  void openCheckout() {
    var options = {
      "key": Keys.Razar_pay_key,
      "amount": num.parse(deliveryUpsellModel!.data!.amount.toString()) * 100,
      "name": "Exampur",
      "description":deliveryUpsellModel!.data!.description.toString(),
      "order_id":deliveryUpsellModel!.data!.paymentOrderId.toString(),
      "timeout": "180",
      "theme.color": "#d19d0f",
      "currency": "INR",
     // "prefill": {"contact":  Mobile.toString(), "email": Email.toString()},
      "prefill": {"contact":  Mobile.toString()},
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
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name': widget.bookDetailData!.title,
      'Book_Price':deliveryUpsellModel!.data!.amount.toString()
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Successful,bookmap);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BookDeliveryAddress( widget.bookDetailData!.id.toString(),isCouponValid ? _cuponCodeController.text.toUpperCase() : '',deliveryUpsellModel!.data!.orderNo.toString(),deliveryUpsellModel!.data!.orderId.toString(),response.paymentId,response.signature, widget.bookDetailData!.title.toString(),type:'Book')
        ));
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    String msg = "ERROR: " + response.code.toString() + " - " + jsonDecode(response.message!)['error']['description'];
    AppConstants.showBottomMessage(context, msg, Colors.red);
    var bookmap ={
      'Page_Name':'Check_Out_Books_Purchase',
      'Mobile_Number':AppConstants.userMobile,
      'Language':AppConstants.langCode,
      'User_ID':AppConstants.userMobile,
      'Book_Name': widget.bookDetailData!.title.toString(),
      'Book_Price':deliveryUpsellModel!.data!.amount.toString()
    };
    AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Purchase_Failed,bookmap);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    AppConstants.showBottomMessage(context, msg, Colors.red);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }
}

