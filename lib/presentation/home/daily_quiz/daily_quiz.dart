import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/DailyQuizProvider.dart';
import 'package:exampur_mobile/shared/custom_web_view.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'package:exampur_mobile/data/model/daily_quiz_model.dart';
import 'package:provider/provider.dart';

class DailyQuiz extends StatefulWidget {
  const DailyQuiz() : super();

  @override
  _DailyQuizState createState() => _DailyQuizState();
}

class _DailyQuizState extends State<DailyQuiz> {
  List<Data> dailyQuizList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  bool isBottomLoading = false;
  int page = 0;
  bool isData = true;
  int isLoad = 0;

  // @override
  // void initState() {
  //   getLists();
  //   super.initState();
  // }
  //
  // Future<void> getLists() async {
  //   isLoading = true;
  //   dailyQuizList = (await Provider.of<DailyQuizProvider>(context, listen: false).getDailyQuizList(context))!;
  //   isLoading = false;
  //   setState(() {});
  // }





  Future<void> getDailyQuizList(pageNo) async {
    List<Data> list = (await Provider.of<DailyQuizProvider>(context, listen: false).getDailyQuizList(context,pageNo))!;
    if(list.length > 0) {
      isData = true;
      dailyQuizList = dailyQuizList + list;
    } else {
      isData = false;
    }
    isBottomLoading = false;
    isLoad++;
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(pagination);
    isLoad = 0;
    getDailyQuizList(page);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 10;
        }
        isBottomLoading = true;
        getDailyQuizList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
        body: isLoad==0 ? Center(child: LoadingIndicator(context)) :
        dailyQuizList.length==0 ? AppConstants.noDataFound() :
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(getTranslated(context, LangString.dailyQuiz)!,style: TextStyle(fontSize: 30),),
              ),
              ListView.builder(
                  itemCount: dailyQuizList.length,
                 shrinkWrap: true,
                  controller: scrollController,
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

                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
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
                                            dailyQuizList[index].quizTitle.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomRoundButton(onPressed: ()async{
                                                await SharedPref.getSharedPref(SharedPref.TOKEN).then((value) {
                                                  String url = API.dailyQuiz_web_URL
                                                      .replaceAll('QUIZ_ID', dailyQuizList[index].id.toString())
                                                      .replaceAll('AUTH_TOKEN', value);
                                                  AppConstants.printLog('url>> $url');
                                                  AppConstants.goTo(context, CustomWebView(url));
                                                });},text: getTranslated(context, LangString.attemptQuiz)!,),

                                              Row(
                                                children: [
                                                  Icon(Icons.timer,size: 15,),
                                                  SizedBox(width: 5,),
                                                  Text(dailyQuizList[index].quizDuration.toString()),
                                                ],
                                              )
                                            ],
                                          ),
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
        ),
      bottomNavigationBar:isBottomLoading ? Container(
        // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
      SizedBox(),
    );
  }
}
