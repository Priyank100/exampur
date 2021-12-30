import 'package:exampur_mobile/data/model/video_ca_model.dart';
import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideosCA extends StatefulWidget {
  final List<VideoCaModel> list;
  const VideosCA(this.list) : super();

  @override
  _VideosCAState createState() => _VideosCAState();
}

class _VideosCAState extends State<VideosCA> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return myCard(index);
              }),
        )
    );
  }

  Widget myCard(index) {
    return Container(
      height: MediaQuery.of(context).size.width/1.1,
      margin: EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: [
            InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/2.2,
                  child: Image.asset(widget.list[index].imagePath.toString(), fit: BoxFit.fill),
                )
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.list[index].title.toString())
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  color: Colors.amber,
                  alignment: Alignment.center,
                  child: Text('Watch Now', style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

