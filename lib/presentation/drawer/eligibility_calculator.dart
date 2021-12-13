import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EligibilityCalculator extends StatefulWidget {
  EligibilityCalculator({
    Key? key,
  }) : super(key: key);

  @override
  _EligibilityCalculatorState createState() => _EligibilityCalculatorState();
}

class _EligibilityCalculatorState extends State<EligibilityCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: Text("Logo", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Eligibilty Calcultoe",
                          style: CustomTextStyle.headingBold(context),
                        ))
                  ],
                ))),
        body: SingleChildScrollView(
            child: Column(
          children: [Text("eleifinl")],
        )));
  }
}
