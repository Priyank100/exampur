import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/practice_question_categories_model.dart';
import 'package:exampur_mobile/presentation/home/PracticeQuestion/practice_question_listing.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/PracticeQuestionProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PracticeQuestionCategory extends StatefulWidget {
  const PracticeQuestionCategory({Key? key}) : super(key: key);

  @override
  State<PracticeQuestionCategory> createState() => _PracticeQuestionCategoryState();
}

class _PracticeQuestionCategoryState extends State<PracticeQuestionCategory> {
  List<PracticeQuestionCategoriesModel> practiceQuestionDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    getLists();
    super.initState();
  }
  Future<void> getLists() async {
    isLoading = true;
    practiceQuestionDataList = (await Provider.of<PracticeQuestionProvider>(context, listen: false).getPracticeQuestion(context))!;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Future.delayed(Duration.zero, () => getLists()),
        builder: (context, snapshot) {
          return isLoading ? loader() : practiceQuestionDataList.length == 0 ? noData() :
          Scaffold(
              body: TabBarDemo(
                  length: practiceQuestionDataList.length,
                  names: practiceQuestionDataList.map((item) => item.name.toString()).toList(),
                  routes: practiceQuestionDataList.length == 0 ? [] :
                  List.generate(practiceQuestionDataList.length, (index) => dataList(index)),
                 // title: getTranslated(context, StringConstant.studyMaterials)!)
                  title: getTranslated(context, StringConstant.PracticeQuestion)!)
          );
        });
  }

  Widget dataList(tabPos) {
    return ListView.builder(
        itemCount: practiceQuestionDataList[tabPos].subCat!.length,
        itemBuilder: (context, index) {
          return itemList(practiceQuestionDataList[tabPos].name.toString(),practiceQuestionDataList[tabPos].slug.toString(), practiceQuestionDataList[tabPos].subCat![index]);
        });
  }

  Widget itemList(String name,String slug, SubCat category) {
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
              AppConstants.goTo(context, PracticeQuestionListing(name,category.name.toString(),slug,category.slug.toString()));
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
