// import 'package:exampur_mobile/data/model/DummyModel.dart';
import 'package:exampur_mobile/data/model/dummy_model.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeachingContainer extends StatefulWidget {
  final List<DummyModel> list;
  final int index;
  const  TeachingContainer (this.list, this.index) : super();

  @override
  _TeachingContainerState createState() => _TeachingContainerState();
}

class _TeachingContainerState extends State<TeachingContainer> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              AppConstants.printLog("tapped");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all( Radius.circular(10),
                    // bottomRight: Radius.circular(20),
                    // bottomLeft: Radius.circular(20),
                  ),
                  child: Container(
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                    width: double.infinity,
                    height: 200,
                    // child: FadeInImage(
                    //   fit: BoxFit.cover,
                    //   image: NetworkImage(
                    //       "https://www.w3.org/TR/wai-aria-practices/examples/carousel/images/lands-endslide__800x600.jpg"),
                    //   placeholder: AssetImage(Images.noimage),
                    //   imageErrorBuilder: (context, error, stackTrace) {
                    //     return Image.asset(
                    //       Images.noimage,
                    //     );
                    //   },
                    // ),
                    child: Image.asset(widget.list[widget.index].imagePath.toString()),
                  ),
                ),


                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.list[widget.index].title.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  Text(
                                    widget.list[widget.index].target.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),

                            ClipOval(
                              child: Image.asset(
                               Images.exampur_logo,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),


                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context,int index){
                              return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        RowTile(title: 'jhgcf', ),

                                      ],
                                    );
                        }),
                      ),

                      Column(
                        children: [
                          Container(height: 30,width: 120,decoration: BoxDecoration( color: Color(0xFF060929),
                            borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text('View details',style: TextStyle(color: Colors.white)))),
                          SizedBox(height: 10,),
                          Container(height: 30,width: 110,decoration: BoxDecoration( color: Color(0xFF060929),
                              borderRadius: BorderRadius.all(Radius.circular(8))),child: Center(child: Text('Buy Course',style: TextStyle(color: Colors.white)))),

                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Image.asset(Images.share,height: 20,width: 20,),
                              SizedBox(width: 5,),
                              Text('Share')
                            ],
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),

                    ],),
                ),
                // Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           bottomLeft: Radius.circular(10),
                //           bottomRight: Radius.circular(10)),
                //       color: Theme.of(context).primaryColor,
                //     ),
                //     height: 40,
                //     child: Center(child: Text("Watch Now")))
              ],
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}

class RowTile extends StatelessWidget {

  final String title;
  const RowTile({required this.title}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(children: [
        Icon(Icons.done,color: Colors.amber,),
        SizedBox(width: 5,),
        Text(title),


      ],),
    );
  }
}
