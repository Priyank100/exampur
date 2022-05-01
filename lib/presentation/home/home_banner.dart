import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BannerBookDetailPage.dart';
import 'banner_link_detail_page.dart';

class LargeBanner extends StatefulWidget {
  List<BannerData> bannerList;

  LargeBanner({Key? key, required this.bannerList}) : super(key: key);

  @override
  _LargeBannerState createState() => _LargeBannerState();
}

class _LargeBannerState extends State<LargeBanner> {
  int _current = 0;
bool isLoading =false;
  @override
  Widget build(BuildContext context) {

    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              disableCenter: true,
              viewportFraction: 1,
              autoPlayAnimationDuration: Duration(milliseconds: 200),
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  AppConstants.printLog("${_current}");
                  // AppConstants.printLog(AppConstants.BANNER_BASE + widget.bannerList[index].imagePath.toString());
                });
              },
            ),
            items: widget.bannerList.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(color: AppColors.transparent),
                    child: InkWell(
                        child: ClipRRect(
                          // child: CachedNetworkImage(
                          //   fit: BoxFit.fill,
                          //   imageUrl: AppConstants.BANNER_BASE + i.imagePath.toString(),
                          //   placeholder: (context, url) => new Image.asset(Images.noimage),
                          //   errorWidget: (context, url, error) => new Icon(Icons.error),
                          // ),
                          child: item.imagePath.toString().contains('http') ?
                          AppConstants.image(item.imagePath.toString(), boxfit: BoxFit.fill) :
                          AppConstants.image(AppConstants.BANNER_BASE + item.imagePath.toString(), boxfit: BoxFit.fill),
                        ),
                        onTap: () {
                          //for sendAnalyticsEvent
                          item.type=='Course' || item.type=='Combo Course' ? AppConstants.sendAnalyticsEvent('BANNER_Course_CLICKED'):
                          item.type=='Book'?AppConstants.sendAnalyticsEvent('BANNER_Course_Book'):AppConstants.sendAnalyticsEvent('BANNER_Course_ExternalLink');

                          item.type=='Course' || item.type=='Combo Course'?
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>
                              BannerLinkDetailPage(item.type.toString(),item.link.toString())
                          )):
                          item.type=='Book'?
                          Navigator.push(context, MaterialPageRoute(builder: (_) =>
                              BannerLinkBookDetailPage(item.type.toString(),item.link.toString())
                          )):
                          // Navigator.push(context, MaterialPageRoute(builder: (_) =>
                          //     BannerDetailPage(item.link.toString(),item.title.toString())
                          // ));
                          AppConstants.makeCallEmail(item.link.toString());
                        }),
                  );
                },
              );
            } ).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:widget.bannerList.map(
                  (image) {
                int index = widget.bannerList.indexOf(image);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color(0xFFEDEDED)
                          : Color(0xFF808080)),
                );
              },
            ).toList(), // this was the part the I had to add
          ),
        ]);
  }
}
