import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/DownloadPdfView.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:exampur_mobile/data/model/study_material_sub_cat_model.dart';
import 'package:flutter/material.dart';

class StudyMaterialCategoryPdfListing extends StatefulWidget {
  final int pagetype;
  final String subTitle;
  final List<Category> pdfList;

  const StudyMaterialCategoryPdfListing(this.pagetype,this.subTitle, this.pdfList) : super();

  @override
  State<StudyMaterialCategoryPdfListing> createState() => _StudyMaterialCategoryPdfListingState();
}

class _StudyMaterialCategoryPdfListingState extends State<StudyMaterialCategoryPdfListing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(widget.pagetype==1?getTranslated(context, StringConstant.PreviousYearPdf)!:getTranslated(context, StringConstant.studyMaterials)!, style: CustomTextStyle.headingMediumBold(context)),
            ),
            subTitle(),
            SizedBox(height: 10),
            Expanded(
                child: widget.pdfList == null || widget.pdfList.length == 0 ? Center(child: AppConstants.noDataFound()) :
                pdfList()
            )
          ],
        )
    );
  }

  Widget subTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(widget.subTitle),
    );
  }

  Widget pdfList() {
    return ListView.builder(
        itemCount: widget.pdfList.length,
        itemBuilder: (context, index) {
          return item(index);
        });
  }

  Widget item(index) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: Image.asset(Images.pdfIcon, width: 60),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.pdfList[index].title.toString()),
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: (){
                  AppConstants.goTo(context, DownloadViewPdf(widget.pdfList[index].title.toString(), widget.pdfList[index].filePath.toString()));
                },
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  width: Dimensions.DailyMonthlyViewBtnWidth,
                  height: Dimensions.DailyMonthlyViewBtnHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border.all(color: AppColors.black)),
                  child: Text(getTranslated(context, StringConstant.view)!, style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
