import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/data/model/cuurntaffairtab.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/contents_ca.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/videos_ca.dart';
import 'package:exampur_mobile/presentation/widgets/custom_tab_bar.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CurrentAffairs extends StatefulWidget {
  final String type;
  final contentCatId;
  const CurrentAffairs(this.type, this.contentCatId) : super();

  @override
  CurrentAffairsState createState() => CurrentAffairsState();
}

class CurrentAffairsState extends State<CurrentAffairs> with SingleTickerProviderStateMixin {
 // TabController? _controller;
  List<Data> videoList = [];
  List<Data> contentList = [];
  bool isLoading = false;
  List<Currentaffairs> tablist = [];
  Future<String> loadJsonFromAssets() async {
    return await rootBundle.loadString('assets/Statejson/currentaffairtab.json');
  }
  void gettabList() async {
   // isLoading=true;
    String jsonString = await loadJsonFromAssets();
    final BookResponse = cuurntaffairtabFromJson(jsonString);
    tablist  =BookResponse.currentaffairs!;

    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    gettabList();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration.zero, () => gettabList()),
        builder: (context, snapshot) {
          return Scaffold(
              body: TabBarDemo(
                 // controller: _controller,
                  length: tablist.length,
                  names:tablist.map((item) => item.name.toString()).toList(),

                  routes:tablist.length==0 ?[]: [
                    VideosCA(widget.type,widget.contentCatId),
                    ContentsCA(widget.type,widget.contentCatId)
                  ],
                  title: widget.type.toString())
          );
        });
  }

  // @override
  // void dispose() {
  //   _controller!.dispose();
  //   super.dispose();
  // }
}