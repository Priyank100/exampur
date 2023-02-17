import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../data/model/course_book_popup_model.dart';
import '../../presentation/DeliveryDetail/delivery_detail_screen.dart';
import '../../utils/analytics_constants.dart';
import '../../utils/images.dart';
import '../place_order_screen.dart';

class CourseBookPopup{
  courseBookAlert(BuildContext context, String name, List<CourseBookPopupModel> dataList) {
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
                    Text('$name, you were looking for these items', textAlign: TextAlign.center),
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
                        items: dataList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 180,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: AppConstants.image(
                                              item.dataType == 'Course' ?
                                              item.course![0].bannerPath.toString().contains('http') ? item.course![0].bannerPath.toString() : AppConstants.BANNER_BASE + item.course![0].bannerPath.toString() :
                                              item.book![0].bannerPath.toString().contains('http') ? item.book![0].bannerPath.toString() : AppConstants.BANNER_BASE + item.book![0].bannerPath.toString(),
                                              boxfit: BoxFit.scaleDown
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    item.dataType == 'Course' ? item.course![0].title.toString() : item.book![0].title.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 2
                                                )
                                            ),
                                            item.dataType == 'Course' ? Image.asset(Images.exampur_logo, width: 60, height: 60) : SizedBox()
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: MediaQuery.of(context).size.height/2/6.5,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        child: item.dataType == 'Course' ?
                                        Html(data:item.course![0].description.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' '),
                                            style: {'body': Style(
                                                maxLines: 3,
                                                textOverflow: TextOverflow.ellipsis,
                                                fontSize: const FontSize(12)
                                            )}
                                        ) :
                                        Text(
                                            '( MRP : ₹ ${item.book![0].regularPrice.toString()}, Selling Price : ₹ ${item.book![0].salePrice.toString()} )',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(fontSize: 12)
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Course Price: ${item.dataType == 'Course' ? item.course![0].regularPrice.toString() : item.book![0].regularPrice.toString()}',
                                                style: TextStyle(fontSize: 12)
                                            ),
                                            // Text(
                                            //     'Coupon: ${item.dataType == 'Course' ? 'NA' : 'NA'}',
                                            //     style: TextStyle(fontSize: 12, color: AppColors.red)
                                            // )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Selling Price: ${item.dataType == 'Course' ? item.course![0].salePrice.toString() : item.book![0].salePrice.toString()}',
                                                style: TextStyle(fontSize: 12)
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.only(left: 5, right: 5),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            var map = {
                                              'Page_Name':'Home_Page',
                                              'Mobile_Number':AppConstants.userMobile,
                                              'Language':AppConstants.langCode,
                                              'User_ID':AppConstants.userMobile
                                            };
                                            AnalyticsConstants.trackEventMoEngage(
                                                item.dataType == 'Course'?
                                                AnalyticsConstants.popup_course_buy:
                                                AnalyticsConstants.popup_book_buy
                                                ,map);
                                            if(item.dataType == 'Course') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>
                                                    DeliveryDetailScreen('Course', item.course![0].id.toString(),
                                                        item.course![0].title.toString(), item.course![0].salePrice.toString(),
                                                        upsellBookList: item.course![0].upsellBook??[],
                                                        pre_booktype: item.course![0].status,
                                                        preBookDetail:item.course![0].preBookDetail
                                                    )
                                                ),
                                              );
                                            } else {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PlaceOrderScreen(item.book![0])
                                                  )
                                              );
                                            }
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(AppColors.red),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      side: BorderSide(color: AppColors.red)
                                                  )
                                              )
                                          ),
                                          child: Text('Buy Now', style: TextStyle(color: AppColors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:dataList.map((image) {
                          int index = dataList.indexOf(image);
                          return Container(
                            width: 10,
                            height: 10,
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color(0xFF0000000)
                                    : Color(0xFFFFFFFF)),
                          );
                        },
                      ).toList(), // this was the part the I had to add
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

