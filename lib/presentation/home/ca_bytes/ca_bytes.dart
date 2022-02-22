import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/c_a_bytes_model.dart';
import 'package:exampur_mobile/provider/CABytesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaBytes extends StatefulWidget {
  CaBytes({
    Key? key,
  }) : super(key: key);

  @override
  _CaBytesState createState() => _CaBytesState();
}

class _CaBytesState extends State<CaBytes> {
  int page = 0;
  bool isLoading=false;
  List<Data> caBytesList = [];

  Future<void> callProvider(pageNo) async {
    isLoading=true;
    String encodeCat = AppConstants.encodeCategory();
    List<Data> list=  (await Provider.of<CABytesProvider>(context, listen: false)
        .getCaBytesList(context,encodeCat, pageNo))!;
    if(list.length > 0) {
      page +=1;
      caBytesList = caBytesList + list;
    }
    isLoading=false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callProvider(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body:isLoading? Center(child: CircularProgressIndicator(color: AppColors.amber,)):caBytesList.length==0?
        Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text(getTranslated(context, StringConstant.noData)!)
          ],
        )):
        CarouselSlider(
          options: CarouselOptions(
            height: double.maxFinite,
            viewportFraction: 1,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              if(index==caBytesList.length-1){

                callProvider(page);
              }
            },
          ),
          items: caBytesList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: AppColors.transparent,
                      //  border: Border.all(width: 3,color: AppColors.red)
                    ),
                    child: AppConstants.image(
                        AppConstants.BANNER_BASE + i.imagePath.toString(), boxfit: BoxFit.fill
                    )
                );
              },
            );
          } ).toList(),
        )
    );
  }
}
