import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/offlice_batch_center_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Offline_batchesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'offlinebatchesexam.dart';
import 'package:provider/provider.dart';

class OfflineCourse extends StatefulWidget {
  const OfflineCourse({Key? key}) : super(key: key);

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  List<CenterListModel> list = [];

  @override
  void initState() {
    callProvider();
  }

  void callProvider() async {
    list = (await Provider.of<OfflinebatchesProvider>(context, listen: false).getOfflineBatchCenterList(context))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: list.length == 0
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,top: 20),
                      child: Text(
                        getTranslated(context, 'offline batches')!,
                        style: CustomTextStyle.headingBold(context),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.FONT_SIZE_SMALL,
                    ),
                    ListView.builder(
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
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
                                    color: Colors.grey,
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
                                                OfflineBatchesExam(list[index].id.toString())));
                                  },
                                  leading: Image.asset(
                                    Images.exampur_logo,
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(
                                    list[index].name.toString(),
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
              ));
  }
}

class ChooseOfflineModel {
  late String place;
  String image;

  ChooseOfflineModel(this.place, this.image);
}
