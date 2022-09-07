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
import 'package:flutter_tex/flutter_tex.dart';
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
  List<MyRadio> _radioValue = [];
  int count = 0;
  List<QueAnsModel> queAnsList = [];
  TeXViewRenderingEngine mathjax = TeXViewRenderingEngine.mathjax();
  bool isRender = false;

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

      for (int j = 0; j < practiceQuestionListingModel!.questions!.length; j++) {

        List<AnswerModel> ansEnList = [];
        List<AnswerModel> ansHiList = [];

        ansEnList.add(AnswerModel(practiceQuestionListingModel!.questions![j].engOption1.toString(), AppColors.white,));
        ansEnList.add(AnswerModel(practiceQuestionListingModel!.questions![j].engOption2.toString(), AppColors.white));
        ansEnList.add(AnswerModel(practiceQuestionListingModel!.questions![j].engOption3.toString(), AppColors.white));
        ansEnList.add(AnswerModel(practiceQuestionListingModel!.questions![j].engOption4.toString(), AppColors.white));
        if(practiceQuestionListingModel!.questions![j].engOption5.toString().isNotEmpty) {
          ansEnList.add(AnswerModel(practiceQuestionListingModel!.questions![j].engOption5.toString(), AppColors.white));
        }

        ansHiList.add(AnswerModel(practiceQuestionListingModel!.questions![j].hindiOption1.toString(), AppColors.white));
        ansHiList.add(AnswerModel(practiceQuestionListingModel!.questions![j].hindiOption2.toString(), AppColors.white));
        ansHiList.add(AnswerModel(practiceQuestionListingModel!.questions![j].hindiOption3.toString(), AppColors.white));
        ansHiList.add(AnswerModel(practiceQuestionListingModel!.questions![j].hindiOption4.toString(), AppColors.white));
        if(practiceQuestionListingModel!.questions![j].hindiOption5.toString().isNotEmpty) {
          ansHiList.add(AnswerModel(practiceQuestionListingModel!.questions![j].hindiOption5.toString(), AppColors.white));
        }

        queAnsList.add(QueAnsModel(
          practiceQuestionListingModel!.questions![j].englishQuestion.toString(),
          practiceQuestionListingModel!.questions![j].hindiQuestion.toString(),
          ansEnList,
          ansHiList,
          false,
          practiceQuestionListingModel!.questions![j].correctAnswer.toString(),
          practiceQuestionListingModel!.questions![j].solutionEng.toString(),
          practiceQuestionListingModel!.questions![j].solutionHindi.toString(),
          false
        ));
      }
    }

    // if(practiceQuestionListingModel != null && practiceQuestionListingModel!.count! > 0) {
    //   for (int i = 0; i < practiceQuestionListingModel!.questions!.length; i++) {
    //     _radioValue.add(MyRadio(false, false, -1));
    //   }
    // }
    isLoading = false;
    isBottomLoading = false;
    // isRender = true;
    // AppConstants.showLoaderDialog(context);
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
                child: Text(widget.name+'->'+widget.categoryname,
                  style: TextStyle(fontSize:AppConstants.langCode == 'hi' ? 18:15,
                      fontFamily: AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins',fontWeight: FontWeight.bold),),
              ),
                Expanded(child: dataList()),

            ]),
        bottomNavigationBar:
        practiceQuestionListingModel == null || practiceQuestionListingModel!.count == 0 ? SizedBox() :
        isBottomLoading ? Container(
          height: 40,
          width: 40,
          //padding: EdgeInsets.all(8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                practiceQuestionListingModel!.previous.toString() == 'null' ? SizedBox() :
                MaterialButton(
                  // color: AppColors.amber,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      count = count - practiceQuestionListingModel!.questions!.length;
                      getQuestionsData(practiceQuestionListingModel!.previous.toString());
                    });
                  },
                  child: Text('<< Previous',style: TextStyle(color: AppColors.black),),
                ),
                practiceQuestionListingModel!.next.toString() == 'null' ? SizedBox() :
                MaterialButton(
                  // color: AppColors.amber,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      count = count + practiceQuestionListingModel!.questions!.length;
                      getQuestionsData(practiceQuestionListingModel!.next.toString());
                    });
                  },
                  child: Text('Next >>',style: TextStyle(color: AppColors.black)),
                )
              ]),
        ) : SizedBox()
    );
  }

  Widget dataList() {
    return ListView.builder(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: queAnsList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return itemList(index);
        });
  }

  Widget itemList(index) {
    return Container(
      margin: EdgeInsets.all(12),
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
          Text('Question '+(count+index+1).toString() +':',style: TextStyle(color: AppColors.amber),),
          TeXView(
              renderingEngine:mathjax,
              // onRenderFinished: (_) {
              //   if(isRender) {
              //     isRender = false;
              //     Navigator.pop(context);
              //   }
              // },
              loadingWidgetBuilder: (context){
                return Center(child: CircularProgressIndicator(color: AppColors.grey300,),);
              },
              child: TeXViewColumn(children: [
                TeXViewDocument(
                    (
                        AppConstants.langCode == 'hi' ? queAnsList[index].questionHi.toString():queAnsList[index].questionEn.toString()),
                    style: TeXViewStyle(
                      //textAlign: TeXViewTextAlign.Center,
                        margin: TeXViewMargin.zeroAuto(),
                        padding: TeXViewPadding.only(left: 8)
                    )
                ),
        TeXViewGroup(children: [
  for(int x=0;x<queAnsList[index].ansEnList.length;x++)
    TeXViewGroupItem(id: x.toString(),
        child: TeXViewDocument(
            (x+1).toString()+". "+(AppConstants.langCode == 'hi' ?queAnsList[index].ansHiList[x].answer.toString():queAnsList[index].ansEnList[x].answer.toString()),
          style: TeXViewStyle(
            padding: TeXViewPadding.all(8),
            margin: TeXViewMargin.all(8),
            borderRadius: TeXViewBorderRadius.all(50),
            textAlign: TeXViewTextAlign.Left,
            elevation: 1,
            backgroundColor: queAnsList[index].ansEnList[x].color,
            border: TeXViewBorder.all(TeXViewBorderDecoration(borderColor: AppColors.amber,borderWidth: 1))
          )
    ))
],
    onTap: (id){
          if(!queAnsList[index].isSelected!) {
            queAnsList[index].isSelected = true;

            queAnsList[index].ansEnList[int.parse(queAnsList[index].correctanswer.toString())-1].color = Colors.green;
            if(queAnsList[index].correctanswer != (int.parse(id) + 1).toString()) {
              queAnsList[index].ansEnList[int.parse(id)].color = Colors.red;
            }
            setState(() {});
          }

    }
),

                queAnsList[index].isSelected! ?
                TeXViewInkWell(child: TeXViewDocument(
                    queAnsList[index].isShowDetail!? 'Hide Detail':'Show Detail',
    style: TeXViewStyle(
      contentColor: AppColors.white,
      textAlign: TeXViewTextAlign.Center,
    )
                ) , onTap: (id){

                  setState(() {
                    queAnsList[index].isShowDetail = !queAnsList[index].isShowDetail!;
                  });

    },id: index.toString(),

                    style: TeXViewStyle(
                      width: (MediaQuery.of(context).size.width/4).toInt(),
                        padding: TeXViewPadding.all(8),
                        margin: TeXViewMargin.all(8),
                        borderRadius: TeXViewBorderRadius.all(50),
                        textAlign: TeXViewTextAlign.Left,
                        elevation: 1,
                        backgroundColor: AppColors.grey,

                    )
                ) : TeXViewDocument(''),

              queAnsList[index].isShowDetail!?  TeXViewDocument(AppConstants.langCode == 'hi'?queAnsList[index].solutionHi!:queAnsList[index].solutionEn!,
    style: TeXViewStyle( padding: TeXViewPadding.all(8),
      margin: TeXViewMargin.all(8),)
                ):TeXViewDocument('')
              ])
              

          ),
          //     Html(
          //     style: {
          // 'body': Style(
          //     fontSize: AppConstants.langCode == 'hi' ? FontSize(18):FontSize(15),
          // fontWeight: FontWeight.bold,
          // fontFamily:  AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins'
          // ),},
          //         data: AppConstants.langCode == 'hi' ?
          //         practiceQuestionListingModel!.questions![index].hindiQuestion.toString().replaceAll(RegExp(r"<[^>]*>",caseSensitive: true), ' ') :
          //         practiceQuestionListingModel!.questions![index].englishQuestion.toString().replaceAll(RegExp(r"<[^>]*>",caseSensitive: true), ' '),
          //     ),
          /*practiceQuestionListingModel!.questions![index].engOption1.toString().isEmpty || practiceQuestionListingModel!.questions![index].engOption1 == null  ? SizedBox() :
          Container(
            color: _radioValue[index].val == 0 ? practiceQuestionListingModel!.questions![index].correctAnswer == 1 ? AppColors.green : AppColors.red : AppColors.transparent,
            child: RadioListTile(
              title:  TeXView(
                  renderingEngine:TeXViewRenderingEngine.mathjax(),
                  style:TeXViewStyle(
                    backgroundColor: _radioValue[index].val == 0 ? practiceQuestionListingModel!.questions![index].correctAnswer == 1 ? AppColors.green : AppColors.red : AppColors.transparent,
                  ) ,
                  child: TeXViewDocument(
                      (
                          AppConstants.langCode == 'hi' ? practiceQuestionListingModel!.questions![index].hindiOption1 :
                          practiceQuestionListingModel!.questions![index].engOption1)!,

                      style: TeXViewStyle(
                        //textAlign: TeXViewTextAlign.Center,
                        margin: TeXViewMargin.zeroAuto(),
                      )
                  )
              ),
              // Text(AppConstants.langCode == 'hi' ? practiceQuestionListingModel!.questions![index].hindiOption1.toString().trim() : practiceQuestionListingModel!.questions![index].engOption1.toString().trim(),
              //   style: TextStyle(fontSize:16,fontFamily: 'Noto Sans'
              //   ),),
              value: 0,
              groupValue: _radioValue[index].val,
              onChanged: (value) {
                if(!_radioValue[index].isSelected) {
                  setState(() {
                    _radioValue[index].val = value;
                    _radioValue[index].isSelected = true;
                  });
                }
              },
              selected: _radioValue[index].val == 0,
              activeColor: AppColors.white,
            ),
          ),
          practiceQuestionListingModel!.questions![index].engOption2.toString().isEmpty || practiceQuestionListingModel!.questions![index].engOption2 == null ? SizedBox() :
          Container(
            color: _radioValue[index].val == 1 ? practiceQuestionListingModel!.questions![index].correctAnswer == 2 ? AppColors.green : AppColors.red : AppColors.transparent,
            child: RadioListTile(
              title:  TeXView(
                  renderingEngine:TeXViewRenderingEngine.mathjax(),
                  style:TeXViewStyle(
                    backgroundColor: _radioValue[index].val == 1 ? practiceQuestionListingModel!.questions![index].correctAnswer == 2 ? AppColors.green : AppColors.red : AppColors.transparent,
                  ) ,
                  child: TeXViewDocument(
                      (
                          AppConstants.langCode == 'hi' ? practiceQuestionListingModel!.questions![index].hindiOption2 :
                          practiceQuestionListingModel!.questions![index].engOption2)!,

                      style: TeXViewStyle(
                        //textAlign: TeXViewTextAlign.Center,
                        margin: TeXViewMargin.zeroAuto(),
                      )
                  )
              ),
              // Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption2.toString().trim(): practiceQuestionListingModel!.questions![index].engOption2.toString().trim(),
              //     style: TextStyle(fontSize:16,fontFamily: 'Noto Sans')),
              value: 1,
              groupValue: _radioValue[index].val,
              onChanged: (value) {
                if(!_radioValue[index].isSelected) {
                  setState(() {
                    _radioValue[index].val = value;
                    _radioValue[index].isSelected = true;
                  });
                }
              },
              selected: _radioValue[index].val == 1,
              activeColor: AppColors.white,
            ),
          ),
          practiceQuestionListingModel!.questions![index].engOption3.toString().isEmpty || practiceQuestionListingModel!.questions![index].engOption3 == null ? SizedBox() :
          Container(
            color: _radioValue[index].val == 2 ? practiceQuestionListingModel!.questions![index].correctAnswer == 3 ? AppColors.green : AppColors.red : AppColors.transparent,
            child: RadioListTile(
              title:TeXView(
                  renderingEngine:TeXViewRenderingEngine.mathjax(),
                  style:TeXViewStyle(
                    backgroundColor: _radioValue[index].val == 2 ? practiceQuestionListingModel!.questions![index].correctAnswer == 3 ? AppColors.green : AppColors.red : AppColors.transparent,
                  ) ,
                  child: TeXViewDocument(
                      (
                          AppConstants.langCode == 'hi' ? practiceQuestionListingModel!.questions![index].hindiOption3 :
                          practiceQuestionListingModel!.questions![index].engOption3)!,

                      style: TeXViewStyle(
                        //textAlign: TeXViewTextAlign.Center,
                        margin: TeXViewMargin.zeroAuto(),

                      )
                  )
              ),
              // Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption3.toString().trim(): practiceQuestionListingModel!.questions![index].engOption3.toString().trim(),
              //     style: TextStyle(fontSize:16,fontFamily: 'Noto Sans')),
              value: 2,
              groupValue: _radioValue[index].val,
              onChanged: (value) {
                if(!_radioValue[index].isSelected) {
                  setState(() {
                    _radioValue[index].val = value;
                    _radioValue[index].isSelected = true;
                  });
                }
              },
              selected: _radioValue[index].val == 2,
              activeColor: AppColors.white,
            ),
          ),
          practiceQuestionListingModel!.questions![index].engOption4.toString().isEmpty || practiceQuestionListingModel!.questions![index].engOption4 == null  ? SizedBox() :
          Container(
            color: _radioValue[index].val == 3 ? practiceQuestionListingModel!.questions![index].correctAnswer == 4 ? AppColors.green : AppColors.red : AppColors.transparent,
            child: RadioListTile(
              title:TeXView(
                  renderingEngine:TeXViewRenderingEngine.mathjax(),
                  style:TeXViewStyle(
                    backgroundColor: _radioValue[index].val == 3 ? practiceQuestionListingModel!.questions![index].correctAnswer == 4 ? AppColors.green : AppColors.red : AppColors.transparent,
                  ) ,
                  child: TeXViewDocument(
                      (
                          AppConstants.langCode == 'hi' ? practiceQuestionListingModel!.questions![index].hindiOption4 :
                          practiceQuestionListingModel!.questions![index].engOption4)!,

                      style: TeXViewStyle(
                        //textAlign: TeXViewTextAlign.Center,
                        margin: TeXViewMargin.zeroAuto(),
                      )
                  )
              ),
              // Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption4.toString().trim(): practiceQuestionListingModel!.questions![index].engOption4.toString().trim(),
              //     style: TextStyle(fontSize:16,fontFamily: 'Noto Sans')),
              value: 3,
              groupValue: _radioValue[index].val,
              onChanged: (value) {
                if(!_radioValue[index].isSelected) {
                  setState(() {
                    _radioValue[index].val = value;
                    _radioValue[index].isSelected = true;
                  });
                }
              },
              selected: _radioValue[index].val == 3,
              activeColor: AppColors.white,
            ),
          ),
          practiceQuestionListingModel!.questions![index].engOption5.toString().isEmpty || practiceQuestionListingModel!.questions![index].engOption5 == null ? SizedBox() :
          Container(
            color: _radioValue[index].val == 4 ? practiceQuestionListingModel!.questions![index].correctAnswer == 5 ? AppColors.green : AppColors.red : AppColors.transparent,
            child: RadioListTile(
              title: Text(AppConstants.langCode == 'hi' ?practiceQuestionListingModel!.questions![index].hindiOption5.toString().trim(): practiceQuestionListingModel!.questions![index].engOption5.toString().trim(),
                  style: TextStyle(fontSize:16,fontFamily: 'Noto Sans')),
              value: 4,
              groupValue: _radioValue[index].val,
              onChanged: (value) {
                if(!_radioValue[index].isSelected) {
                  setState(() {
                    _radioValue[index].val = value;
                    _radioValue[index].isSelected = true;
                  });
                }
              },
              selected: _radioValue[index].val == 4,
              activeColor: AppColors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: correctAnswer(index, _radioValue[index].isSelected),
          )*/
        ],
      ),
    );
  }

  Widget correctAnswer(int index, bool visible) {
    return visible ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Correct Answer : '+practiceQuestionListingModel!.questions![index].correctAnswer.toString()),
        SizedBox(height: 5),
        practiceQuestionListingModel!.questions![index].solutionHindi == null ||  practiceQuestionListingModel!.questions![index].solutionEng == null?SizedBox():   CustomRoundButton(onPressed: (){
          setState(() {
            _radioValue[index].showAnswer = !_radioValue[index].showAnswer;
          });
        },text: _radioValue[index].showAnswer ? 'Hide Description' : 'Show Description'),
        SizedBox(height: 5),
        _radioValue[index].showAnswer ? Html(
          data: AppConstants.langCode == 'hi' ?
          practiceQuestionListingModel!.questions![index].solutionHindi.toString().replaceAll(RegExp(r"<[^>]*>"), ' ') :
          practiceQuestionListingModel!.questions![index].solutionEng.toString().replaceAll(RegExp(r"<[^>]*>"), ' '),
        ) : SizedBox()
      ],
    ) : SizedBox();
  }
}

class MyRadio {
  bool isSelected;
  bool showAnswer;
  var val;
  MyRadio(this.isSelected, this.showAnswer, this.val);
}

class QueAnsModel {
  String? questionEn;
  String? questionHi;
  List<AnswerModel> ansEnList;
  List<AnswerModel> ansHiList;
  bool? isSelected;
  String? correctanswer;
  String? solutionEn;
  String? solutionHi;
  bool? isShowDetail = false;
  QueAnsModel(this.questionEn,this.questionHi,this.ansEnList, this.ansHiList, this.isSelected,this.correctanswer,this.solutionEn,this.solutionHi,this.isShowDetail);
}

class AnswerModel {
  String? answer;
  Color? color;
  AnswerModel(this.answer, this.color);
}
