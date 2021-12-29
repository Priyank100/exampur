import 'package:exampur_mobile/shared/couses_container.dart';
import 'package:exampur_mobile/shared/pdf_card_ca.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyCA extends StatefulWidget {
  @override
  _DailyCAState createState() => _DailyCAState();
}

class _DailyCAState extends State<DailyCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ContainerwithBuyandView(image: Images.one2one,title: 'hello nggfyjfugugugugutiuhuyfyuhukyftryghukjfhyjhujy',)
              ],
            ),
          ),
        ));
  }
}
