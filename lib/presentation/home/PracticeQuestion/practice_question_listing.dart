import 'package:exampur_mobile/data/model/practice_question_listing_model.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PracticeQuestionListing extends StatefulWidget {
  const PracticeQuestionListing({Key? key}) : super(key: key);

  @override
  State<PracticeQuestionListing> createState() => _PracticeQuestionListingState();
}

class _PracticeQuestionListingState extends State<PracticeQuestionListing> {
  PracticeQuestionListingModel? practiceQuestionListingModel;
  bool isBottomLoading = false;
  var scrollController = ScrollController();

  // @override
  // void initState() {
  //   scrollController.addListener(pagination);
  //   getTab();
  //   super.initState();
  // }
  //
  // Future<void> getTab() async {
  //   practiceQuestionListingModel = null;
  //   isLoading = true;
  //   currentAffairsListModel = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewList(context, url, widget.tabId))!;
  //   isLoading = false;
  //   isBottomLoading = false;
  //   setState(() {});
  // }
  //
  // void pagination() {
  //   if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
  //     setState(() {
  //       isBottomLoading = true;
  //     });
  //   } else {
  //     setState(() {
  //       isBottomLoading = false;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('text',style: TextStyle(fontSize: 15),),
        ),
          Expanded(child: dataList())
      ],),
    );
  }
  Widget dataList() {
    return ListView.builder(
        itemCount: 12,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return itemList(index);
        });
  }
  Widget itemList(index) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey,
            offset: Offset(0.0, 0.0),
            blurRadius: 1.0,
            spreadRadius: 0.0,
          ),
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Question '+(index+1).toString() +':'),
        Text('Title',style: TextStyle(fontSize: 15),),
        ListTile(
    //       leading: Radio(
    // value: '',
    // // value: BestTutorSite.tutorialandexample,
    // groupValue: 'Q'+index.toString(),
    // onChanged: (value) {
    // setState(() {
    // _site = value;
    // });
    // },
          title: const Text('Question'),

        )


      ],
      ),
    );}
}
