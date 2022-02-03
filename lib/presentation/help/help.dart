import 'dart:convert';
import 'dart:io';

// import 'package:exampur_mobile/presentation/help/dropdown_menu.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/dropdown_selector.dart';
import 'package:exampur_mobile/provider/Helpandfeedback.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  String selectedState='';
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _descriptionController;
  late TextEditingController _phoneController;
  late GlobalKey<FormState> _formKeySignUp;

  @override
  void initState() {
    super.initState();
    _formKeySignUp = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  bool isLoading = false;

  String dropdownvalue = 'select issue';

  // List of items in our dropdown menu
  var items = [
    "select issue",
              "App Crashing",
              "Exam Guidance",
              "Study Help",
              "Purchase help",
              "Other"
  ];

  late String issue_id;
  HelpandFeedbackModel CreateUserbody = HelpandFeedbackModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _formKeySignUp,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  getTranslated(context, 'help')!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0,bottom: 6),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius:  BorderRadius.all(const Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1))
                  ],
                ),
                padding: EdgeInsets.only(left: 10),
                child: DropdownButton(
                  underline: SizedBox(),
                  isExpanded: true,
                  value: dropdownvalue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),



              // Padding(
              //     padding:
              //         const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
              //     child: DropDownSelector(
              //         isExpanded: true,
              //         items: [
              //           "select issue",
              //           "App Crashing",
              //           "Exam Guidance",
              //           "Study Help",
              //           "Purchase help",
              //           "Other"
              //         ],
              //         setValue: (val) {})),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
          width: double.infinity,

          decoration: BoxDecoration(
            color: AppColors.grey300,

            borderRadius:  BorderRadius.all(const Radius.circular(12)),
            //       border: Border(
            //   left: BorderSide(10)
            // ),
            boxShadow: [
              BoxShadow(color: AppColors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
            ],
          ),
                child:
                TextField(
                  cursorColor: AppColors.amber,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      hintText: getTranslated(context, 'write_about_the_problem')!,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      isDense: true,
                      //filled: true,
                      hintStyle: TextStyle(
                        color: AppColors.grey600,
                      ),
                      fillColor: AppColors.grey.withOpacity(0.1),
                      errorStyle: TextStyle(height: 1.5),
                      // focusedBorder: OutlineInputBorder(borderSide: BorderRadius.all( Radius.circular(12)),),
                      // hintStyle: titilliumRegular.copyWith(color: Theme.of(context).hintColor),
                      border: InputBorder.none),
                  maxLines: 8,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              //   child: SizedBox(
              //     height: 55.0,
              //     width: MediaQuery.of(context).size.width * 1,
              //     child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           primary: AppConstants.Dark,
              //           elevation: 5.0,
              //         ),
              //         onPressed: () {
              //           FocusScope.of(context).unfocus();
              //           registerUser();
              //         },
              //         child: const Text(
              //           'Submit Issue',
              //           style: TextStyle(
              //             fontSize: 20.0,
              //           ),
              //         )),
              //   ),
              // ),
              SizedBox(height: 30,),
              // !isLoading
              //     ?
              InkWell(onTap:(){

                String _message = _descriptionController.text.trim();
                if(!checkValidation(_message)) {
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  helpandfeedback(_message);
                 //_updateUserAccount(_message);
                }
              },
                  child: Container(margin:  EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                    height: 50, color: AppColors.dark,child: Center(child: Text(getTranslated(context, 'submit_issue')!,style: TextStyle(color: Colors.white,fontSize: 20),)),)),
                //  :
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.amber))),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 30.0, bottom: 10),
                child: SizedBox(
                  height: 55.0,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.dark,
                        elevation: 5.0,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>AppTutorial()));
                      },
                      child: Text(
                        getTranslated(context, 'watch_app_tutorial')!,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkValidation(_message) {
    if (_message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, 'all_fields_mandatory')!), backgroundColor: AppColors.black));
      return false;
    }

   //  else if (dropdownvalue=='Select issues') {
   //    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(), backgroundColor:AppColors.black));
   //    return false;
   // }
    else {
      return true;
    }
  }

  helpandfeedback(_message) async {

    var body = {"message":_message,
    "type":dropdownvalue};
    await Service.post(
      API.HelpFeedback_URL,
      body: body,
    ).then((response) async {
      print(response.body.toString());
      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text('Server Error'),backgroundColor: AppColors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        var jsonObject =  jsonDecode(response.body);
        AppConstants.printLog('priyank>> '+jsonObject['statusCode'].toString());
        if(jsonObject['statusCode'].toString() == '200'){
          print(jsonObject['data']);

          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          //AppConstants.selectedCategoryList = jsonObject['data'].cast<String>();
          setState(() {});

        }  else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
        }

      } else {
        AppConstants.printLog("init address fail");
        final body = json.decode(response.body);
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text(body['data'].toString()),backgroundColor: AppColors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}