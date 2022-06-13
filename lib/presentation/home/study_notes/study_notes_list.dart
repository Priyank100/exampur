import 'package:exampur_mobile/data/model/study_notes_chape_model.dart';
import 'package:exampur_mobile/data/model/study_notes_model.dart';
import 'package:exampur_mobile/data/model/study_notes_subject_model.dart';
import 'package:exampur_mobile/presentation/home/study_notes/study_notes_description.dart';
import 'package:exampur_mobile/provider/StudyNotesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyNotesList extends StatefulWidget {
  final String url;
  const StudyNotesList(this.url) : super();

  @override
  State<StudyNotesList> createState() => _StudyNotesListState();
}

class _StudyNotesListState extends State<StudyNotesList> {
  List<StudyNotesModel> studynotesList = [];
  StudyNotesSubjectModel? studyNotesSubjectModel;
  StudyNotesChaperModel? studyNotesChapterModel;
  bool isvisible = false;
  bool isLoading = false;
  String catId = '';
  String subjectlength = '';
  int? selectedIndex;
  @override
  void initState() {
    getstudynotesList();
    super.initState();
  }

  Future<void> getstudynotesList() async {
    isLoading = true;
    studynotesList =
        (await Provider.of<StudyNotesProvider>(context, listen: false)
            .getStudyNotesList(context, widget.url))!;

    for (var i = 0; i < studynotesList.length; i++) {
      catId = studynotesList[i].id.toString();
    }
    studyNotesSubjectModel =
        (await Provider.of<StudyNotesProvider>(context, listen: false)
            .getStudyNotesSubjectList(context, catId))!;
    studyNotesChapterModel =
        (await Provider.of<StudyNotesProvider>(context, listen: false)
            .getStudyNotesChapterList(context,'1',))!;

    isLoading = false;
    AppConstants.printLog(studynotesList.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: AppColors.amber))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Free Study Notes by Exampur',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  Row(
                    children: [
                      Text('Exam : ', style: TextStyle(fontSize: 15)),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ListView.builder(
                              itemCount: studynotesList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return courseButton(index);
                              }),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                        itemCount: studyNotesSubjectModel!.subject!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return chapterButton(index);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
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
                      color: AppColors.amber,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Chapter &  Notes',style: TextStyle(color: AppColors.white),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: studyNotesChapterModel!.subject!.length,
                      itemBuilder: (context,index){

                    return Container(
                      margin: EdgeInsets.all(8),
                     padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
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
                        color: AppColors.white,
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               Text(studyNotesChapterModel!.subject![index].name.toString()),
                                SizedBox(width: 15,),
                                for(var chapter =0; chapter < studyNotesChapterModel!.subject![index].content!.length ; chapter++)
                                InkWell(
                                  onTap:(){
                                    AppConstants.goTo(context, StudyNotesDescription(studyNotesChapterModel!.subject![index].content![chapter].id.toString()));
                                  },
                                    child:  Text(studyNotesChapterModel!.subject![index].content![chapter].title.toString(),style: TextStyle(color: AppColors.amber),))
                              ],
                            ),

                      ),


                    );
                  })
                  // Visibility(
                  //     visible: isvisible,
                  //     child: listChapter())
                ],
              ),
            ),
    );
  }

  Widget courseButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(studynotesList[index].name.toString(),
              style: TextStyle(fontSize: 12)),
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(AppColors.black),
              backgroundColor:
              selectedIndex == index    ? MaterialStateProperty.all<Color>(AppColors.amber):  MaterialStateProperty.all<Color>(AppColors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)))),
          onPressed: () {
            setState(() {
              selectedIndex = index;
            });
          }),
    );
  }

  Widget chapterButton(index) {
    return Container(
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          child: Text(studyNotesSubjectModel!.subject![index].name.toString(),
              style: TextStyle(fontSize: 12)),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.black),
              backgroundColor:selectedIndex == index ?  MaterialStateProperty.all<Color>(AppColors.amber): MaterialStateProperty.all<Color>(AppColors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(width: 2, color: AppColors.amber)))),
          onPressed: () {
setState(() {
  selectedIndex = index;
});

          }),
    );
  }
  Widget dataSubject(index) {
    return Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          height: 50,
          width: MediaQuery.of(context).size.width,
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
            color: AppColors.amber,
          ),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(studyNotesSubjectModel!.subject![index].name.toString(),style: TextStyle(color: AppColors.white),textAlign: TextAlign.center,),
          // InkWell(
          //   onTap: (){
          //     isvisible = !isvisible;
          //     setState(() {
          //     });
          //     print('a');
          //   },
          //     child: Icon( Icons.arrow_downward,color: AppColors.white))
        ],
      ),
    );
  }


}

class Mychip {
  bool isSelected;

  Mychip(this.isSelected,);
}