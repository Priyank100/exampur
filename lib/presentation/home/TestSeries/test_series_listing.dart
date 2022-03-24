import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/test_series_model.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/TestSeriesProvider.dart';
import 'package:exampur_mobile/shared/custom_web_view.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attempt_test_series.dart';

class TestSeriesListing extends StatefulWidget {
  final String testSeriesType;
  const TestSeriesListing(this.testSeriesType) : super();

  @override
  TestSeriesListingState createState() => TestSeriesListingState();
}

class TestSeriesListingState extends State<TestSeriesListing> {
  List<Data> testSeriesList = [];
  var scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    getLists();

    super.initState();
  }

  Future<void> getLists() async {
    isLoading = true;

    switch(widget.testSeriesType) {
      case 'LIVE':
        testSeriesList = (await Provider.of<TestSeriesProvider>(context, listen: false).getLiveTestSeriesList(context))!;
        break;
      case 'MY':
        testSeriesList = (await Provider.of<TestSeriesProvider>(context, listen: false).getMyTestSeriesList(context))!;
        break;
      case 'ALL':
        testSeriesList = (await Provider.of<TestSeriesProvider>(context, listen: false).getAllTestSeriesList(context))!;
        break;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? Center(child:LoadingIndicator(context)) :
        testSeriesList.length==0 ? AppConstants.noDataFound() :
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: testSeriesList.length,
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
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            onTap: () async {
                              if(widget.testSeriesType == 'ALL') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttemptTestSeries(testSeriesList[index])));

                              } else {
                                await SharedPref.getSharedPref(SharedPrefConstants.TOKEN).then((value) {
                                  String url = API.testSeriesWeb_URL
                                      .replaceAll('TEST_SERIES_ID', testSeriesList[index].id.toString())
                                      .replaceAll('AUTH_TOKEN', value);
                                  AppConstants.printLog('url>> $url');
                                  AppConstants.goTo(context, CustomWebView(url));
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width * 0.25,
                                    child: AppConstants.image(AppConstants.BANNER_BASE + testSeriesList[index].image.toString(), width: 40.0, height: 60.0),
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
                                            testSeriesList[index].title.toString(),
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
