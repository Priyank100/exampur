import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/study_material_new_model.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyMaterialNew extends StatefulWidget {
  const StudyMaterialNew() : super();

  @override
  _StudyMaterialNewState createState() => _StudyMaterialNewState();
}

class _StudyMaterialNewState extends State<StudyMaterialNew> {
  List<StudyMaterialNewModel> studyMaterialDataList = [];

  @override
  void initState() {
    getLists();
    super.initState();
  }
  Future<void> getLists() async {
    studyMaterialDataList = (await Provider.of<CaProvider>(context, listen: false).getStudyMaterialNew(context))!;
    AppConstants.printLog(studyMaterialDataList.length);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getLists()),
        builder: (context, snapshot) {
          return Scaffold(
              body: /*studyMaterialDataList.length == 0 ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :*/
               TabBarDemo(
                  length: studyMaterialDataList.length,
                  names: studyMaterialDataList.map((item) => item.superCategory.toString()).toList(),
                  routes: studyMaterialDataList.length == 0 ? [] : [
                    dataList(0, studyMaterialDataList[0].category!.length),
                    dataList(1, studyMaterialDataList[1].category!.length)
                    ],
                  title: getTranslated(context, StringConstant.studyMaterials)!)
          );
        });
  }

  Widget dataList(tabId, dataLength) {
    return ListView.builder(
        itemCount: dataLength,
        itemBuilder: (context, index) {
          return Text(studyMaterialDataList[tabId].category![index].name.toString());
        });
  }
}

