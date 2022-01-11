

import 'package:exampur_mobile/data/model/one2_one_models.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/provider/One2one_provider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'one2oneviewlist.dart';

class Exampuron2oneView extends StatefulWidget {
  const Exampuron2oneView({Key? key}) : super(key: key);

  @override
  _Exampuron2oneViewState createState() => _Exampuron2oneViewState();
}

class _Exampuron2oneViewState extends State<Exampuron2oneView> {
 List<Courses> one2oneList= [];
  @override
  void initState() {

    super.initState();
    getone2oneList();
  }

  Future<void> getone2oneList() async {
    AppConstants.printLog(one2oneList);
    one2oneList = (await Provider.of<One2OneProvider>(context, listen: false).getOne2OneList(context))!;
    setState(() {});
   // return one2oneList;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:
      one2oneList.length == 0
          ? Center(child: CircularProgressIndicator(color: Colors.amber,))
          :
      SingleChildScrollView(
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
                  itemCount: one2oneList.length,
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
                              blurRadius: 0.95,
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
                                      builder: (context) => One2onelist(one2oneList,index)));
                            },
                            //leading: Image.asset(one2oneList[index].logoPath.toString(),height: 40,width: 60,),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(one2oneList[index].title.toString(),style:CustomTextStyle.drawerText(context),),
                               // Text(one2oneList[index].description.toString(),style:CustomTextStyle.drawerText(context),),
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