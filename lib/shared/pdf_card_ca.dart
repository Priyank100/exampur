import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PDFCardCA extends StatefulWidget {
  PDFCardCA({
    Key? key,
  }) : super(key: key);

  @override
  _PDFCardCAState createState() => _PDFCardCAState();
}

class _PDFCardCAState extends State<PDFCardCA> {

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(64, 64, 64, 0.12), blurRadius: 16)
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
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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
                                  width: 80,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Center(
                                      child: Text("View PDF",
                                          style: TextStyle(fontSize: 13)))),
                              SizedBox(
                                width: 15,
                              ),


                              FaIcon(
                                FontAwesomeIcons.shareAlt,
                                size: 15,
                              ),
                              SizedBox(width: 5,),
                              Text("Share", style: TextStyle(fontSize: 13))
                            ],
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
