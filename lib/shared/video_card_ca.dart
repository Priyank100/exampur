import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCardCA extends StatefulWidget {
  @override
  _VideoCardCAState createState() => _VideoCardCAState();
}

class _VideoCardCAState extends State<VideoCardCA> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
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
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                    width: double.infinity,
                    height: 200,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://www.w3.org/TR/wai-aria-practices/examples/carousel/images/lands-endslide__800x600.jpg"),
                      placeholder: AssetImage("assets/images/no_image.jpg"),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/no_image.jpg',
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ufsdn fwiuh dfiuewh hfew efiuewwe fiu efbwiefewf iuewbfwe fewiufhewf",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('gvhxsbvxs'),
                    Column(
                      children: [
                        RaisedButton(onPressed: (){},child: Text('View details',style: TextStyle(color: Colors.white)),color: Colors.amber,),
                        RaisedButton(onPressed: (){},child: Text('Buy Course',style: TextStyle(color: Colors.white),),color: Colors.amber),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Image.asset(Images.share,height: 20,width: 20,),
                            SizedBox(width: 5,),
                            Text('Share')
                          ],
                        ),

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
