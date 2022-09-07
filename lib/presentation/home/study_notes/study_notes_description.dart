import 'package:exampur_mobile/data/model/study_notes_description_model.dart';
import 'package:exampur_mobile/provider/StudyNotesProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class StudyNotesDescription extends StatefulWidget {
  String id ;
   StudyNotesDescription(this.id) : super();

  @override
  State<StudyNotesDescription> createState() => _StudyNotesDescriptionState();
}

class _StudyNotesDescriptionState extends State<StudyNotesDescription> {
  StudyNotesDescriptionModel? studyNotesChapterDescriptionModel;
  bool isLoading = false;
  void initState() {
    getstudynotesdescription();
    super.initState();
  }
  Future<void> getstudynotesdescription() async {
    isLoading = true;
    studyNotesChapterDescriptionModel =
    (await Provider.of<StudyNotesProvider>(context, listen: false)
        .getStudyNotesChapterDescriptionList(context,widget.id,))!;
    isLoading =false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)):studyNotesChapterDescriptionModel == null ? AppConstants.noDataFound() :
      SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(studyNotesChapterDescriptionModel!.title.toString(),style: TextStyle(fontSize: 15)),
        ),
          Html(data: studyNotesChapterDescriptionModel!.description.toString())
      ],),
    ));
  }
}
