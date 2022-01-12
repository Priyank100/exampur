import 'package:dropdown_search/dropdown_search.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/data/model/state_json.dart';
import 'package:exampur_mobile/presentation/authentication/terms_condition.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/home/LandingChooseCategory.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'otp_screen.dart';
class SignUp extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late GlobalKey<FormState> _formKeySignUp;
  bool _isCheckTerms = false;

  String selectedState='';
  List<States> stateList = [];

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
    super.initState();
    _formKeySignUp = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _cityController = TextEditingController();
    getStateList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  CreateUserModel CreateUserbody = CreateUserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Form(
          key: _formKeySignUp,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(Images.exampur_title, width: 200,)
                    ),
                    Text(
                      "Let's Register",
                      style: CustomTextStyle.headingBigBold(context),
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                        hintText: "Name",
                        controller: _nameController,
                        value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: "E-mail",
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),

                    CustomPasswordTextField(
                        hintTxt: 'Password',
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                      ),

                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: "Username",
                        controller: _userNameController,
                        value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: "Phone number",
                        controller: _phoneController,
                        textInputType: TextInputType.number,
                        maxLength: 10,
                        value: (value) {}),

                    SizedBox(
                      height: 15,
                    ),
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

                    SizedBox(
                      height: 15,
                    ),

                    CustomTextField(
                        hintText: "City",
                        controller: _cityController,
                        value: (value) {}),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isCheckTerms,
                            checkColor: Colors.white,
                            activeColor: Colors.amber,
                            onChanged: (newValue) {
                              setState(() {
                                _isCheckTerms = newValue!;
                              });
                            }),
                        Text(
                          'I agree with ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        InkWell(
                            onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (_) =>TermsAndConditions()));},
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                  color: Colors.amber,
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Poppins'),
                            ))
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          registerUser();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 60),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Facing problem in signing in?",style: TextStyle(color: Colors.grey.shade600),),
                        CustomTextButton(onPressed: () {
                         AppConstants.makePhoneCall('tel:'+AppConstants.Mobile_number);
                        }, text: "Call us")
                      ],
                    )
                  ],
                )),
          ),
        ));
  }

  void registerUser() async {
    if (_formKeySignUp.currentState!.validate()) {
      _formKeySignUp.currentState!.save();

      String _name = _nameController.text.trim();
      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();
      String _userName = _userNameController.text.trim();
      String _phone = _phoneController.text.trim();
      String _city = _cityController.text.trim();

      if (_name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Please enter your Name',
          ),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Email Id'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter atleast 8 letter Password'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_userName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Username'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Phone Number'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_phone.length < 10) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter valid Phone Number'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (_city.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter City'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (selectedState=='Select States') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select State'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else if (!_isCheckTerms) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Agree the Terms and Conditions to proceed.'),
          backgroundColor: Colors.black,
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      } else {
        CreateUserbody.phoneExt = '91';
        CreateUserbody.firstName = _name;
        CreateUserbody.emailId = _email;
        CreateUserbody.password = _password;
        CreateUserbody.phone = _phone;
        CreateUserbody.lastName = _userName;
        CreateUserbody.state = selectedState;
        CreateUserbody.city = _city;
        CreateUserbody.country = "India";
        CreateUserbody.language = 'English';

        await Provider.of<AuthProvider>(context, listen: false)
            .userResgister(CreateUserbody, route);
      }
    }
  }

  route(bool isRoute, String errorMessage) async {
    if (isRoute) {
      SharedPref.saveSharedPref(AppConstants.SELECT_CATEGORY_LENGTH, '0');
      Navigator.pushReplacement(
          context,
              MaterialPageRoute(builder: (_) => OtpScreen(false)));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }



}
