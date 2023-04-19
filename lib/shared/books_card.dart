import 'dart:convert';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/dynamicLink/firebase_dynamic_link.dart';
import 'package:exampur_mobile/shared/place_order_screen.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'package:exampur_mobile/data/model/e_book_model.dart';
import '../SharePref/shared_pref.dart';
import '../data/model/CourseBookRatingModel.dart';
import '../data/model/course_book_popup_model.dart';
import '../presentation/my_courses/TeacherSubjectView/DownloadPdfView.dart';
import '../utils/analytics_constants.dart';

class BooksCard extends StatefulWidget {
  final BookEbook  books;
  const BooksCard(this.books) : super();

  @override
  _BooksCardState createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
  CourseBookRatingModel? contentCourseId;
  bool isShowRating = false;

  void getCheckRatingList(){
    AppConstants.coursebookRatingList.forEach((ratingModel) {
      if (ratingModel.id == widget.books.id) {
        isShowRating = true;
        setState((){});
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCheckRatingList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow:   const [
          BoxShadow(
            color: AppColors.grey,
            offset: Offset(
              0.0,
              0.0,
            ),
            blurRadius: 1.79,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Column(
        children: [
           InkWell(
              onTap: () async {
                var map = {
                  'Page_Name':'Books List',
                  'Mobile_Number':AppConstants.userMobile,
                  'Language':AppConstants.langCode,
                  'User_ID':AppConstants.userMobile,
                  'Book_Name':widget.books.title.toString()
                };
                AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Share_Books,map);
                String data = json.encode(widget.books);
                String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink('books', data, '0', widget.books.id.toString());
                String shareContent =
                    'Get "' + widget.books.title.toString() + '" Book from Exampur Now.\n' +
                        dynamicUrl;
                Share.share(shareContent);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12,top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      Images.share,
                      height: 15,
                      width: 20,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      getTranslated(context, LangString.share)!,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          widget.books.bannerPath.toString().contains('http') ?
          AppConstants.image(widget.books.bannerPath.toString()) :
          AppConstants.image(AppConstants.BANNER_BASE + widget.books.bannerPath.toString()),
          SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
            child:Container(
              width: 200,
              padding: EdgeInsets.all(8),
            decoration: BoxDecoration( color: Colors.amber.shade50,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            ),
                child: Row(children: [
                  Text('4.8',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  RatingBar.builder(
                    itemSize: 18,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],)
          )),
          Text(
            widget.books.title.toString(),
            softWrap: true,
            style: TextStyle(fontSize: 18),
          ),
          Text(
          '( MRP : ₹ ' +  widget.books.regularPrice.toString()+ ', Selling Price : ₹ ' +widget.books.salePrice.toString()+' )',
            softWrap: true,
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 10),

          // CustomElevatedButton(
          //   onPressed: () {
          //     var map = {
          //       'Page_Name':'Books List',
          //       'Mobile_Number':AppConstants.userMobile,
          //       'Language':AppConstants.langCode,
          //       'User_ID':AppConstants.userMobile,
          //       'Book_Name':widget.books.title.toString()
          //     };
          //     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Buy_Book,map);
          //     Navigator.push(context,
          //         MaterialPageRoute(
          //            // settings: RouteSettings(name: 'BookListing'),
          //             builder: (context) => PlaceOrderScreen(widget.books)
          //         )
          //     );
          //   },
          //   text: getTranslated(context, LangString.buy)!,
          // ),

          // InkWell(
          //   onTap: (){
          //         var map = {
          //           'Page_Name':'Books List',
          //           'Mobile_Number':AppConstants.userMobile,
          //           'Language':AppConstants.langCode,
          //           'User_ID':AppConstants.userMobile,
          //           'Book_Name':widget.books.title.toString()
          //         };
          //         AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Buy_Book,map);
          //         Navigator.push(context,
          //             MaterialPageRoute(
          //                // settings: RouteSettings(name: 'BookListing'),
          //                 builder: (context) => PlaceOrderScreen(widget.books)
          //             )
          //         );
          //   },
          //  child: Container(
          //    height: 55,
          //    decoration: BoxDecoration(color: Theme.of(context).primaryColor,
          //      borderRadius:BorderRadius.circular(10.0),
          //    ),
          //    alignment: Alignment.center,
          //    child: Text(getTranslated(context, LangString.buy)!,style: TextStyle(fontSize: 18, color: Colors.white),),
          //  ),
          // ),

          Row(
            children: [
              widget.books.demoBookUrl.toString().trim().isEmpty ? SizedBox() :
              InkWell(
                onTap: () async {

                  await SharedPref.getSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST).then((value) async {
                    if(value == 'null') {
                      List<CourseBookPopupModel> courseBookPopupList = [];
                      courseBookPopupList.insert(0,CourseBookPopupModel(dataType: 'Book', uniqueId: widget.books.id.toString(), book: [widget.books]));
                      await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST, CourseBookPopupModel.encode(courseBookPopupList));
                      await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_72HRS, AppConstants.timeRound());
                    } else {
                      List<CourseBookPopupModel> courseBookPopupList = CourseBookPopupModel.decode(value);
                      courseBookPopupList.removeWhere((m) => m.uniqueId == widget.books.id.toString());
                      courseBookPopupList.insert(0,CourseBookPopupModel(dataType: 'Book', uniqueId: widget.books.id.toString(), book: [widget.books]));
                      if(courseBookPopupList.length > 5) {
                        courseBookPopupList.removeLast();
                      }
                      await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST, CourseBookPopupModel.encode(courseBookPopupList));
                    }
                  });

                  AnalyticsConstants.moengagePlugin.setUserAttribute('Sample_Book',widget.books.title);
                  var map = {
                    'Page_Name':'Books List',
                    'Mobile_Number':AppConstants.userMobile,
                    'Language':AppConstants.langCode,
                    'User_ID':AppConstants.userMobile,
                    'pdf_url':widget.books.demoBookUrl.toString()
                  };
                  AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Demo_Book_pdf, map);
                  AppConstants.goTo(context, DownloadViewPdf(widget.books.title.toString(), widget.books.demoBookUrl.toString()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.amber),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 5),
                  alignment: Alignment.center,
                  child: Text('Sample PDF'),
                ),
              ),
              Expanded(
                  child: InkWell(
                    onTap: () async {

                      await SharedPref.getSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST).then((value) async {
                        if(value == 'null') {
                          List<CourseBookPopupModel> courseBookPopupList = [];
                          courseBookPopupList.insert(0,CourseBookPopupModel(dataType: 'Book', uniqueId: widget.books.id.toString(), book: [widget.books]));
                          await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST, CourseBookPopupModel.encode(courseBookPopupList));
                          await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_72HRS, AppConstants.timeRound());
                        } else {
                          List<CourseBookPopupModel> courseBookPopupList = CourseBookPopupModel.decode(value);
                          courseBookPopupList.removeWhere((m) => m.uniqueId == widget.books.id.toString());
                          courseBookPopupList.insert(0,CourseBookPopupModel(dataType: 'Book', uniqueId: widget.books.id.toString(), book: [widget.books]));
                          if(courseBookPopupList.length > 3) {
                            courseBookPopupList.removeLast();
                          }
                          await SharedPref.saveSharedPref(SharedPref.COURSE_BOOK_POPUP_LIST, CourseBookPopupModel.encode(courseBookPopupList));
                        }
                      });

                      AnalyticsConstants.moengagePlugin.setUserAttribute('Buy_Book',widget.books.title);
                      var map = {
                        'Page_Name':'Books List',
                        'Mobile_Number':AppConstants.userMobile,
                        'Language':AppConstants.langCode,
                        'User_ID':AppConstants.userMobile,
                        'Book_Name':widget.books.title.toString()
                      };
                      AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Buy_Book,map);
                      Navigator.push(context,
                          MaterialPageRoute(
                            // settings: RouteSettings(name: 'BookListing'),
                              builder: (context) => PlaceOrderScreen(widget.books)
                          )
                      );
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                        borderRadius:BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(getTranslated(context, LangString.buy)!,style: TextStyle(fontSize: 18, color: Colors.white),),
                    ),
                  ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),

          // InkWell(
          //   onTap: () async {
          //     var map = {
          //       'Page_Name':'Books List',
          //       'Mobile_Number':AppConstants.userMobile,
          //       'Language':AppConstants.langCode,
          //       'User_ID':AppConstants.userMobile,
          //       'Book_Name':widget.books.title.toString()
          //     };
          //     AnalyticsConstants.trackEventMoEngage(AnalyticsConstants.Click_Share_Books,map);
          //     String data = json.encode(widget.books);
          //     String dynamicUrl = await FirebaseDynamicLinkService.createDynamicLink('books', data, '0', widget.books.id.toString());
          //     String shareContent =
          //         'Get "' + widget.books.title.toString() + '" Book from Exampur Now.\n' +
          //             dynamicUrl;
          //     Share.share(shareContent);
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset(
          //         Images.share,
          //         height: 15,
          //         width: 20,
          //       ),
          //       SizedBox(
          //         width: 8,
          //       ),
          //       Text(
          //         getTranslated(context, LangString.share)!,
          //         style: TextStyle(
          //           color: AppColors.black,
          //           fontSize: 16,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
