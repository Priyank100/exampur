import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/drawer/Parchase_course/purchaseListContainer.dart';
import 'package:exampur_mobile/provider/mypurchaseProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/my_purchase_model.dart';
import 'package:provider/provider.dart';

class MyPurchases extends StatefulWidget {
  MyPurchases({
    Key? key,
  }) : super(key: key);

  @override
  _MyPurchasesState createState() => _MyPurchasesState();
}

class _MyPurchasesState extends State<MyPurchases> {
  List<Data> mypurchaseList= [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getDemoList();
  }
  Future<void> getDemoList() async {
    isLoading=true;
    String token = await SharedPref.getSharedPref(SharedPrefConstants.TOKEN);
    mypurchaseList= (await Provider.of<MyPurchaseProvider>(context, listen: false).getMyPurchaseList(context, token))!;
    isLoading=false;
    setState(() {});
    // return one2oneList;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.FONT_SIZE_SMALL,bottom: Dimensions.FONT_SIZE_SMALL),
              child: Text(
                getTranslated(context, StringConstant.myPurchase)!,
                style: TextStyle(fontSize: 25),
              ),
            ),
           isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)): mypurchaseList.length==0?AppConstants.noDataFound() : ListView.builder(itemCount:mypurchaseList.length,
    shrinkWrap: true,
   physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context,int index){
    return PurchaseListContainer(mypurchaseList[index]);
              })
           ],
        )));
  }
}
