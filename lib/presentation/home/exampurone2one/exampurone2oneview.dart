import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

import 'one2oneviewlist.dart';

class Exampuron2oneView extends StatefulWidget {
  const Exampuron2oneView({Key? key}) : super(key: key);

  @override
  _Exampuron2oneViewState createState() => _Exampuron2oneViewState();
}

class _Exampuron2oneViewState extends State<Exampuron2oneView> {
  List<ChooseOne2oneModel> a = [
    ChooseOne2oneModel("Agra",  Images.testseries),
    ChooseOne2oneModel("Kanpur",  Images.testseries),
    ChooseOne2oneModel("Lucknow",  Images.testseries),
    ChooseOne2oneModel("Meerut", Images.testseries),
    ChooseOne2oneModel("Mukherjee nagar",  Images.testseries),
    ChooseOne2oneModel("Patna",  Images.testseries),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('Exampur One2One',
                style: CustomTextStyle.headingBold(context),
              ),
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
                        boxShadow:const [
                          BoxShadow(
                            color: Colors.grey,
                            offset:  Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 4.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        color: Theme.of(context).backgroundColor,
                      ),
                      child:ListTile(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => One2onelist()));
                          },
                          leading: Image.asset(a[index].image,height: 40,width: 60,),
                          title: Text(a[index].place,style:CustomTextStyle.headingBold(context),),
                          trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: Colors.black,)
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
class ChooseOne2oneModel {
  late String place;
  String image;

  ChooseOne2oneModel(this.place,  this.image);
}