import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/shared/one_two_one_card.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/shared/quiz_card_ca.dart';
import 'package:exampur_mobile/shared/test_series_card.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EligibilityCalculator extends StatefulWidget {
  EligibilityCalculator({
    Key? key,
  }) : super(key: key);

  @override
  _EligibilityCalculatorState createState() => _EligibilityCalculatorState();
}

class _EligibilityCalculatorState extends State<EligibilityCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.FONT_SIZE_SMALL,bottom: Dimensions.FONT_SIZE_SMALL),
              child: Text(
               getTranslated(context, 'eligibility_calculator')!,
                style: CustomTextStyle.headingBigBold(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //
                ),
              ),
              child:  Text(getTranslated(context, 'calculater_page')!, style: CustomTextStyle.headingSemiBold(context),)),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  getTranslated(context, 'state')!,
                  style: CustomTextStyle.headingBigBold(context),
                )),
      SizedBox(height: 25,),
     Padding(
       padding: const EdgeInsets.only(left: 12.0,right: 12,bottom: 8),
       child: CustomTextField(hintText: getTranslated(context, 'enter_state')!, value: (value){}),
     ),
            Center(
              child: CustomSmallerElevatedButton(
                color: AppColors.orange,
                onPressed: () {},
                text: getTranslated(context, 'next')!,
              ),
            ),

          ],
        )));
  }
}
