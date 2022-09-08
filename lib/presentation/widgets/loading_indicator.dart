import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget LoadingIndicator(BuildContext context) {
  return Center(
    child: Container(
      width: 50,
      height: 50,
      child:  CircularProgressIndicator(
          color: AppColors.amber,
        ),

    ),
  );
}