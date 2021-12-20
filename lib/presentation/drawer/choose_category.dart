import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class ChooseCategory extends StatefulWidget {
  const ChooseCategory({Key? key}) : super(key: key);

  @override
  _ChooseCategoryState createState() => _ChooseCategoryState();
}

class _ChooseCategoryState extends State<ChooseCategory> {
  List <ChooseCateogryModel> a= [
    ChooseCateogryModel("All Exam","SSC",false),
    ChooseCateogryModel("All Exam","SSC",false),
    ChooseCateogryModel("All Exam","SSC",false),
    ChooseCateogryModel("All Exam","SSC",false),
    ChooseCateogryModel("All Exam","SSC",false),
    ChooseCateogryModel("All Exam","SSC",false),
  ];
List<ChooseCateogryModel>selectedcourse= [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: Colors.black,
//           ),
//           title: Text("Logo", style: TextStyle(color: Colors.black)),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           bottom: PreferredSize(
//               preferredSize: Size.fromHeight(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Text(
//                         "Select Categorires",
//                         style: CustomTextStyle.headingBigBold(context),
//                       )),
//
//                 ],
//               ))),
//
//    body:   Container(
//
//           padding: EdgeInsets.all(10.0),
//           child: GridView.builder(
//             itemCount: a.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 4.0,
//                 mainAxisSpacing: 4.0
//             ),
//             itemBuilder: (BuildContext context, int index){
//               return GestureDetector(
//                 child: Container(
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(10),
//                              color: Colors.amber,
//                            ),
//                            // height: 10,
//                            // width: 200,
//
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children:[
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 18.0,left: 10,right: 10),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(a[index],style: const TextStyle(color: Colors.white),),
//                                     Text('image')
//                                   ],
//                                 ),
//
//                               ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 18.0,left: 10,right: 10),
//                                     child: Text('SSc,upsc'),
//                                   )
//                                 ]),
//                           ),
//               );
//             },
//           )),
//
//
//     bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Container(
//           height: 50,
//           width: 200,
//           decoration: const BoxDecoration(
//             color: Colors.amber,
//             //border: Border.all( color: Colors.amber,),
//             borderRadius: BorderRadius.all(
//                 Radius.circular(5.0) //
//             ),
//           ),
//
//           child: const Center(child: Text(
//             'save', style: TextStyle(color: Colors.white, fontSize: 20),)),
//         ),
//       ),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text("Logo", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Select Categorires",
                        style: CustomTextStyle.headingBigBold(context),
                      )),

                ],
              ))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border:Border.all(color: Colors.grey,width: 2),

                      // gradient: LinearGradient(
                      //     begin: Alignment.centerLeft,
                      //     end: Alignment.centerRight,
                      //     colors: [Colors.purple, Colors.purpleAccent]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  child:   TextField(


                        autocorrect: false,

                        onChanged: (s) {

                        },
                        onEditingComplete: () {
                          FocusScope.of(context).nextFocus();
                        },
                        cursorColor: Colors.amber,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Enter state',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          filled: true,
                          fillColor: Colors.grey[300],
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

                Expanded(
                  flex: 8,
                  child: GridView.builder(
              itemCount: a.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0
              ),
                      itemBuilder: (BuildContext context, int index) {
                        // return item
                        return ContactItem(
                         a[index].name,
                         a[index].course,
                         a[index].isSelected,
                          index,
                        );
                      }),
                ),
                selectedcourse.length > 0 ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  // child: SizedBox(
                  //   width: double.infinity,
                    child:Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.amber,

            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //
            ),
          ),

          child:  Center(child: Text(
              "Save (${selectedcourse.length})",style: TextStyle(color: Colors.white, fontSize: 20),)),
        ),


                ): Container( height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    //border: Border.all( color: Colors.amber,),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0) //
                    ),
                  ),

                  child:  Center(child: Text(
                    "Save the course",style: TextStyle(color: Colors.white, fontSize: 20),)),),
              ],
            ),
          ),
        ),
      ),

    );
  }
  Widget ContactItem(
      String name, String phoneNumber, bool isSelected, int index) {
  // return  GestureDetector(
  //   onTap: (){
  //     setState(() {
  //       a[index].isSelected = !a[index].isSelected;
  //       if (a[index].isSelected == true) {
  //         selectedcourse.add(ChooseCateogryModel(a[index].name, a[index].course, true));
  //       } else if (selectedcourse[index].isSelected == false) {
  //         selectedcourse
  //             .removeWhere((element) => element.name == a[index].name);
  //       }
  //     });
  //   },
    // child: Container(
    //
    //                          decoration: BoxDecoration(
    //                            border: isSelected?Border.all(color: Colors.amber,
    //                              width: 1,):null,
    //                            borderRadius: BorderRadius.circular(10),
    //                            //color: Colors.amber,
    //                          ),
    //
    //
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children:[
    //                             Padding(
    //                               padding: const EdgeInsets.only(top: 18.0,left: 10,right: 10),
    //                               child: Row(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   Text(name,style: const TextStyle(color: Colors.black),),
    //                               CircleAvatar(
    //                                     backgroundColor: Colors.green[700],
    //                                     child: Icon(
    //                                       Icons.person_outline_outlined,
    //                                       color: Colors.white,
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //
    //                             ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.only(top: 18.0,left: 10,right: 10),
    //                                   child: Text('SSc,upsc'),
    //                                 )
    //                               ]),
    //
    //             ),
 return
 Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
    setState(() {
    a[index].isSelected = !a[index].isSelected;
    if (a[index].isSelected == true) {
    selectedcourse.add(ChooseCateogryModel(a[index].name, a[index].course, true));
    } else if (selectedcourse[index].isSelected == false) {
    selectedcourse
        .removeWhere((element) => element.name == a[index].name);
    }
    });

            },
            child: Container(

              child: Padding(
                padding: const EdgeInsets.only(left: 15.0,top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [


                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 18.0,fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),

                              // Text(
                              //  'ssc' ,
                              //   style: TextStyle(
                              //     fontSize: 18.0,
                              //     color: Colors.white,
                              //   ),
                              // ),

                        SizedBox(width: Dimensions.FONT_SIZE_EXTRA_LARGE,),
                        Image.asset(

                          Images.paidcourse,
                          height: 45.0,

                        ),
                      ],
                    ),
                    Text(
                     'ssc' ,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              height: 80.0,
              decoration: BoxDecoration(
    border: isSelected?Border.all(color: Colors.amber,
                                 width: 3,):null,

              boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
              ],
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade200,

              ),
            ),
          ),
        );
    // return ListTile(
    //   leading: CircleAvatar(
    //     backgroundColor: Colors.green[700],
    //     child: Icon(
    //       Icons.person_outline_outlined,
    //       color: Colors.white,
    //     ),
    //   ),
    //   title: Text(
    //     name,
    //     style: TextStyle(
    //       fontWeight: FontWeight.w500,
    //     ),
    //   ),
    //   subtitle: Text(phoneNumber),
    //   trailing: isSelected
    //       ? Icon(
    //     Icons.check_circle,
    //     color: Colors.green[700],
    //   )
    //       : Icon(
    //     Icons.check_circle_outline,
    //     color: Colors.grey,
    //   ),
    //   onTap: () {
    //     setState(() {
    //       a[index].isSelected = !a[index].isSelected;
    //       if (a[index].isSelected == true) {
    //         selectedcourse.add(ChooseCateogryModel(name, phoneNumber, true));
    //       } else if (selectedcourse[index].isSelected == false) {
    //         selectedcourse
    //             .removeWhere((element) => element.name == a[index].name);
    //       }
    //     });
    //   },
    // );

  }
}


class ChooseCateogryModel{
  String name,course;
  bool isSelected;
  ChooseCateogryModel(this.name,this.course,this.isSelected);
}