import 'package:exampur_mobile/data/model/test_series_model.dart';
import 'package:exampur_mobile/provider/TestSeriesProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'aatempttestseries.dart';

class TestSeriesListing extends StatefulWidget {

  @override
  TestSeriesListingState createState() => TestSeriesListingState();
}

class TestSeriesListingState extends State<TestSeriesListing> {
  List<Testsery> liveTestSeriesList = [];
  var scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    getLists();
    super.initState();
  }

  Future<void> getLists() async {
    isLoading = true;
    liveTestSeriesList = (await Provider.of<TestSeriesProvider>(context, listen: false).getLiveTestSeriesList(context))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        liveTestSeriesList.length==0 ? AppConstants.noDataFound() :
        SingleChildScrollView(
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
                        color: index % 2 == 0?  Theme.of(context).backgroundColor : AppColors.transparent,
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
                                          SizedBox(height: 5),
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
        )
    );
  }
}
