import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/data/model/response/home_banner_model.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LargeBanner extends StatefulWidget {
  List<BannerData> bannerList;

  LargeBanner({Key? key, required this.bannerList}) : super(key: key);

  @override
  _LargeBannerState createState() => _LargeBannerState();
}

class _LargeBannerState extends State<LargeBanner> {
  int _current = 0;

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
                  AppConstants.printLog(AppConstants.BANNER_BASE + widget.bannerList[index].imagePath.toString());
                });
              },
            ),
            items: widget.bannerList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: InkWell(
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: AppConstants.BANNER_BASE + i.imagePath.toString(),
                            placeholder: (context, url) => new Image.asset(Images.noimage),
                            errorWidget: (context, url, error) => new Icon(Icons.error),
                          ),
                        ),
                        onTap: () {}),
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
