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
                'Eligibility Calculator',
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
              child: Flexible(child: Text('Please enter all the details to calculator your eligbility for different exam', style: CustomTextStyle.headingSemiBold(context),)),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "State",
                  style: CustomTextStyle.headingBigBold(context),
                )),
      SizedBox(height: 25,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: TextField(


          autocorrect: false,

          onChanged: (s) {

          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          cursorColor: AppColors.amber,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: AppColors.transparent,
              ),
            ),
            hintText: 'Enter state',
            hintStyle: TextStyle(
              color: AppColors.grey600,
            ),
            filled: true,
            fillColor: AppColors.grey300,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.white),
            ),
          ),
        ),
      ),
            Center(
              child: CustomSmallerElevatedButton(
                color: AppColors.orange,
                onPressed: () {},
                text: "Next",
              ),
            ),

          ],
        )));
  }
}
