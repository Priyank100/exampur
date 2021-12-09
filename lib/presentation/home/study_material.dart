import 'package:carousel_slider/carousel_slider.dart';
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
      appBar: AppBar(title: Text("StudyMaterial")),
      body: CarouselSlider(
        options: CarouselOptions(
          scrollDirection: Axis.vertical,
          height: MediaQuery.of(context).size.height,
          aspectRatio: 3 / 4,
          disableCenter: true,
          viewportFraction: 1,
          autoPlayAnimationDuration: Duration(milliseconds: 200),
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
              print("${_current}");
            });
          },
        ),
        items: image.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 500,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: GestureDetector(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            "https://static.photocdn.pt/images/articles/2018/05/07/articles/2017_8/how_to_take_vertical_landscape_photos.jpg"),
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
    );
  }
}
