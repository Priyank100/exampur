import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/data/model/c_a_bytes_model.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/CABytesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../SharePref/shared_pref.dart';
import '../../../data/model/response/home_banner_model.dart';
import '../../../utils/api.dart';
import '../BannerBookDetailPage.dart';
import '../banner_link_detail_page.dart';
import '../test_series_new/test_series_new.dart';

class CaBytes extends StatefulWidget {
  final List<BannerData> bannerList;
  CaBytes(this.bannerList,

  ) : super();

  @override
  _CaBytesState createState() => _CaBytesState();
}

class _CaBytesState extends State<CaBytes> {
  CarouselController controller = CarouselController();
  bool lastPage = false;
  // int page = 0;
  // bool isLoading=false;
  // List<Data> caBytesList = [];
  //
  // Future<void> callProvider(pageNo) async {
  //   isLoading=true;
  //   String encodeCat = AppConstants.encodeCategory();
  //   List<Data> list=  (await Provider.of<CABytesProvider>(context, listen: false)
  //       .getCaBytesList(context,encodeCat, pageNo))!;
  //   if(list.length > 0) {
  //     page += 10;
  //     caBytesList = caBytesList + list;
  //   }
  //   isLoading=false;
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
  //  callProvider(page);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // appBar: CustomAppBar(),
        body:
        widget.bannerList.length==0?
        AppConstants.noDataFound():
        ListView.builder(
            itemCount: widget.bannerList.length,
            itemBuilder: (BuildContext context, i){
              return InkWell(
                onTap: () async {
                  AppConstants.paidTabName = widget.bannerList[i].id.toString();
                  AppConstants.currentindex = i.toString();
                  widget.bannerList[i].type=='Course' || widget.bannerList[i].type=='Combo Course'?
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                      settings: RouteSettings(name: 'Home_page'),
                      builder: (_) => BannerLinkDetailPage(widget.bannerList[i].type.toString(),widget.bannerList[i].link.toString()))):
                  widget.bannerList[i].type=='Book'?
                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => BannerLinkBookDetailPage(widget.bannerList[i].type.toString(),widget.bannerList[i].link.toString())
                  )):
                  // Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  //     BannerDetailPage(item.link.toString(),item.title.toString())
                  // ));

                  widget.bannerList[i].type=='External'&& widget.bannerList[i].link=='Live Test Page' ?
                  await SharedPref.getSharedPref(SharedPref.TOKEN).then((token) async {
                    Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                            builder: (_) =>
                                TestSeriesNew(API.liveTestWebUrl, token)));
                  }) :
                  AppConstants.makeCallEmail(widget.bannerList[i].link.toString());
                },
                child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(color: AppColors.transparent,
                        border: Border.all(width: 2,color: AppColors.red)
                    ),
                    child:widget.bannerList[i].imagePath.toString().contains('http') ?
                    AppConstants.image(widget.bannerList[i].imagePath.toString(), boxfit: BoxFit.fill) :
                    AppConstants.image(AppConstants.BANNER_BASE + widget.bannerList[i].imagePath.toString(), boxfit: BoxFit.fill)
                ),
              );
            })
    );
  }
}
