import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/data/model/response/HomeBannerModel.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LargeBanner extends StatefulWidget {
  List<HomeBannerModel> bannerModel;

  LargeBanner({Key? key, required this.bannerModel}) : super(key: key);

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
              height: 200.0,
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
                });
              },
            ),
            // items: widget.image.map((i) {
            items: widget.bannerModel.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: GestureDetector(
                        child: ClipRRect(
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(i.imagePath.toString()),
                            placeholder: AssetImage("assets/images/no_image.jpg"),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/no_image.jpg',
                              );
                            },
                          ),
                        ),
                        onTap: () {}),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:widget.bannerModel.map(
                  (image) {
                int index = widget.bannerModel.indexOf(image);
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
