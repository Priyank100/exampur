import 'package:exampur_mobile/data/model/on2one_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
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
  List<One2oneModel> list = [];
  @override
  void initState() {
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: ' Batch Class',teacher: 'Sheetal mam'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: ' Foundation Batch Class',teacher: 'Sheetal mam'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: 'Foundation Batch Class',teacher: 'Sheetal mam'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: 'Foundation Batch Class',teacher: 'Sheetal mam'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: 'Batch Class'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: 'Batch Class'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: '15 Days Free Foundation Batch Class'));
    list.add(One2oneModel(
        videoPath: 'https://www.youtube.com/watch?v=ZoOwI3P5POo',
        imagePath: Images.img_dummy,
        title: 'Foundation Batch Class'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: list.length == 0
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
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
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow:const [
                            BoxShadow(
                              color: Colors.grey,
                              offset:  Offset(
                                0.0,
                                0.0,
                              ),
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                          color: Theme.of(context).backgroundColor,
                        ),
                        child:ListTile(
                          contentPadding: EdgeInsets.all(8),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => One2onelist(list,index)));
                            },
                            leading: Image.asset(list[index].imagePath.toString(),height: 40,width: 60,),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(list[index].title.toString(),style:CustomTextStyle.drawerText(context),),
                                Text(list[index].teacher.toString(),style:CustomTextStyle.drawerText(context),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: Colors.black,)
                        ),
                      ),
                    );
                  })
            ],
        ),
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