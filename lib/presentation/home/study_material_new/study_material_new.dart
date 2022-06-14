import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/study_material_new_model.dart';
import 'package:exampur_mobile/presentation/home/study_material_new/study_material_sub_category.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyMaterialNew extends StatefulWidget {
  final int pagetype;
  final String url;
  const StudyMaterialNew(this.pagetype,this.url) : super();

  @override
  _StudyMaterialNewState createState() => _StudyMaterialNewState();
}

class _StudyMaterialNewState extends State<StudyMaterialNew> {
  List<StudyMaterialNewModel> studyMaterialDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    getLists();
    super.initState();
  }

  Future<void> getLists() async {
    isLoading = true;
    studyMaterialDataList = (await Provider.of<CaProvider>(context, listen: false).getStudyMaterialNew(context, widget.url))!;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getLists()),
        builder: (context, snapshot) {
          return isLoading ? loader() : studyMaterialDataList.length == 0 ? noData() :
            Scaffold(
              body: TabBarDemo(
                  length: studyMaterialDataList.length,
                  names: studyMaterialDataList.map((item) => item.superCategory.toString()).toList(),
                  routes: studyMaterialDataList.length == 0 ? [] :
                  List.generate(studyMaterialDataList.length, (index) => dataList(index)),
                  title:widget.pagetype==1? getTranslated(context, StringConstant.PreviousYearPdf)!:getTranslated(context, StringConstant.studyMaterials)!)
          );
        });
  }

  Widget dataList(tabPos) {
    return ListView.builder(
        itemCount: studyMaterialDataList[tabPos].category!.length,
        itemBuilder: (context, index) {
          return itemList(studyMaterialDataList[tabPos].superCategory.toString(), studyMaterialDataList[tabPos].category![index]);
        });
  }

  Widget itemList(String tabTitle, Category category) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
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
        child: ListTile(
            onTap: () {
              AppConstants.goTo(context, StudyMaterialSubCategory(widget.pagetype,tabTitle, category.id.toString()));
            },
            title: Text(
              category.name.toString(),
              style: CustomTextStyle.subHeading(context),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 12,
              color: AppColors.black,
            )
        ),
      ),
    );
  }

  Widget loader() {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Center(child: CircularProgressIndicator(color: AppColors.amber))
    );
  }

  Widget noData() {
    return Scaffold(
        appBar: CustomAppBar(),
        body: AppConstants.noDataFound()
    );
  }
}

