import 'package:exampur_mobile/data/model/offline_batch_center_courses_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/Offline_batchesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'offlinebatchesview.dart';

class OfflineBatchesExam extends StatefulWidget {
  final String id;

  const OfflineBatchesExam(this.id);

  @override
  _OfflineBatchesExamState createState() => _OfflineBatchesExamState();
}

class _OfflineBatchesExamState extends State<OfflineBatchesExam> {
  OfflineBatchCenterCoursesModel centerCoursesModel =
      OfflineBatchCenterCoursesModel();

  @override
  void initState() {
    callProvider();
  }

  void callProvider() async {
    centerCoursesModel =
        (await Provider.of<OfflinebatchesProvider>(context, listen: false)
            .getOfflineBatchCenterCoursesData(context, widget.id))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(AppConstants.BANNER_BASE);
    return Scaffold(
        appBar: CustomAppBar(),
        body: centerCoursesModel.data == null ||
                centerCoursesModel.data!.length == 0
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Offline Batches',
                        style: CustomTextStyle.headingBold(context),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Center: ' +
                          centerCoursesModel.centerDetails!.name.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Phone: ' +
                          centerCoursesModel.centerDetails!.phone.toString()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text('Address: ' +
                          centerCoursesModel.centerDetails!.address.toString()),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                        itemCount: centerCoursesModel.data!.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      0.0,
                                      0.0,
                                    ),
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                color: Theme.of(context).backgroundColor,
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        width:
                                        MediaQuery.of(context).size.width * 0.25,
                                        child: FadeInImage(
                                          image: NetworkImage(AppConstants.BANNER_BASE + centerCoursesModel.data![index].logoPath.toString()),
                                          placeholder:
                                          AssetImage(Images.exampur_logo),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(Images.exampur_logo);
                                          },
                                        )),
                                    const SizedBox(
                                      width: 10,
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
                                              centerCoursesModel.data![index].title.toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OfflineBatchesVideo(centerCoursesModel.data![index].id.toString())
                                                        )
                                                    );
                                                  },
                                                  child: Container(
                                                      width: 100,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                          border: Border.all(
                                                              color:
                                                              Color(0xFF060929)),
                                                          color: Color(0xFF060929)),
                                                      child: const Center(
                                                          child: Text("View Details",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white)))),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                              ] ,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Image.asset(
                                                    Images.share,
                                                    height: 18,
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 5
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Text("Share",
                                                        style:
                                                        TextStyle(fontSize: 13)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ));
  }
}
