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
  String selectedAge='';
  String selectedAttemptHistory='';
  int percent = 0;
  int pageNo = 1;
  int qualifyVal = -1;
  int attemptVal = -1;
  TextEditingController ageController = TextEditingController();

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
                  getTranslated(context, StringConstant.eligibilityCalculator)!,
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
                    getTranslated(context, StringConstant.calculatorPage)!,
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
                backgroundColor: AppColors.grey,
                progressColor: AppColors.blue,
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

  Widget StateWidget()  {
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
                AppConstants.printLog('priyank>>'+selectedState);
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
              if(percent == 25) {
                setState(() {
                  pageNo = 2;
                });
              } else {
                AppConstants.showBottomMessage(context, 'Please select state', AppColors.black);
              }
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget QualificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Qualification',
              style: CustomTextStyle.headingBigBold(context),
            )
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      '10th Class',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: qualifyVal == 0,
                onSelected: (selected){
                  setState(() {
                    qualifyVal = selected ? 0 : -1;
                    if(selected) {
                      selectedQualification = '10th';
                      percent = 50;
                    } else {
                      selectedQualification = '';
                      percent = 25;
                    }
                  });
                },
              ),
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      '12th Class',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: qualifyVal == 1,
                onSelected: (selected){
                  setState(() {
                    qualifyVal = selected ? 1 : -1;
                    if(selected) {
                      selectedQualification = '12th';
                      percent = 50;
                    } else {
                      selectedQualification = '';
                      percent = 25;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      'Graduation',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: qualifyVal == 2,
                onSelected: (selected){
                  setState(() {
                    qualifyVal = selected ? 2 : -1;
                    if(selected) {
                      selectedQualification = 'Graduation';
                      percent = 50;
                    } else {
                      selectedQualification = '';
                      percent = 25;
                    }
                  });
                },
              ),
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      'Post Graduation',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: qualifyVal == 3,
                onSelected: (selected){
                  setState(() {
                    qualifyVal = selected ? 3 : -1;
                    if(selected) {
                      selectedQualification = 'Post Graduation';
                      percent = 50;
                    } else {
                      selectedQualification = '';
                      percent = 25;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              if(percent == 50) {
                setState(() {
                  pageNo = 3;
                });
              } else {
                AppConstants.showBottomMessage(context, 'Please select qualification', AppColors.black);
              }
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget AgeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Age',
              style: CustomTextStyle.headingBigBold(context),
            )
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            color: AppColors.grey300,
            width: MediaQuery.of(context).size.width,
            child: CustomTextField(
              hintText: 'Enter your age',
              textInputType: TextInputType.number,
              textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
              controller: ageController,
              value: (value) {
                setState(() {
                  value.isEmpty ? percent = 50 : percent = 75;
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
              if(percent == 75) {
                setState(() {
                  selectedAge = ageController.text.toString();
                  pageNo = 4;
                });
              } else {
                AppConstants.showBottomMessage(context, 'Please enter age', AppColors.black);
              }
            },
            text: getTranslated(context, 'next')!,
          ),
        ),
      ],
    );
  }

  Widget AttemptWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Attempt History',
              style: CustomTextStyle.headingBigBold(context),
            )
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      'Fresher',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: attemptVal == 0,
                onSelected: (selected){
                  setState(() {
                    attemptVal = selected ? 0 : -1;
                    if(selected) {
                      selectedAttemptHistory = 'Fresher';
                      percent = 100;
                    } else {
                      selectedAttemptHistory = '';
                      percent = 75;
                    }
                  });
                },
              ),
              ChoiceChip(
                label: Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                      'Repeater',
                      style: TextStyle(fontSize: 14, color: AppColors.black)),
                ),
                elevation: 10,
                padding: EdgeInsets.all(8),
                shadowColor: Colors.black,
                disabledColor: AppColors.grey300,
                selectedColor: AppColors.amber,
                selected: attemptVal == 1,
                onSelected: (selected){
                  setState(() {
                    attemptVal = selected ? 1 : -1;
                    if(selected) {
                      selectedAttemptHistory = 'Repeater';
                      percent = 100;
                    } else {
                      selectedAttemptHistory = '';
                      percent = 75;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: CustomSmallerElevatedButton(
            color: AppColors.orange,
            onPressed: () {
              if(percent == 100) {
                // AppConstants.showAlertDialog(context, selectedState + '\n' +
                // selectedQualification + '\n' + selectedAge + '\n' + selectedAttemptHistory);

                // call api

              } else {
                AppConstants.showBottomMessage(context, 'Please select attempt history', AppColors.black);
              }
            },
            text: getTranslated(context, StringConstant.calculate)!,
          ),
        ),
      ],
    );
  }
}
