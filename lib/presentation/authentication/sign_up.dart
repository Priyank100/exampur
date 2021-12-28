import 'package:dropdown_search/dropdown_search.dart';
import 'package:exampur_mobile/SharePref/shared_pref.dart';
import 'package:exampur_mobile/data/model/createUserModel.dart';
import 'package:exampur_mobile/presentation/drawer/choose_category.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_button.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String state = 'Delhi';
  bool _isCheckTerms = false;

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
  }

  String dropdownValue = "fe";
  List<String> categories = [
    "fe",
    'fw',
    "fs",
    'efw',
    'wfee',
    'wefwef',
    'wefwe',
    'fewfs',
    'gwgg',
    'xcx',
    's',
    'g',
    'nhyn',
    'nyr',
    'ht4e'
  ];

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

  FocusNode _nameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _passNode = FocusNode();
  FocusNode _userNameNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _cityNode = FocusNode();
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
                    Center(child: Image.asset(Images.exampur_title)),
                    SizedBox(height: 20),
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
                        value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextField(
                        hintText: "Password",
                        controller: _passwordController,
                        value: (value) {}),
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
                        value: (value) {}),
                    SizedBox(
                      height: 15,
                    ),
                    // CustomTextField(hintText: "", controller:_passwordController,value: (value) {}),
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
                            onTap: () {},
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
                    // SizedBox(height: 20),
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
          backgroundColor: Colors.red,
        ));
      } else if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Email Id'),
          backgroundColor: Colors.red,
        ));
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter atleast 6 letter Password'),
          backgroundColor: Colors.red,
        ));
      } else if (_userName.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Username'),
          backgroundColor: Colors.red,
        ));
      } else if (_phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your Phone Number'),
          backgroundColor: Colors.red,
        ));
      } else if (state.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select State'),
          backgroundColor: Colors.red,
        ));
      } else if (_city.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter City'),
          backgroundColor: Colors.red,
        ));
      } else if (!_isCheckTerms) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Agree the Terms and Conditions to proceed.'),
          backgroundColor: Colors.red,
        ));
      } else {
        // if (Provider.of<AuthProvider>(context, listen: false).isRemember) {
        //   Provider.of<AuthProvider>(context, listen: false).saveUserEmail(_phone, _password);
        // } else {
        //   Provider.of<AuthProvider>(context, listen: false).clearUserEmailAndPassword();
        // }
        CreateUserbody.phoneExt = '91';
        CreateUserbody.firstName = _name;
        CreateUserbody.emailId = _email;
        CreateUserbody.password = _password;
        CreateUserbody.phone = _phone;
        CreateUserbody.lastName = _userName;
        CreateUserbody.state = state;
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
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ChooseCategory()),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
    }
  }



}
