import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/c_a_bytes_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/CABytesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
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
  int _current = 0;
  var scrollController = ScrollController();
  bool isLoading = false;
  int page = 0;
  bool isData = true;
  List<String> image = ["f", "f"];
  List<Data> caBytesList = [];

  String encodeCat = '';

  Future<void> callProvider(pageNo) async {

   // String catList = AppConstants.selectedCategoryList.toString();
    //[gfhtjfyifiky,ghfuyjflygliy,jfkif]
    //["gfhtjfyifiky","ghfuyjflygliy","jfkif"]
//print(catList.toString());
    encodeCat = AppConstants.encodeCategory();

    List<Data> list=  (await Provider.of<CABytesProvider>(context, listen: false)
        .getCaBytesList(context,encodeCat, pageNo))!;
    if(list.length > 0) {
      isData = true;
      caBytesList = caBytesList + list;
    } else {
      isData = false;
    }
    isLoading = false;
    setState(() {});
  }
  @override
  void initState() {
    scrollController.addListener(pagination);
    // TODO: implement initState
    super.initState();
    callProvider(page);
  }

  void pagination(){
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      setState(() {
        if(isData){
          page +=1;
          AppConstants.printLog(page.toString());
        }
        isLoading = true;
        callProvider(page);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: caBytesList.length==0?Center(child: CircularProgressIndicator(color: AppColors.amber,)) :
      Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(getTranslated(context, StringConstant.CaBytes)!,style: TextStyle(fontSize: 27),),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: caBytesList.length,
                    itemBuilder: (BuildContext context, index){
                      return Container(
                                    height: 650,
                                    margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 18),
                                    decoration: BoxDecoration(color: AppColors.transparent,
                                    border: Border.all(width: 3,color: AppColors.red)
                                    ),
                                    child: GestureDetector(
                                        child:AppConstants.image(AppConstants.BANNER_BASE +caBytesList[index].imagePath.toString(), boxfit: BoxFit.fill),
                                        onTap: () {}),
                                  );
                                },
                              )
              )


            ],
          )),
        //    CarouselSlider(
        // options: CarouselOptions(
        //
        //
        //     scrollDirection: Axis.vertical,
        //     height: MediaQuery.of(context).size.height,
        //     disableCenter: true,
        //     viewportFraction: 1,
        //     enlargeCenterPage: true,
        //     autoPlayCurve: Curves.fastOutSlowIn,
        //     onPageChanged: (index, reason) {
        //       setState(() {
        //         _current = index;
        //         AppConstants.printLog("${_current}");
        //       });
        //     },
        // ),
        // items:  caBytesList.map((i) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //           height: 400,
        //           margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 18),
        //           decoration: BoxDecoration(color: AppColors.transparent,
        //           border: Border.all(width: 3,color: AppColors.red)
        //           ),
        //           child: GestureDetector(
        //               child:AppConstants.image(AppConstants.BANNER_BASE + i.imagePath.toString(), boxfit: BoxFit.fill),
        //               onTap: () {}),
        //         );
        //       },
        //     );
        // }).toList(),
        //
        //   ):Center(child: CircularProgressIndicator(color: AppColors.amber,))
      bottomNavigationBar: isLoading ? Container(
         // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator(color: AppColors.amber,))) :
      SizedBox(),
    );
  }
}
