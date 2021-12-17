import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  List a =['Police Exam','Up Police ','SSC','Teaching'];
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
                        "Select Categorires",
                        style: CustomTextStyle.headingBigBold(context),
                      )),

                ],
              ))),
      body: GridView.count(crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 8.0,
         children:List.generate(a.length,(index)
          {
        return Container(
          margin: EdgeInsets.all(20),
          height: 50,
          width: 200,
          color: Colors.amber,
          child: Center(child: Text(a[index])),
        );

          }
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.amber,
            //border: Border.all( color: Colors.amber,),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //
            ),
          ),

          child: Center(child: Text('save',style: TextStyle(color: Colors.white,fontSize: 20),)),
        ),
      ),
    );
  }
}
