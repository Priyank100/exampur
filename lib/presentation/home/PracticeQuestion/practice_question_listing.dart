import 'package:exampur_mobile/data/model/practice_question_listing_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_round_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/provider/PracticeQuestionProvider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PracticeQuestionListing extends StatefulWidget {
  final name;
  final categoryname;
  final catId;
  final subCatId;
  const PracticeQuestionListing(this.name,this.categoryname,this.catId,this.subCatId) : super();

  @override
  State<PracticeQuestionListing> createState() => _PracticeQuestionListingState();
}

class _PracticeQuestionListingState extends State<PracticeQuestionListing> {
  PracticeQuestionListingModel? practiceQuestionListingModel;
  bool isLoading = true;
  bool isBottomLoading = false;
  var scrollController = ScrollController();
  bool showDescription = false;
  List<MyRadio> _radioValue = [];

  @override
  void initState() {
    scrollController.addListener(pagination);
    getQuestionsData(API.practiceQuestionViaCatAndSubCatUrl + widget.catId + '/'+ widget.subCatId);
    super.initState();
  }

  Future<void> getQuestionsData(String url) async {
    practiceQuestionListingModel = null;
    _radioValue.clear();
    isLoading = true;
    practiceQuestionListingModel = (await Provider.of<PracticeQuestionProvider>(context, listen: false).getPracticeQuestionListing(context, url))!;
    if(practiceQuestionListingModel != null && practiceQuestionListingModel!.count! > 0) {
      for (int i = 0; i < practiceQuestionListingModel!.questions!.length; i++) {
        _radioValue.add(MyRadio(false, -1));
      }
    }
    isLoading = false;
    isBottomLoading = false;
    setState(() {});
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        isBottomLoading = true;
      });
    } else {
      setState(() {
        isBottomLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
      practiceQuestionListingModel == null || practiceQuestionListingModel!.count == 0 ? AppConstants.noDataFound() :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.name+'->'+widget.categoryname,style: TextStyle(fontSize: 15),),
        ),
          Expanded(child: dataList()),

      ],),
        bottomNavigationBar: isBottomLoading ? Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                practiceQuestionListingModel!.previous.toString() == 'null' ? SizedBox() :
                MaterialButton(
                  color: AppColors.amber,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      getQuestionsData(practiceQuestionListingModel!.previous.toString());
                    });
                  },
                  child: Text('<< Previous',style: TextStyle(color: AppColors.white),),
                ),
                practiceQuestionListingModel!.next.toString() == 'null' ? SizedBox() :
                MaterialButton(
                  color: AppColors.amber,
                  onPressed: () {
                    setState(() {
                      getQuestionsData(practiceQuestionListingModel!.next.toString());
                      isLoading = true;
                    });
                  },
                  child: Text('Next >>',style: TextStyle(color: AppColors.white)),
                )
              ]),
        ) : SizedBox()
    );
  }
  Widget dataList() {
    return ListView.builder(
      controller: scrollController,
        itemCount: practiceQuestionListingModel!.questions!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return itemList(index);
        });
  }
  Widget itemList(index) {
    return Container(
      margin: EdgeInsets.all(5),
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
        Text('Question '+(index+1).toString() +':',style: TextStyle(color: AppColors.amber),),
        Html(
            data: AppConstants.langCode == 'hi' ?
            practiceQuestionListingModel!.questions![index].hindiQuestion.toString().replaceAll(RegExp(r"<[^>]*>",caseSensitive: true), ' ') :
            practiceQuestionListingModel!.questions![index].englishQuestion.toString().replaceAll(RegExp(r"<[^>]*>",caseSensitive: true), ' '),
            style: {
              'body': Style(
                  maxLines: 3,
                  textOverflow: TextOverflow.ellipsis,
                  fontSize: const FontSize(14)
              )}
        ),

       practiceQuestionListingModel!.questions![index].engOption1.toString().isEmpty ? SizedBox() :
        Container(
          color: _radioValue[index].val == 0 ? AppColors.green : AppColors.transparent,
          child: RadioListTile(
            title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption1.toString(): practiceQuestionListingModel!.questions![index].engOption1.toString(),style: TextStyle(fontSize: 12)),
            value: 0,
            groupValue: _radioValue[index].val,
            onChanged: (value) {
              setState(() {
                _radioValue[index].val = value;
                _radioValue[index].isSelected = true;
              });
            },
            selected: _radioValue[index].val == 0,
            activeColor: AppColors.white,
          ),
        ),
       practiceQuestionListingModel!.questions![index].engOption2.toString().isEmpty ? SizedBox() :
        Container(
          color: _radioValue[index].val == 1 ? AppColors.green : AppColors.transparent,
          child: RadioListTile(
            title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption2.toString(): practiceQuestionListingModel!.questions![index].engOption2.toString(),style: TextStyle(fontSize: 12)),
            value: 1,
            groupValue: _radioValue[index].val,
            onChanged: (value) {
              setState(() {
                _radioValue[index].val = value;
                _radioValue[index].isSelected = true;
              });
            },
            selected: _radioValue[index].val == 1,
            activeColor: AppColors.white,
          ),
        ),
        practiceQuestionListingModel!.questions![index].engOption3.toString().isEmpty ? SizedBox() :
        Container(
          color: _radioValue[index].val == 2 ? AppColors.green : AppColors.transparent,
          child: RadioListTile(
            title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption3.toString(): practiceQuestionListingModel!.questions![index].engOption3.toString(),style: TextStyle(fontSize: 12)),
            value: 2,
            groupValue: _radioValue[index].val,
            onChanged: (value) {
              setState(() {
                _radioValue[index].val = value;
                _radioValue[index].isSelected = true;
              });
              },
            selected: _radioValue[index].val == 2,
            activeColor: AppColors.white,
          ),
        ),
        practiceQuestionListingModel!.questions![index].engOption4.toString().isEmpty ? SizedBox() :
        Container(
          color: _radioValue[index].val == 3 ? AppColors.green : AppColors.transparent,
          child: RadioListTile(
            title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption4.toString(): practiceQuestionListingModel!.questions![index].engOption4.toString(),style: TextStyle(fontSize: 12)),
            value: 3,
            groupValue: _radioValue[index].val,
            onChanged: (value) {
              setState(() {
                _radioValue[index].val = value;
                _radioValue[index].isSelected = true;
              });
            },
            selected: _radioValue[index].val == 3,
            activeColor: AppColors.white,
          ),
        ),
        practiceQuestionListingModel!.questions![index].engOption5.toString().isEmpty ? SizedBox() :
        Container(
          color: _radioValue[index].val == 4 ? AppColors.green : AppColors.transparent,
          child: RadioListTile(
            title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption5.toString(): practiceQuestionListingModel!.questions![index].engOption5.toString(),style: TextStyle(fontSize: 12)),
            value: 4,
            groupValue: _radioValue[index].val,
            onChanged: (value) {
              setState(() {
                _radioValue[index].val = value;
                _radioValue[index].isSelected = true;
              });
            },
            selected: _radioValue[index].val == 4,
            activeColor: AppColors.white,
          ),
        ),
        Text('Correct Answer : '+practiceQuestionListingModel!.questions![index].correctAnswer.toString()),
        SizedBox(height: 5,),
        CustomRoundButton(onPressed: (){
          setState(() {
            showDescription = !showDescription ;
          });
        },text: showDescription ? 'Hide Description' : 'Show Description',),
        SizedBox(height: 5,),
        showDescription ? Html(
            data: AppConstants.langCode == 'hi' ?
            practiceQuestionListingModel!.questions![index].solutionHindi.toString().replaceAll(RegExp(r"<[^>]*>"), ' ') :
            practiceQuestionListingModel!.questions![index].solutionEng.toString().replaceAll(RegExp(r"<[^>]*>"), ' '),
        ) : SizedBox(),
      ],
      ),
    );
  }

}

class MyRadio {
  bool isSelected;
  var val;
  MyRadio(this.isSelected, this.val);
}
