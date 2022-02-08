import 'dart:convert';

import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/datasource/remote/dio/dio_client.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/custompassword_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecuritySettings extends StatefulWidget {
  @override
  _SecuritySettingsState createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  TextEditingController _currentPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();
  bool isLoading = false;
  late DioClient dioClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(getTranslated(context, StringConstant.currentPassword)!,style: TextStyle(color: AppColors.black,)),
                const SizedBox(height: 15,),
                CustomPasswordTextField(
                  controller: _currentPasswordController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15,),
               Text(getTranslated(context, StringConstant.newPassword)!,style: TextStyle(color: AppColors.black,)),
                const SizedBox(height: 15,),
                CustomPasswordTextField(
                  controller: _newPasswordController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15,),
                 Text(getTranslated(context, StringConstant.confirmPassword)!,style: TextStyle(color: AppColors.black,)),
                const SizedBox(height: 15,),
                CustomPasswordTextField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 40),
                buttonChangePassword()
              ],
            ),
          ),
        )
    );
  }

  Widget buttonChangePassword() {
    if(isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).primaryColor),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          validation();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12.0, horizontal: 60),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                getTranslated(context,StringConstant.changePassword )!,
                style:
                TextStyle(fontSize: 18, color: AppColors.white),
              ),
            ),
          ),
        ),
      );
    }
  }

  void validation() async {
    String currentPassword = _currentPasswordController.text.trim();
    String newPassword = _newPasswordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.PleasecurrentPassword)!),
        backgroundColor: AppColors.black,
      ));
    } else if (newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.PleaseEnternewPassword)!),
        backgroundColor: AppColors.black,
      ));
    } else if (newPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.PleaseletterPassword)!),
        backgroundColor: AppColors.black,
      ));
    } else if (confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.confirmPassword)!),
        backgroundColor: AppColors.black,
      ));
    } else if (confirmPassword.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.PleaseletterPassword)!),
        backgroundColor: AppColors.black,
      ));
    } else if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        content: Text(getTranslated(context, StringConstant.ConfirmPasswordMatched)!),
        backgroundColor: AppColors.black,
      ));
    } else {
      isLoading = true;
      String param = '{"current_password":"${currentPassword}",'
          '"confirm_password":"${confirmPassword}",'
          '"new_password":"${newPassword}"}';
      await Provider.of<AuthProvider>(context, listen: false).changePasswordPro(context, jsonDecode(param)).then((response) {
        isLoading = false;
        if(response) {
          _currentPasswordController.text = '';
          _newPasswordController.text = '';
          _confirmPasswordController.text = '';
        }
        setState(() {});
      });
    }
  }
}

