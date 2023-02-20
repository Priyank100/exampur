import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class TeacherIncentivePopup{
  teacherIncentiveAlert(BuildContext context) {
    int _current = 0;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: AppColors.amber,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              content: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close, color: AppColors.black)
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('you were looking for these items', textAlign: TextAlign.center),
                    Text('Complete your purchase now', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                    SizedBox(height: 10),
                    Container(
                      height: MediaQuery.of(context).size.height/1.8,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          disableCenter: true,
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        items: [],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}