import 'dart:io' show Platform;
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/live_test_series_model.dart';
import 'package:exampur_mobile/data/model/paid_course_model.dart';
import 'package:exampur_mobile/provider/TestSeriesProvider.dart';
import 'package:exampur_mobile/shared/ebooksContainer.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'aatempttestseries.dart';

class TestSeriesCardView extends StatefulWidget {
  @override
  _TestSeriesCardViewState createState() => _TestSeriesCardViewState();
}

class _TestSeriesCardViewState extends State<TestSeriesCardView> {
  List<Testsery> liveTestSeriesList = [];
 // List<Courses> freeCourseList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  int isLoad = 0;

  int page = 0;
  bool isData = true;

  @override
  void initState() {
   // scrollController.addListener(pagination);
    isLoad = 0;
    getLists();
    super.initState();
  }

  Future<void> getLists() async {
   // if(widget.courseType == 1) {
    liveTestSeriesList= (await Provider.of<TestSeriesProvider>(context, listen: false).getTestSeriesList(context))!;
      // if(list.length > 0) {
      //   isData = true;
      //   paidCourseList = paidCourseList + list;
      // } else {
      //   isData = false;
      // }
      // isLoading = false;
    // } else {
    //   List<Courses> list = (await Provider.of<PaidCoursesProvider>(context, listen: false).getFreeCourseList(context, widget.tabId, pageNo))!;
    //   if(list.length > 0) {
    //     isData = true;
    //     freeCourseList = freeCourseList + list;
    //   } else {
    //     isData = false;
    //   }
    //   isLoading = false;
    // }
    isLoad++;
    setState(() {});
  }

  // void pagination() {
  //   if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
  //     setState(() {
  //       if(isData) {
  //         page += 1;
  //       }
  //       isLoading = true;
  //       getLists(page);
  //       AppConstants.printLog('page>> ' + page.toString());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:isLoad==0 ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        liveTestSeriesList.length==0 ? AppConstants.noDataFound() : SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: liveTestSeriesList.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        color: index % 2 == 0?  Theme.of(context).backgroundColor
                            : AppColors.transparent ,
                        child: Material(
                          color: AppColors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AttemptSeries()));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      //flex: 1,
                                      // child: FadeInImage(
                                      //   image: NetworkImage(a[index].image),
                                      //   placeholder: AssetImage(
                                      //       Images.noimage),
                                      //   imageErrorBuilder:
                                      //       (context, error, stackTrace) {
                                      //     return Image.asset(
                                      //       a[index].image,
                                      //       height: 40,
                                      //       width: 60,
                                      //     );
                                      //   },
                                      // )
                                    child:Image.asset(Images.exampur_logo, height: 40, width: 60),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            liveTestSeriesList[index].title.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Row(
                                          //   children: [
                                          //    Image.asset(Images.share,height: 15,width: 20,) ,
                                          //     SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     Text(getTranslated(context, StringConstant.share)!,
                                          //         style: TextStyle(fontSize: 13))
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

class ChooseTestSeriesModel {
  late String name, course;
  String image;

  ChooseTestSeriesModel(this.name, this.course, this.image);
}
