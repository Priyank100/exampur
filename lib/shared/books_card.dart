import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/presentation/widgets/custom_button.dart';
import 'package:exampur_mobile/presentation/widgets/custom_smaller_button.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksCard extends StatefulWidget {
  // String subject;
  // String name;
  //
  // BooksCard({
  //   Key? key,
  //   required this.subject,
  //   required this.name,
  // }) : super(key: key);
  final List<DummyModel> list;
  final int index;
  const  BooksCard(this.list, this.index) : super();
  @override
  _BooksCardState createState() => _BooksCardState();
}

class _BooksCardState extends State<BooksCard> {
  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: EdgeInsets.all(25),
    //   child: Material(
    //     elevation: 10,
    //     shadowColor: Colors.black,
    //     borderRadius: BorderRadius.all(
    //       Radius.circular(20),
    //     ),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Colors.white10,
    //         border: Border.all(
    //           color: Colors.white24,
    //           width: 2,
    //         ),
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(20),
    //         ),
    //       ),
    //       child: Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           children: [
    //             Container(
    //               height: MediaQuery.of(context).size.width * 0.7 * 9 / 16,
    //               width: MediaQuery.of(context).size.width * 0.7,
    //               child: Image(
    //                 image: AssetImage(Images.studymaterial),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                 horizontal: 12.0,
    //                 vertical: 2,
    //               ),
    //               child: Flexible(
    //                 child: Text(
    //                   widget.name,
    //                   maxLines: 3,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 26,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 15,
    //             ),
    //             CustomElevatedButton(
    //               onPressed: () {},
    //               text: "Buy Now",
    //             ),
    //             SizedBox(height: 15,),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Image.asset(Images.share,height: 15,width: 20,),
    //                 // Icon(
    //                 //   Icons.share,
    //                 //   size: 23,
    //                 //   color: Colors.black,
    //                 // ),
    //                 SizedBox(
    //                   width: 8,
    //                 ),
    //                 Text(
    //                   "Share",
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 16,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 10,
    //                 ),
    //               ],
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
     // height: 250,
      decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
        boxShadow:const [
          BoxShadow(
            color: Colors.grey,
            offset:  Offset(
              0.0,
              0.0,
            ),
            blurRadius: 1.79,
            spreadRadius: 0.0,
          ),
        ],
            ),
      child: Column(
        children: [
Image.asset(widget.list[widget.index].imagePath.toString()),
          SizedBox(height: 10,),
          Text(widget.list[widget.index].title.toString(),softWrap: true,style: TextStyle(fontSize: 18),),
          Text(widget.list[widget.index].target.toString(),softWrap: true,style: TextStyle(fontSize: 18),),
      SizedBox(height: 10,),
      CustomElevatedButton(
                      onPressed: () {},
                      text: "Buy Now",
                    ),
          SizedBox(height: 10,),
      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Images.share,height: 15,width: 20,),
                        // Icon(
                        //   Icons.share,
                        //   size: 23,
                        //   color: Colors.black,
                        // ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
