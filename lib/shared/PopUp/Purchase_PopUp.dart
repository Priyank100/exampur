import 'package:carousel_slider/carousel_slider.dart';
import 'package:exampur_mobile/data/datasource/remote/http/services.dart';
import 'package:flutter/material.dart';
import '../../Localization/language_constrants.dart';
import '../../presentation/home/paid_courses/paid_courses.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/images.dart';
import '../../utils/lang_string.dart';

class PurschaseAlertBox{
  int layer = 1;
  String selection1 = '';
  String selection2 = '';
  String selection3 = '';
  bool loading = false;
  TextEditingController messageController = TextEditingController();
  CarouselController buttonCarouselController = CarouselController();

  PurchaseAlert(BuildContext context){
    showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                scrollable: true,
                // contentPadding: EdgeInsets.zero,
                backgroundColor: Color(0xff5F2A7E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content:Container(
                  height: 550,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          layer == 1 || layer == 5 ? SizedBox():
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: (){
                                    // print(layer);
                                    switch (layer){
                                      case 1:Navigator.pop(context);break;
                                      case 2: layer = 1 ;  buttonCarouselController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.linear);break;
                                      case 3:layer = 3 ;
                                      selection2='';
                                      messageController.text = '';
                                      buttonCarouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);break;
                                    }
                                    setState((){});
                                  },
                                  child: Container(height: 30,width: 30,child: Icon(Icons.keyboard_backspace_rounded),
                                    decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                  ))),
                          layer == 5 ? InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },child: Container(
                            height: 30,width: 30,
                            decoration: new BoxDecoration(
                              color: Color(0xffED2E3D),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.close,color:Color(0xff5F2A7E),),
                          )) : SizedBox(height: 30,)
                        ],),
                      SizedBox(height: 20,),
                      Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                      SizedBox(height: 20,),
                      Container(
                          height:350,
                          child: CarouselSlider(
                              carouselController: buttonCarouselController,
                              options: CarouselOptions(
                                  disableCenter: true,
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  enableInfiniteScroll: false,
                                  viewportFraction: 1,
                                  scrollPhysics: NeverScrollableScrollPhysics()
                              ),
                              items: [
                                firstLayer(context, setState),
                                layer == 2 ? yesUI(context, setState) : noUI1(context, setState),
                                layer == 3 ? noUI2(context,setState) : finalUI1(context, setState)
                              ]
                          )),



                      // layer == 0 ? firstLayer(context, setState) :
                      // layer == 1 ? yesUI(context,setState) :
                      // layer == 2 ? noUI1(context,setState) :
                      // layer == 3 ? noUI2(context,setState) :
                      // layer == 4 ? finalUI(context, setState) : SizedBox()
                    ],
                  ),
                ),
              );
            }
        )
    );
  }

  Widget firstLayer(context, setState) {
    List <String>  dataList = [
      'Yes, Facing issue in the payment',
      'No, I will purchase later',
    ];
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Text('You have not completed the payment. Are you facing any issue',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
        SizedBox(height: 20,),
        ListView.builder(
            itemCount: dataList.length,
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx , i){
              return
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearButton(
                      titleText: dataList[i],
                      onpressed: (){
                        if(dataList[i] == 'Yes, Facing issue in the payment'){
                          layer = 3;
                          buttonCarouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                        } else{
                          layer = 2;
                          buttonCarouselController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                        }
                        selection1 = dataList[i];
                        setState((){});
                      }
                  ),
                );
            }),
      ],
    );
  }

  Widget yesUI(context,setState){
    List <String>  YesdataList = [
      'In next 2-3 hours',
      'Tomorrow',
      '2-3 dino ke baad',
      'Facing some issue in app '
    ];
    return Column(
      children: [
        Text('Till Now, You have not purchased,By when you are planning to purchase ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
        SizedBox(height: 20,),
        loading ? CircularProgressIndicator() :  ListView.builder(
            itemCount: YesdataList.length,
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx , i){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearButton(titleText: YesdataList[i],onpressed: (){
                  selection2 = YesdataList[i];
                 submitFormfeedback(context, setState);
                }),
              );
            }),

      ],
    );
  }

  Widget noUI1(context,setState) {
    List <String>  nodataList = [
      'Forgot my UPI id',
      'Issue 2',
      'Issue 3',
      'Other issue'
    ];
    return   Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Please select the issue, we will connect with you to solve it ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
        SizedBox(height: 20,),
        loading ? CircularProgressIndicator() :  ListView.builder(
            itemCount: nodataList.length,
            padding: EdgeInsets.zero,
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx , i){
              return Padding(
                padding: const EdgeInsets.all(8),
                child: LinearButton(titleText: nodataList[i],onpressed: (){
                    selection2 = nodataList[i];
                    layer = 3;
                    buttonCarouselController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  setState((){});
                }),
              );
            }),

      ],
    );
  }

  Widget noUI2(context, setState){
    return Column(children: [
      Text('Please explain your issue',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
      SizedBox(height: 30,),
      Container(
        height: 60,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all()
        ),
        child: TextField(
          maxLines: 4,
          controller: messageController,
          decoration: InputDecoration(
            hintText:'',
            hintStyle: TextStyle(
              color: AppColors.grey300,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            isDense: true,
            counterText: '',
            errorStyle: TextStyle(height: 1.5),
            border: InputBorder.none,
          ),
        ),
      ),
      SizedBox(height: 20,),
      loading ? CircularProgressIndicator() : InkWell(
        onTap: (){
          if(messageController.text.isEmpty) {
            // print('anchal');
            AppConstants.showAlertDialog(
              context, 'Please fill the message',
            );
          }else{
           submitFormfeedback(context,setState);
          }},
        child: Container(height: 40,width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red
          ),
          alignment: Alignment.center,
          child:Text('Submit',style: TextStyle(color: Colors.white),),),
      ),
    ],);

  }

  Widget finalUI1(context, setState){
    return Column(children: [
      Image.asset(Images.Done,height: 150,),
      SizedBox(height: 30,),
      Text('Thank You for your input, we will call you',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Noto Sans'),),
      SizedBox(height: 40,),
      LinearButton(titleText: 'Retry Purchase',onpressed: (){
        Navigator.pop(context);
      }),
    ]);
  }

  Widget finalUI2(context, setState){
    return Column(children: [
      Image.asset(Images.Done,height: 150,),
      SizedBox(height: 30,),
      Text('Thank You for your input',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Noto Sans'),),
      SizedBox(height: 40,),
      Text('Purchase Now',style: TextStyle(fontFamily: 'Noto Sans'),),
      LinearButton(titleText: 'Home',onpressed: (){
        Navigator.pop(context);
      }),
    ]);
  }


  Future<void> submitFormfeedback(context, setState) async {
   // setState((){loading = true;});
    var body = {
      "user": {
        "name": AppConstants.userName,
        "email": AppConstants.Email,
        "mobile": AppConstants.userMobile
      },
      "device": {
        "model": AppConstants.deviceModel,
        "make": AppConstants.deviceMake,
        "os": AppConstants.deviceOS
      },
      "app": {
        "version_name": AppConstants.versionName,
        "version_code": AppConstants.versionCode
      },
      "type": "purchase-drop",
      "selection_one": selection1,
      "selection_two": selection2,
      "selection_three": selection3,
      "message": messageController.text.trim()
    };
    Map<String, String> header = {
      "x-auth-token": AppConstants.serviceLogToken,
      "Content-Type": "application/json",
      "app-version":AppConstants.versionCode
    };
  // print(body);
    // await Service.post(API.serviceLogUrl, body: body, myHeader: header).then((response) async {
    //   loading = false;
    //   if (response == null) {
    //     AppConstants.showBottomMessage(context,
    //         getTranslated(context,
    //             LangString.serverError)!,
    //         AppColors.red);
    //   } else {
    //     if (response.statusCode == 200) {
    //       layer = 5;
    //       buttonCarouselController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.linear);
    //     } else {
    //       AppConstants.showBottomMessage(
    //           context, 'Something went wrong',
    //           AppColors.red);
    //     }
    //   }
    //   setState((){});
    // });
  }

}

class LinearButton extends StatefulWidget {
  final String titleText;
  final VoidCallback onpressed;
  const LinearButton({Key? key,required this.titleText,required this.onpressed}) : super(key: key);

  @override
  State<LinearButton> createState() => _LinearButtonState();
}

class _LinearButtonState extends State<LinearButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpressed,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Color(0xff9C66FF), Color(0xffED2E3D)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(widget.titleText,style: TextStyle(fontFamily:'Poppins',color: Colors.white,fontSize: 15),textAlign: TextAlign.center,),
      ),
    );
  }
}
