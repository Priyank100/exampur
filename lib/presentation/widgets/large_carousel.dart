import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeCarousel extends StatefulWidget {
  List<String> image;

  LargeCarousel({Key? key, required this.image}) : super(key: key);

  @override
  _LargeCarouselState createState() => _LargeCarouselState();
}

class _LargeCarouselState extends State<LargeCarousel> {
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
        items: widget.image.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: AppColors.transparent),
                child: GestureDetector(
                    child: ClipRRect(
                      // child: FadeInImage(
                      //   fit: BoxFit.cover,
                      //   image: NetworkImage(i),
                      //   placeholder: AssetImage(Images.noimage),
                      //   imageErrorBuilder: (context, error, stackTrace) {
                      //     return Image.asset(
                      //       Images.noimage,
                      //     );
                      //   },
                      // ),
                      child: AppConstants.image(i, boxfit: BoxFit.cover),
                    ),
                    onTap: () {}),
              );
            },
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [1, 2, 3, 4, 5].map(
          (image) {
            int index = [1, 2, 3, 4, 5].indexOf(image);
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
