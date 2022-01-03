import 'package:exampur_mobile/data/model/OfflineBatchesModel.dart';
import 'package:exampur_mobile/data/model/on2one_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

import 'offlinebatchesview.dart';

class OfflineBatchesExam extends StatefulWidget {
  final List<OfflineBatchesModel> list;
  final int index;

  const OfflineBatchesExam(this.list, this.index);

  @override
  _OfflineBatchesExamState createState() => _OfflineBatchesExamState();
}

class _OfflineBatchesExamState extends State<OfflineBatchesExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
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
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnlineBatchesVideo(widget.list[widget.index].videoPath.toString(),
                                widget.list[widget.index].title.toString())));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.25,
                            //flex: 1,
                            child: FadeInImage(
                              image: NetworkImage("widget.instance.image"),
                              placeholder:
                                  AssetImage("assets/images/no_image.jpg"),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                 widget.list[widget.index].imagePath.toString(),
                                );
                              },
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  widget.list[widget.index].title.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  widget.list[widget.index].teacher.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 30,
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xFF060929)),
                                            color: Color(0xFF060929)),
                                        child: const Center(
                                            child: Text("View Details",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.white)))),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(Images.share,height: 18,width: 15,),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Share",
                                          style: TextStyle(fontSize: 13))
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
