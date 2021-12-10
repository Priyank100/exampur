import 'package:flutter/material.dart';

// Todo: define all possible texts here

class CustomTextStyle {
  static TextStyle drawerText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 12.0,
    );
  }

  static TextStyle type2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 16.0,
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle headingBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 20.0,
    );
  }

  static TextStyle headingBoldWhite(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 20.0,
      color: Colors.white,
    );
  }

  static TextStyle headingSemiBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 18.0,
    );
  }

  static TextStyle subHeading(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
    );
  }

  static TextStyle subHeading2(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 14.0,
    );
  }

  static TextStyle subHeadingWhite(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 17.0,
      color: Colors.white,
    );
  }

  static TextStyle subHeadingGrey(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
      color: Color(0xFF8C8C8C),
    );
  }

  static TextStyle smallHeadingGrey(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 13.0,
      color: Color(0xFF8C8C8C),
    );
  }

  static TextStyle subHeadingYellow(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
      color: Color(0xffFFD331),
    );
  }

  static TextStyle coursePlanText(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
      decoration: TextDecoration.underline,
    );
  }
}