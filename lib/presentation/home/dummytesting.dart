import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

class dummy extends StatefulWidget {
  const dummy({Key? key}) : super(key: key);

  @override
  _dummyState createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: (){
          var body = { [
          "61cad845da1d8532b6f33fd1", "61d2cc701cea2fdab6e9cb06", "61d2cc8c1cea2fdab6e9cb07"
        ]};
        final bytes = utf8.encode(body.toString());
        final base64Str = base64.encode(bytes);
        print(base64Str);
        // UpdateChoosecategory(selectedCountries);
        couponApi(base64Str);},
          child: Text('hello'),),
      ),
    );
  }

couponApi(category,  ) async {
  FocusScope.of(context).unfocus();
  AppConstants.showLoaderDialog(context);

  //String url='https://static.exampur.work/ca_byte/:category/:limit/:skip';
  String   url = ' https://static.exampur.work/ca_byte/'+ category +'/10/0';


print(url);
  await Service.get(url).then((response) async {
    Navigator.pop(context);
    AppConstants.printLog(response.body.toString());

    if(response != null && response.statusCode == 200) {
      var jsonObject =  jsonDecode(response.body);

      // if(jsonObject['statusCode'].toString() == '200') {
      //   // AppConstants.printLog('anchal'+ jsonObject['data']['promo_code']);
      //   // AppConstants.showBottomMessage(context,getTranslated(context, StringConstant.apply), AppColors.black);
      //
      // } else {
      //   AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
      //
      // }

    } else {
      AppConstants.showBottomMessage(context, getTranslated(context, StringConstant.serverError), AppColors.red);

    }
  });
}}