import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:exampur_mobile/data/model/helpandfeedback.dart';
import 'package:exampur_mobile/data/model/issulistname.dart';
import 'package:exampur_mobile/presentation/AppTutorial/app_tutorial.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../SharePref/shared_pref.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  String? deviceModel;
  String? deviceMake;
  String? deviceOS;
  String? userName;
  String? userMobile;
  String? userEmail;
  String? versionName;
  String? versionCode;
 // String selectedState='';
  List<Issue> issueList = [];

  late TextEditingController _descriptionController;

  late GlobalKey<FormState> _formKeySignUp;

  bool isLoading = false;
  String issuevalue = '';
  late String issue_id;
  HelpandFeedbackModel CreateUserbody = HelpandFeedbackModel();

  @override
  void initState() {
    super.initState();
    getStateList();
    _formKeySignUp = GlobalKey<FormState>();
    _descriptionController = TextEditingController();
    getStateList();
    getUserData();
    getDeviceData();
    getAppVersionData();
    getDeviceData();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/LocalJson/issuename.json');
  }

  void getStateList() async {
    String jsonString = await loadJsonFromAssets();
    final IssueResponse = issulistnameFromJson(jsonString);
    issueList  =IssueResponse.issue!;
    issuevalue = issueList [0].name.toString();
    setState(() {});
  }

  Future<void> getUserData() async {
    var jsonValue = jsonDecode(await SharedPref.getSharedPref(SharedPref.USER_DATA));
    userName = jsonValue[0]['data']['first_name'].toString();
    userMobile = jsonValue[0]['data']['phone'].toString();
    userEmail = jsonValue[0]['data']['email_id'].toString();
    setState(() {});
  }

  Future<void> getDeviceData() async {
    if(Platform.isAndroid){
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model.toString();
      deviceMake = androidInfo.brand.toString();
      deviceOS = androidInfo.version.release.toString();
      setState(() {});
    }
  }

  Future<void> getAppVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    versionName = packageInfo.version;
    versionCode = packageInfo.buildNumber;
    setState(() {});
  }

  void sendMail(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: CustomAppBar(),
      body: Form(
        key: _formKeySignUp,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  getTranslated(context, LangString.help)!,
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
                  value:issuevalue,
                  items: issueList.map((value) {
                    return DropdownMenuItem(
                      value: value.name,
                      child: Text(value.name.toString()),
                    );
                  }).toList(),
                  onChanged: (selected) {
                    setState(() {
                      issuevalue = selected.toString();
                    });
                  },
                ),
              ),





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
                      hintText: getTranslated(context, LangString.writeAboutTheProblem)!,
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
              SizedBox(height: 30,),
              !isLoading
                  ?
              InkWell(onTap:(){

                String _message = _descriptionController.text.trim();
                FocusScope.of(context).unfocus();

                if(!checkValidation(_message)) {
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  //helpandfeedback(_message);
                  submitLog(_message);
                  setState(() {
issuevalue='Select issue';
                  });
                 //_updateUserAccount(_message);
                }
              },
                  child: Container(margin:  EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                    height: 50, color: AppColors.dark,child: Center(child: Text(getTranslated(context,LangString.submitIssue)!,style: TextStyle(color: Colors.white,fontSize: 20),)),))
                 :
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.amber))),
              ),
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
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) =>AppTutorial()));
                      },
                      child: Text(
                        getTranslated(context, LangString.watchAppTutorial)!,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                ),
              ),
              Center(child: Text(getTranslated(context, LangString.facingProblemInApplication)!,style: TextStyle(color: AppColors.grey600))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextButton(onPressed: () { AppConstants.makeCallEmail('tel:'+AppConstants.Mobile_number);}, text: getTranslated(context, LangString.callUs)!),
                  Text('/'),
                  CustomTextButton(onPressed: () {
                    Uri params = Uri(
                        scheme: 'mailto',
                        path: AppConstants.Email_id,
                        query: 'subject=${AppConstants.Email_sub}'
                    );
                    AppConstants.makeCallEmail(params.toString());
                    }, text:getTranslated(context, LangString.emailUs)! )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkValidation(_message) {
    if (_message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, LangString.allFieldsMandatory)!), backgroundColor: AppColors.black));
      return false;
    }

    else if (issuevalue=='Select issue') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(context, LangString.selectissue)!), backgroundColor:Colors.black));
      return false;
   }
    else {
      return true;
    }
  }

  helpandfeedback(_message) async {

    var body = {"message":_message,
    "type":issuevalue};
    await Service.post(
      API.HelpFeedback_URL,
      body: body,
    ).then((response) async {
      isLoading = false;
      // print(response.body.toString());
      if (response == null) {
        var snackBar = SnackBar( margin: EdgeInsets.all(20),
            behavior: SnackBarBehavior.floating,
            content: Text(getTranslated(context, LangString.serverError)!),backgroundColor: AppColors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 200) {
        AppConstants.printLog(response.body.toString());
        var jsonObject =  jsonDecode(response.body);
        AppConstants.printLog('priyank>> '+jsonObject['statusCode'].toString());
        if(jsonObject['statusCode'].toString() == '200'){
          AppConstants.printLog(jsonObject['data']);
          _descriptionController.clear();
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
          //AppConstants.selectedCategoryList = jsonObject['data'].cast<String>();
          setState(() {});

        }  else {
          AppConstants.showBottomMessage(context, jsonObject['data'].toString(), AppColors.black);
        }}
      else if(response.statusCode==429){
        await Service.post(
          API.HelpFeedback_URL_2,
          body: body,
        ).then((response) async {
          isLoading = false;
          // print(response.body.toString());
          if (response == null) {
            var snackBar = SnackBar( margin: EdgeInsets.all(20),
                behavior: SnackBarBehavior.floating,
                content: Text(getTranslated(context, LangString.serverError)!),backgroundColor: AppColors.red);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (response.statusCode == 200) {
            AppConstants.printLog(response.body.toString());
            var jsonObject =  jsonDecode(response.body);
            AppConstants.printLog('priyank>> '+jsonObject['statusCode'].toString());
            if(jsonObject['statusCode'].toString() == '200'){
              AppConstants.printLog(jsonObject['data']);
              _descriptionController.clear();
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

  Future<void> submitLog(_message) async {
    // AppConstants.showLoaderDialog(context);
    {
      var body = {
        "user": {
          "name": userName,
          "email": userEmail,
          "mobile": userMobile
        },
        "device": {
          "model": deviceModel,
          "make": deviceMake,
          "os": deviceOS
        },
        "app": {
          "version_name": versionName,
          "version_code": versionCode
        },
        "type": "feedback",
        "issue_type": issuevalue,
        "page": "help",
        "category": "HELP",
        "message": _message
      };
      Map<String, String> header = {
        "x-auth-token": AppConstants.serviceLogToken,
        "Content-Type": "application/json",
        "app-version":AppConstants.versionCode
      };
      await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((
          response) {
        isLoading = false;
        AppConstants.printLog(header);
        AppConstants.printLog(response.body);
        if(response == null) {
          AppConstants.showBottomMessage(context, getTranslated(context, LangString.serverError)!, AppColors.red);
        } else {
          if(response.statusCode == 200) {
            AppConstants.printLog(response.body);
            AppConstants.showBottomMessage(context, jsonDecode(response.body)['message'], AppColors.black);
            _descriptionController.clear();
            setState(() {});
          } else {
            AppConstants.showBottomMessage(context, 'Something went wrong', AppColors.red);
          }
        }
      });
    }
  }}