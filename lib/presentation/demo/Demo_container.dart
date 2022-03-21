import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/demo_model.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DemovideoVeiw.dart';

class DemoContainer extends StatefulWidget {
  final List<Datum> demoList;
  final int index;
  const DemoContainer(this.demoList,this.index) : super();

  @override
  _DemoContainerState createState() => _DemoContainerState();
}

class _DemoContainerState extends State<DemoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: AppColors.amber,
            margin: EdgeInsets.all(5),
     child: Padding(
       padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
       child: Row(
         children: [
           Container(
               width: Dimensions.AppTutorialImageWidth,
               height: Dimensions.AppTutorialImageHeight,
               // child: Image.network(AppConstants.BANNER_BASE+widget.demoList[widget.index].bannerPath.toString(), fit: BoxFit.fill)
               child: AppConstants.image(AppConstants.BANNER_BASE+widget.demoList[widget.index].logoPath.toString(), boxfit: BoxFit.fill)
           ),
           SizedBox(width: 10),
           Flexible(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(widget.demoList[widget.index].subjectId!.title.toString()+' || '+widget.demoList[widget.index].title.toString(),overflow: TextOverflow.ellipsis, maxLines: 2,),
                 SizedBox(height: 25,),
                 Row(
                   children: [
                     Container(
                       width: Dimensions.AppTutorialImageHeight,
                       height: 25,
                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:AppColors.dark),
                       child: MaterialButton(

                         child: Row(
                           children: [
                             Icon(Icons.play_arrow, color: AppColors.white,size: 10,),
                             Text(getTranslated(context, StringConstant.watch)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white))
                           ],
                         ),
                         onPressed: () {
                           // showDialog(
                           //   context: context,
                           //   builder: (BuildContext context) => _speedDialog(context),
                           // );
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) =>DemoViedoView(widget.demoList[widget.index])));
                         },
                       ),
                     ),
                     // SizedBox(width: 5,),
                     // Container(
                     //   //width: Dimensions.AppTutorialImageHeight,
                     //   height: 25,
                     //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8),),color:Color(0xFF1c1d3b)),
                     //   child: MaterialButton(
                     //
                     //     child:
                     //         Text(getTranslated(context, StringConstant.viewPdf)!, style: new TextStyle(fontSize: 10.0, color: AppColors.white)),
                     //
                     //     onPressed: () {
                     //       // Navigator.push(
                     //       //     context,
                     //       //     MaterialPageRoute(
                     //       //         builder: (context) => AppTutorialVideo(widget.list[widget.index].videoPath.toString(),
                     //       //             widget.list[widget.index].title.toString())));
                     //     },
                     //   ),
                     // ),
                   ],
                 ),
               ],
             ),
           )
         ],
       ),
     ),
    );
  }
  Widget _speedDialog(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.only(top: 0, ),
      contentPadding: EdgeInsets.only(top: 0, ),
      //insetPadding: EdgeInsets.symmetric(horizontal: 1),
     // title: const Text('Popup example'),
      content: Column(

        mainAxisSize: MainAxisSize.min,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(color: AppColors.amber,height: 30,width: MediaQuery.of(context).size.width,
          alignment: Alignment.topRight,
          child: InkWell(onTap:(){
            Navigator.pop(context);
          },child:  Icon(Icons.close,color: AppColors.white,),
          ),
          ),
          SizedBox(height: 10,),
          CustomButton(navigateTo:  DemoViedoView(widget.demoList[widget.index]),title: '480p',),
          SizedBox(height: 10,),
          CustomButton(navigateTo:  DemoViedoView(widget.demoList[widget.index]),title: '360p',),
          SizedBox(height: 10,),
          CustomButton(navigateTo: DemoViedoView(widget.demoList[widget.index]),title: '240p',),
          SizedBox(height: 10,),
          CustomButton(navigateTo:  DemoViedoView(widget.demoList[widget.index]),title: '140p',),
          SizedBox(height: 10,),
          CustomButton(navigateTo:  DemoViedoView(widget.demoList[widget.index]),title: getTranslated(context, StringConstant.audioOnly)!,),
          SizedBox(height: 10,),

        ],
      ),

      // actions: <Widget>[
      //   new FlatButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     textColor: Theme.of(context).primaryColor,
      //     child: const Text('Close'),
      //   ),
      // ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? image;
  final String? title;
  final Widget? navigateTo;
  final Color? color;

  CustomButton(
      {@required this.image,
        @required this.title,
        @required this.navigateTo,
        this.color});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 60;
    return InkWell(
      onTap: () {  Navigator.pop(context);
        Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo!));},
      child: Container(
        width: width / 2,
        height: 40,
       // alignment: Alignment.center,
        //padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: AppColors.amber),
        child:

                Center(
                  child: new Text(
                    title!,
                    style: TextStyle(color: AppColors.white),
                  ),
                ))


    );
  }
}