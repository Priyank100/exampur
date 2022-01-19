import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/state_json.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class GeneralSettings extends StatefulWidget {
  @override
  _GeneralSettingsState createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  String userName = '';
  String Name ='';
  String Email='';
  String Mobile='';
  String City='';
  String selectedState='';
  List<States> stateList = [];

  late GlobalKey<FormState> _formKeyLogin;
  CreateUserModel registerModel=CreateUserModel ();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool isLoading = false;

  Future<void> getSharedPrefData() async {
    var jsonValue =  jsonDecode(await SharedPref.getSharedPref(AppConstants.USER_DATA));
    AppConstants.printLog('priyank>> ${jsonValue.toString()}');
    userName = jsonValue[0]['data']['first_name'].toString();
    Mobile = jsonValue[0]['data']['phone'].toString();
    Email = jsonValue[0]['data']['email_id'].toString();
    Name = jsonValue[0]['data']['first_name'].toString();
    City = jsonValue[0]['data']['city'].toString();
    _nameController.text = userName;
    _emailController.text = Email;
    _cityController.text = City;
    setState(() {
    });
  }

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
  void initState()  {
    super.initState();
    _formKeyLogin =GlobalKey<FormState>();
    getSharedPrefData();
    getStateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body:
         SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(getTranslated(context, 'name')!,style: TextStyle(color: Colors.black,)),
                  CustomTextField(hintText:'${Name}', value: (value) {},controller: _nameController,),
                  SizedBox(height: 10,),
                  Text(getTranslated(context, 'phone_number')!,style: TextStyle(color: Colors.black,)),
                  CustomTextField(hintText: '${Mobile}', value: (value) {},readOnly: true,),
                  SizedBox(height: 10,),
                  Text(getTranslated(context, 'email')!,style: TextStyle(color: Colors.black,)),
                  CustomTextField(hintText: '${Email}', value: (value) {},controller: _emailController,),
                  SizedBox(height: 10,),
                  Text(getTranslated(context, 'user_name')!,style: TextStyle(color: Colors.black)),
                  CustomTextField(hintText: '${userName}', value: (value) {},readOnly: true,),
                  SizedBox(height: 10,),
                  Text(getTranslated(context, 'city')!,style: TextStyle(color: Colors.black,)),
                  CustomTextField(hintText:'${City}', value: (value) {},controller: _cityController,),
                  SizedBox(height: 10,),
                  Text(getTranslated(context, 'state')!,style: TextStyle(color: Colors.black,)),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:  BorderRadius.all(const Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1))
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10),
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
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: !isLoading
                          ?  InkWell(onTap:(){
                            String _firstName = _nameController.text.trim();
                            String _email = _emailController.text.trim();
                            String _city = _cityController.text.trim();
                            if(!checkValidation(_firstName, _email, _city)) {
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              setState(() {
                                isLoading = true;
                              });
                              _updateUserAccount(_firstName, _email, _city);
                            }
                            },
                          child: Container(height: 50, color: Colors.amber,child: Center(child: Text(getTranslated(context, 'save_profile')!,style: TextStyle(color: Colors.white),)),))
                          :
                      Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber))),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  bool checkValidation(_firstName, _email, _city) {
    if (_firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('NAME_FIELD_MUST_BE_REQUIRED'), backgroundColor: Colors.black));
      return false;
    }else if (_email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('EMAIL_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }else if (_city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CITY_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }else if (selectedState=='Select States') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('STATE_MUST_BE_REQUIRED'), backgroundColor:Colors.black));
      return false;
    }else {
      return true;
    }
  }

  _updateUserAccount(_firstName, _email, _city) async {

      // CreateUserModel updateUserInfoModel = Provider.of<AuthProvider>(context, listen: false).uerupdate;
      CreateUserModel updateUserInfoModel = CreateUserModel();
      updateUserInfoModel.firstName = _firstName;
      updateUserInfoModel.lastName = '';
      updateUserInfoModel.emailId = _email;
      updateUserInfoModel.city = _city;
      updateUserInfoModel.state = selectedState;
      updateUserInfoModel.country = 'India';
      updateUserInfoModel.language = 'English';

      await Provider.of<AuthProvider>(context, listen: false).updateUserProfile(updateUserInfoModel).then((response) {
        isLoading = false;
        if(response) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Updated Successfully'), backgroundColor: Colors.green));
          Navigator.pop(context);
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Server error'), backgroundColor: Colors.red));
        }
        setState(() {});
     }
   );
  }

}

