import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/study_material_sub_cat_model.dart';
import 'package:exampur_mobile/presentation/home/study_material_new/study_material_category_pdf_list.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/lang_string.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyMaterialSubCategory extends StatefulWidget {
  final int pagetype;
  final String tabTitle;
  final String categoryId;

  const StudyMaterialSubCategory(this.pagetype,this.tabTitle, this.categoryId) : super();

  @override
  State<StudyMaterialSubCategory> createState() => _StudyMaterialSubCategoryState();
}

class _StudyMaterialSubCategoryState extends State<StudyMaterialSubCategory> {
  StudyMaterialSubCatModel? studyMaterialSubCatModel;
  bool isLoading = true;

  @override
  void initState() {
    getSubCategoryData();
    super.initState();
  }

  Future<void> getSubCategoryData() async {
    isLoading = true;
    studyMaterialSubCatModel = (await Provider.of<CaProvider>(context, listen: false).getStudyMaterialSubCatData(context, widget.categoryId));
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.pagetype==1?getTranslated(context, LangString.PreviousYearPdf)!:getTranslated(context, LangString.studyMaterials)!, style: CustomTextStyle.headingMediumBold(context)),
            ),
            isLoading || studyMaterialSubCatModel == null ? SizedBox() : categoryTitle(),
            SizedBox(height: 10),
            Expanded(
                child: isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) :
                studyMaterialSubCatModel == null ? Center(child: AppConstants.noDataFound()) :
                dataList()
            )
          ],
        )
    );
  }

  Widget categoryTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(widget.tabTitle + ' -> ' + studyMaterialSubCatModel!.categoryName.toString()),
    );
  }

  Widget dataList() {
    return studyMaterialSubCatModel!.subCategory!.length == 0 ? Center(child: AppConstants.noDataFound()) :
      ListView.builder(
        itemCount: studyMaterialSubCatModel!.subCategory!.length,
        itemBuilder: (context, index) {
          return itemList(studyMaterialSubCatModel!.subCategory![index]);
        });
  }

  Widget itemList(SubCategory subCategory) {
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
              String subTitle = widget.tabTitle + ' -> ' + studyMaterialSubCatModel!.categoryName.toString() + ' -> ' + subCategory.name.toString();
              AppConstants.goTo(context, StudyMaterialCategoryPdfListing(widget.pagetype,subTitle, subCategory.category!));
            },
            title: Text(
              subCategory.name.toString(),
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
}
