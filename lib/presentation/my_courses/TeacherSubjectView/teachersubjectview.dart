import 'package:exampur_mobile/presentation/my_courses/TeacherSubjectView/selectchapterview.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class TeacherSubjecjectView extends StatelessWidget {
  const TeacherSubjecjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Chapter',style: TextStyle(fontSize: 25),),
            ListView.builder(itemCount: 5,
            shrinkWrap: true,
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
                                builder: (context) =>SelectChapterView()));
                      },
                      leading: Image.asset(Images.exampur_logo,height: 40,width: 60,),
                      // leading: Image.network(AppConstants.BANNER_BASE+one2oneList[index].logoPath.toString(),height: 40,width: 60,),
                      //leading: AppConstants.image(AppConstants.BANNER_BASE+one2oneList[index].logoPath.toString(),height: 40.0, width: 60.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Example',style:CustomTextStyle.drawerText(context),),
                          // Text(one2oneList[index].description.toString(),style:CustomTextStyle.drawerText(context),),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_sharp,size: 18,color: AppColors.black,)
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
