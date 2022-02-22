import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/presentation/drawer/Parchase_course/purchaseListContainer.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
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
    mypurchaseList= (await Provider.of<MyPurchaseProvider>(context, listen: false).getMyPurchaseList(context))!;
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
                'My Purcahses',
                style: TextStyle(fontSize: 25),
              ),
            ),
           isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)): mypurchaseList==0?Text('No_Data') : ListView.builder(itemCount:mypurchaseList.length,
    shrinkWrap: true,
   physics: BouncingScrollPhysics(),
    itemBuilder: (BuildContext context,int index){
    return PurchaseListContainer(mypurchaseList[index]);
              })
           ],
        )));
  }
}
