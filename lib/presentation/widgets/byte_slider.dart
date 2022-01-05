import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ByteSlider extends StatefulWidget {
  ByteSlider({
    Key? key,
  }) : super(key: key);

  @override
  _ByteSliderState createState() => _ByteSliderState();
}

class _ByteSliderState extends State<ByteSlider> {
  int _current = 0;
  List<String> image = ["f", "f"];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        scrollDirection: Axis.vertical,
        height: MediaQuery.of(context).size.height,
        aspectRatio: 3 / 4,
        disableCenter: true,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
            AppConstants.printLog("${_current}");
          });
        },
      ),
      items: image.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 18),
              decoration: BoxDecoration(color: Colors.transparent
              , border: Border.all(width: 3,color: Colors.red)
              ),
              child: GestureDetector(
                  child: ClipRRect(

                    child: FadeInImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://static.photocdn.pt/images/articles/2018/05/07/articles/2017_8/how_to_take_vertical_landscape_photos.jpg"),
                      placeholder: AssetImage(Images.noimage),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Images.noimage,
                        );
                      },
                    ),
                  ),
                  onTap: () {}),
            );
          },
        );
      }).toList(),
    );
  }
}