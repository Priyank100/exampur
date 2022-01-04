import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyMaterial extends StatefulWidget {
  StudyMaterial({
    Key? key,
  }) : super(key: key);

  @override
  _StudyMaterialState createState() => _StudyMaterialState();
}

class _StudyMaterialState extends State<StudyMaterial> {
  int _current = 0;
  List<String> image = ["f", "f"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: CarouselSlider(
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          height: MediaQuery.of(context).size.height,
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
                margin: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 18),
                decoration: BoxDecoration(color: Colors.transparent,
                border: Border.all(width: 3,color: Colors.red)
                ),
                child: GestureDetector(
                    child: ClipRRect(
                      //borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        fit: BoxFit.fill,
                        image: const NetworkImage(
                            "https://static.photocdn.pt/images/articles/2018/05/07/articles/2017_8/how_to_take_vertical_landscape_photos.jpg"),
                        placeholder: const AssetImage("assets/images/no_image.jpg"),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no_image.jpg'
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
    );
  }
}
