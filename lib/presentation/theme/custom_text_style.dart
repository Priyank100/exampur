import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';

// Todo: define all possible texts here

class CustomTextStyle {
  static TextStyle drawerText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 15.0,
        fontFamily:'Poppins',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headingBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 20.0,
      color: AppColors.black,
      fontFamily:'Poppins',
      fontWeight: FontWeight.bold,

    );
  }
  static TextStyle headingMediumBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 25.0,
      color: AppColors.black,
      fontFamily:'Poppins',
      fontWeight: FontWeight.bold,

    );
  }
  static TextStyle headingBigBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
        fontFamily:'Poppins',


    );
  }

  static TextStyle descriptionNormal(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 14.0,
      color: AppColors.black,
      fontFamily:'Poppins',


    );
  }


  static TextStyle headingSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 18.0,
        fontFamily:'Poppins'
    );
  }

  static TextStyle subHeading(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
        fontFamily:'Poppins'
    );
  }


  static TextStyle subHeadingYellow(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
      color: Color(0xffFFD331),
        fontFamily:'Poppins'
    );
  }

}