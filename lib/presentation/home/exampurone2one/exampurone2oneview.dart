

import 'package:exampur_mobile/Localization/language_constrants.dart';
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
 List<One2OneCourses> one2oneList= [];
 bool isLoading = false;
 bool isBottomLoading = false;
 int page =0;
 var scrollController =ScrollController();
 bool isData =true;

  @override
  void initState() {
scrollController.addListener(pagination);
    getone2oneList(page);
    super.initState();
  }

  Future<void> getone2oneList(pageNo) async {
isLoading=true;
   // one2oneList=   (await Provider.of<One2OneProvider>(context, listen: false).getOne2OneList(context,pageNo))!;
    List<One2OneCourses> list  = (await Provider.of<One2OneProvider>(context, listen: false).getOne2OneList(context,pageNo))!;
    if(list.length > 0) {
      isData = true;
      one2oneList = one2oneList + list;
    } else {
      isData = false;
    }
    isLoading = false;
    isBottomLoading=false;
    setState(() {});
   // return one2oneList;

  }

  void pagination(){
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      setState(() {
        if(isData){
          page +=1;
          AppConstants.printLog(page.toString());
        }
        isBottomLoading= true;
        getone2oneList(page);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body:isLoading?Center(child: CircularProgressIndicator(color: Colors.amber,)):
      one2oneList.length == 0
          ? AppConstants.noDataFound()
          :
      SingleChildScrollView(
        controller: scrollController,
            child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(getTranslated(context, StringConstant.exampurOne2one)!,
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
                              color: AppColors.grey,
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
                                      builder: (context) => One2onelist(one2oneList[index])));
                            },
                            // leading: Image.network(AppConstants.BANNER_BASE+one2oneList[index].logoPath.toString(),height: 40,width: 60,),
                            leading: AppConstants.image(AppConstants.BANNER_BASE+one2oneList[index].logoPath.toString(),height: 40.0, width: 60.0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(one2oneList[index].title.toString(),style:CustomTextStyle.drawerText(context),),
                               // Text(one2oneList[index].description.toString(),style:CustomTextStyle.drawerText(context),),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: AppColors.black,)
                        ),
                      ),
                    );
                  }),
            ],
        ),
      ),
          ),
      bottomNavigationBar: isBottomLoading?Container(height:40,width: 40,child:Center(child: CircularProgressIndicator(color: Colors.amber,),)):SizedBox()
    );
  }
}
class ChooseOne2oneModel {
  late String place;
  String image;

  ChooseOne2oneModel(this.place,  this.image);
}