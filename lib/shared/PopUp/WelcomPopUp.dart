import 'package:exampur_mobile/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/images.dart';

class AlertBox{
  static WelcomeAlert1(BuildContext context){
    List <String>  dataList = [
      'Yes, I want to Purchase NOTES',
      'Yes, I want to Purchase COURSE',
      'No, I don’t want to purchase',
    ];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0xff5F2A7E),
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          height: 500,
         // width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
              SizedBox(height: 50,),
              Text('Do you want to purchase PAID COURSE/NOTES from exampur app ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
              SizedBox(height: 40,),
              Container(
                height:  MediaQuery.of(context).size.height/3, // Change as per your requirement
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: dataList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx , i){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearButton(titleText: dataList[i],onpressed: (){
                          if(dataList[i] == 'No, I don’t want to purchase'){
                            //Navigator.pop(context);
                            AlertBox.WelcomeAlert4(context);
                          }
                          else{
                            AlertBox.WelcomeAlert2(context);
                          }

                        }),
                      );
                    }),
              )
            ],
          ),
        )
      ),
    );
  }
  static WelcomeAlert2(BuildContext context){
    List <String>  dataList = [
      'In next 2-3 hours',
      'Tomorrow',
      '2-3 dino ke baad',
      'Facing some issue in app '
    ];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff5F2A7E),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 500,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Align(
                alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },child: Container(height: 30,width: 30,child: Icon(Icons.keyboard_backspace_rounded),color: Colors.white,))),
                SizedBox(height: 10,),
                Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                SizedBox(height: 50,),
                Text('Do you want to purchase PAID COURSE/NOTES from exampur app ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
                SizedBox(height: 40,),
                Container(
                  height:  MediaQuery.of(context).size.height/3, // Change as per your requirement
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: dataList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx , i){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearButton(titleText: dataList[i],onpressed: (){
                            AlertBox.WelcomeAlert3(context);
                          }),
                        );
                      }),
                )
              ],
            ),
          )
      ),
    );
  }
  static WelcomeAlert3(BuildContext context){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff5F2A7E),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 500,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },child: Container(height: 30,width: 30,child: Icon(Icons.keyboard_backspace_rounded),color: Colors.white,)),
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },child: Container(
                    height: 30,width: 30,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close),
                   ))
                ],),
                SizedBox(height: 20,),
                Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                SizedBox(height: 50,),
                // Text('Do you want to purchase PAID COURSE/NOTES from exampur app ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
                // SizedBox(height: 30,),
                Image.asset(Images.Done,height: 150,),
                SizedBox(height: 30,),
                Text('Thank You for your input',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Noto Sans'),),
                SizedBox(height: 40,),
                LinearButton(titleText: 'Purchase Now',onpressed: (){
                  },),
              ],
            ),
          )
      ),
    );
  }
  static WelcomeAlert4(BuildContext context){
    List <String>  dataList = [
      'Course Not available',
      'I want to watch free videos only',
      'I want to attempt free test only',
      'I will purchase after notification'
    ];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff5F2A7E),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 550,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },child: Container(height: 30,width: 30,child: Icon(Icons.keyboard_backspace_rounded),color: Colors.white,))),
                SizedBox(height: 10,),
                Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                SizedBox(height: 50,),
                Text('Can you please tell me the reason?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
                SizedBox(height: 40,),
                Container(
                  height:  MediaQuery.of(context).size.height/3, // Change as per your requirement
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: dataList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx , i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearButton(titleText: dataList[i],onpressed: (){
                        if(dataList[i] == 'Course Not available'||dataList[i] == 'I will purchase after notification'){
                         // Navigator.pop(context);
                          AlertBox.WelcomeAlert5(context);
                        }
                        else{
                          AlertBox.WelcomeAlert3(context);
                        }
                      }),
                    );
                  }),
                )
              ],
            ),
          )
      ),
    );
  }
  static WelcomeAlert5(BuildContext context){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          backgroundColor: Color(0xff5F2A7E),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            height: 500,
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },child: Container(height: 30,width: 30,child: Icon(Icons.keyboard_backspace_rounded),color: Colors.white,)),
                  ],),
                SizedBox(height: 20,),
                Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                SizedBox(height: 50,),
                Text('You are preparing for which exam?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
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
                    //controller: messageController,
                    onTap: (){
                      // Timer(Duration(milliseconds: 200),(){
                      //   _controller.jumpTo(_controller.position.maxScrollExtent);
                      // });
                      // setState(() {});
                    },
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
               InkWell(
                 onTap: (){
                   AlertBox.WelcomeAlert3(context);
                 },
                 child: Container(height: 40,width: 200,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.red
                   ),
                   alignment: Alignment.center,
                   child: Text('Submit',style: TextStyle(color: Colors.white),),),
               )
              ],
            ),
          )
      ),
    );
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

