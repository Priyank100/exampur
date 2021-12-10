import 'package:flutter/material.dart';

// Todo: define all possible texts here

class CustomTextStyle {
  static TextStyle drawerText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
      fontSize: 15.0,
    );
  }

  static TextStyle headingBold(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 20.0,
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


  static TextStyle subHeadingYellow(BuildContext context) {
    return Theme.of(context).textTheme.headline6!.copyWith(
      fontSize: 16.0,
      color: Color(0xffFFD331),
    );
  }

}