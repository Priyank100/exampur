import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';
import 'images.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar() : preferredSize = Size.fromHeight(kToolbarHeight), super();

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Image.asset(Images.exampur_title,
        width: Dimensions.ICON_SIZE_Title,
        height: Dimensions.ICON_SIZE_Title,
      ),
  );
  }
}
