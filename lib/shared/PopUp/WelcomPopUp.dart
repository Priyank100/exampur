import 'package:flutter/material.dart';

class AlertBox{

  static WelcomeAlert1(BuildContext context){
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
              LinearButton(titleText: 'Yes, I want to Purchase NOTES',onpressed: (){

                },),
              SizedBox(height: 20,),
              LinearButton(titleText: 'Yes, I want to Purchase COURSE',onpressed: (){}),
              SizedBox(height: 20,),
              LinearButton(titleText: 'No, I don’t want to purchase ',onpressed: (){}),
            ],
          ),
        )
      ),
    );
  }
  static WelcomeAlert2(BuildContext context){
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
                LinearButton(titleText: 'In next 2-3 hours',onpressed: (){}),
                SizedBox(height: 20,),
                LinearButton(titleText: 'Tomorrow',onpressed: (){}),
                SizedBox(height: 20,),
                LinearButton(titleText: '2-3 dino ke baad',onpressed: (){}),
                SizedBox(height: 20,),
                LinearButton(titleText: 'Facing some issue in app ',onpressed: (){}),
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
                SizedBox(height: 40,),
                Text('Welcome to exampur family',style: TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'Noto Sans',fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('Can you please share some details about you',style: TextStyle(fontSize: 12,color: Colors.white,fontFamily: 'Noto Sans'),),
                SizedBox(height: 50,),
                Text('Do you want to purchase PAID COURSE/NOTES from exampur app ?',style: TextStyle(fontSize: 15,color: Colors.white,fontFamily: 'Noto Sans'),textAlign: TextAlign.center,),
                SizedBox(height: 40,),
                LinearButton(titleText: 'Yes, I want to Purchase NOTES',onpressed: (){

                },),
                SizedBox(height: 20,),
                LinearButton(titleText: 'Yes, I want to Purchase COURSE',onpressed: (){}),
                SizedBox(height: 20,),
                LinearButton(titleText: 'No, I don’t want to purchase ',onpressed: (){}),
              ],
            ),
          )
      ),
    );
  }
  static WelcomeAlert4(BuildContext context){
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

