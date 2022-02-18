import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/app_tutorial_model.dart';
import 'package:exampur_mobile/data/model/appp_toutorial.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial_card.dart';
import 'package:exampur_mobile/provider/AppToutorial_provider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTutorial extends StatefulWidget {
  AppTutorial({
    Key? key,
  }) : super(key: key);

  @override
  _AppTutorialState createState() => _AppTutorialState();
}

class _AppTutorialState extends State<AppTutorial> {
  List<Data> apptutorialList= [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getDemoList();
  }

  Future<void> getDemoList() async {
isLoading=true;
    apptutorialList= (await Provider.of<AppTutorialProvider>(context, listen: false).getapptutorialList(context))!;
    isLoading=false;
    setState(() {});
    // return one2oneList;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body:isLoading?Center(child: CircularProgressIndicator(color: AppColors.amber,)): apptutorialList.length == 0
            ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline),
            Text(getTranslated(context, StringConstant.noData)!)
          ],
        ))
            : SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.FONT_SIZE_SMALL,
                        bottom: Dimensions.FONT_SIZE_SMALL),
                    child: Text(
                      getTranslated(context, StringConstant.appTutorial)!,
                      style: CustomTextStyle.headingBigBold(context),
                    ),
                  ),
                  ListView.builder(
                      itemCount: apptutorialList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return AppTutorialCard(apptutorialList[index], index);
                      }),
                ],
              )
        )
    );
  }
}
