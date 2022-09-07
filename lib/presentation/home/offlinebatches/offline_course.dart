import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/offlice_batch_center_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/Offline_batchesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:flutter/material.dart';
import 'offlinebatchesexam.dart';
import 'package:provider/provider.dart';

class OfflineCourse extends StatefulWidget {
  const OfflineCourse({Key? key}) : super(key: key);

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  List<CenterListModel> centerList = [];
  var scrollController = ScrollController();
  bool isLoading = false;
  int page = 0;
  bool isData = true;

  @override
  void initState() {
    scrollController.addListener(pagination);
    callProvider(page);
    super.initState();
  }

  void callProvider(pageNo) async {
    List<CenterListModel> list = (await Provider.of<OfflinebatchesProvider>(context, listen: false).getOfflineBatchCenterList(context, pageNo))!;
    if(list.length > 0) {
      isData = true;
      centerList = centerList + list;
    } else {
      isData = false;
    }
    isLoading = false;
    setState(() {});
  }

  void pagination() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        if(isData) {
          page += 10;
        }
        isLoading = true;
        callProvider(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: centerList.length == 0
            ? Center(child: LoadingIndicator(context))
            : SingleChildScrollView(
          controller: scrollController,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 20),
                      child: Text(
                        getTranslated(context, LangString.offlineBatches)!,
                        style: CustomTextStyle.headingBold(context),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.FONT_SIZE_SMALL,
                    ),
                    ListView.builder(
                        itemCount: centerList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.grey,
                                    offset: Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OfflineBatchesExam(centerList[index].id.toString())));
                                  },
                                  leading: Image.asset(
                                    Images.exampur_logo,
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    centerList[index].name.toString(),
                                    style: CustomTextStyle.headingBold(context),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    size: 18,
                                    color: Colors.black,
                                  )),
                            ),
                          );
                        })
                  ],
                ),
              ),
        bottomNavigationBar: isLoading ? Container(
    padding: EdgeInsets.all(8),
    height:40,
    width: 40,
    child: Center(child: CircularProgressIndicator())) :
    SizedBox(),
    );
  }
}

class ChooseOfflineModel {
  late String place;
  String image;

  ChooseOfflineModel(this.place, this.image);
}
