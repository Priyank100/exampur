
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

import 'offlinebatchesexam.dart';

class OfflineCourse extends StatefulWidget {
  const OfflineCourse({Key? key}) : super(key: key);

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  List<ChooseOfflineModel> a = [
    ChooseOfflineModel("Agra",  Images.testseries),
    ChooseOfflineModel("Kanpur",  Images.testseries),
    ChooseOfflineModel("Lucknow",  Images.testseries),
    ChooseOfflineModel("Meerut", Images.testseries),
    ChooseOfflineModel("Mukherjee nagar",  Images.testseries),
    ChooseOfflineModel("Patna",  Images.testseries),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: InkWell(onTap:(){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Offline Batches',
            style: CustomTextStyle.headingBold(context),
            ),
            SizedBox(height: Dimensions.FONT_SIZE_SMALL,),
            ListView.builder(
              itemCount: a.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(color: Color.fromRGBO(64, 64, 64, 0.12), blurRadius: 16)
                    ],
                    color: Theme.of(context).backgroundColor,
                  ),
                  child:ListTile(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OfflineBatchesExam()));
                    },
                    leading: Image.asset(a[index].image,height: 40,width: 60,),
                    title: Text(a[index].place,style:CustomTextStyle.headingBold(context),),
                    trailing: Icon(Icons.arrow_forward_ios_sharp)
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
class ChooseOfflineModel {
  late String place;
  String image;

  ChooseOfflineModel(this.place,  this.image);
}