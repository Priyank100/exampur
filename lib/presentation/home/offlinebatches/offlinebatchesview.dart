import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfflineBatches extends StatefulWidget {
  OfflineBatches({
    Key? key,
  }) : super(key: key);

  @override
  _OfflineBatchesState createState() => _OfflineBatchesState();
}

class _OfflineBatchesState extends State<OfflineBatches> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow:const [
            BoxShadow(
              color: Colors.grey,
              offset:  Offset(
                0.0,
                0.0,
              ),
              blurRadius: 4.0,
              spreadRadius: 0.0,
            ),
          ],
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width * 0.25,
                      //flex: 1,
                      child: FadeInImage(
                        image: NetworkImage("widget.instance.image"),
                        placeholder: AssetImage("assets/images/no_image.jpg"),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/no_image.jpg',
                          );
                        },
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "fbdsfnjfnwiue fewfhuwe fweouf weuuh feiuf efuie fiuf euhff eiufwe fwiujf",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.all(5),
                                  padding:  EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color:Color(0xFF060929)),
                                    color: Color(0xFF060929)
                                      
                                  ),
                                  child: const Center(
                                      child: Text("View Details",
                                          style: TextStyle(fontSize: 13,color: Colors.white)))),
                              const SizedBox(
                                width: 15,
                              ),



                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.shareAlt,
                                  size: 15,
                                ),
                                SizedBox(width: 5,),
                                Text("Share", style: TextStyle(fontSize: 13))
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
