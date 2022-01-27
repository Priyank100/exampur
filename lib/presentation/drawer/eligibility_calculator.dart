import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/state_json.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class EligibilityCalculator extends StatefulWidget {
  EligibilityCalculator() : super();

  @override
  _EligibilityCalculatorState createState() => _EligibilityCalculatorState();
}

class _EligibilityCalculatorState extends State<EligibilityCalculator> {
  List<States> stateList = [];
  String selectedState='';
  String selectedQualification='';
  int percent = 0;
  int pageNo = 1;

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/Statejson/State.json');
  }

  void getStateList() async {
    String jsonString = await loadJsonFromAssets();
    final StateResponse = stateJsonFromJson(jsonString);
    stateList = StateResponse.states!;
    selectedState = stateList[0].name.toString();
    setState(() {});
  }


  @override
  void initState() {
    getStateList();
    super.initState();
  }

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
                padding: const EdgeInsets.only(
                    left: Dimensions.FONT_SIZE_SMALL,
                    top: Dimensions.FONT_SIZE_SMALL),
                child: Text(
                  getTranslated(context, 'eligibility_calculator')!,
                  style: CustomTextStyle.headingMediumBold(context),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5.0) //
                        ),
                  ),
                  child: Text(
                    getTranslated(context, 'calculater_page')!,
                    style: CustomTextStyle.descriptionNormal(context),
                  )),
                  SizedBox(height: 20),
                  // StateWidget(),
                  Switching()
            ]),
        ),
      bottomNavigationBar: Container(
        height: 100,
          child: Column(
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width-100,
                lineHeight: 10.0,
                percent: percent.toDouble()/100,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
                alignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 10),
              Text(
                percent.toString() + '%',
                style: CustomTextStyle.descriptionNormal(context),
              )
            ],
        ),
      ),
    );
  }

  Widget Switching() {
    switch(pageNo) {
      case 1: return StateWidget();
      case 2: return QualificationWidget();
      case 3: return AgeWidget();
      case 4: return AttemptWidget();
      default: return StateWidget();
    }
  }

  Widget StateWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              getTranslated(context, 'state')!,
              style: CustomTextStyle.headingBigBold(context),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: const EdgeInsets.only(left: 10, right: 10),
          color: AppColors.grey300,
          child: DropdownButton(
            underline: SizedBox(),
            isExpanded: true,
            value: selectedState,
            items: stateList.map((value) {
              return DropdownMenuItem(
                value: value.name,
                child: Text(value.name.toString()),
              );
            }).toList(),
            onChanged: (selected) {
              setState(() {
                selectedState = selected.toString();
                AppConstants.printLog(selectedState);
                if(selectedState.isEmpty ||selectedState == 'Select States') {
                  percent = 0;
                } else {
                  percent = 25;
                }
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              setState(() {
                pageNo = 2;
              });
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget QualificationWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              setState(() {
                pageNo = 3;
              });
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget AgeWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              setState(() {
                pageNo = 4;
              });
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget AttemptWidget() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              // call api
            },
            text: StringConstant.calculate,
          ),
        ),
      ],
    );
  }
}
