import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
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
                          "Eligibilty Calculator",
                          style: CustomTextStyle.headingBigBold(context),
                        ))
                  ],
                ))),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(
                    Radius.circular(5.0) //
                ),
              ),
              child: Text('Please enter all the details to calculator your      eligbility for different exam', style: CustomTextStyle.headingSemiBold(context),),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "State",
                  style: CustomTextStyle.headingBigBold(context),
                )),
      SizedBox(height: 25,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: TextField(


          autocorrect: false,

          onChanged: (s) {

          },
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          cursorColor: Colors.amber,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintText: 'Enter state',
            hintStyle: TextStyle(
              color: Colors.grey[600],
            ),
            filled: true,
            fillColor: Colors.grey[300],
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
            Center(
              child: CustomSmallerElevatedButton(
                color: Colors.orange,
                onPressed: () {},
                text: "Next",
              ),
            ),
          ],
        )));
  }
}
