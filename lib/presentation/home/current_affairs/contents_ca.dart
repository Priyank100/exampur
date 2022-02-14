import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/shared/daily_monthly_card.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ContentsCA extends StatefulWidget {
 // final List<Data> list;
  final String type;
  final contentCatId;
  const ContentsCA(this.type,this.contentCatId) : super();

  @override
  _ContentsCAState createState() => _ContentsCAState();
}

class _ContentsCAState extends State<ContentsCA> {
  bool isLoading = false;
  List<Data> contentList = [];
  var scrollController = ScrollController();
  int page = 0;
  bool isData = true;
  Future<void> getBooksList(pageNo) async {

    isLoading = true;
    List<Data> list = (await Provider.of<CaProvider>(context, listen: false)
        .getCaSmList(context, widget.contentCatId, 'content', AppConstants.encodeCategory(),pageNo))!;
    if(list.length > 0) {
      isData = true;
      contentList = contentList + list;
    } else {
      isData = false;
    }
    isLoading = false;
  }
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(pagination);
    getBooksList(page);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isLoading = true;
        getBooksList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contentList.length == 0
          ? Center(child: CircularProgressIndicator(color: AppColors.amber))
          : ListView.builder(
          itemCount: contentList.length,
          controller: scrollController,
          //shrinkWrap: true,
          itemBuilder: (context, index) {
            return DailyMonthlyCard(contentList[index], index,widget.type);
          }),
    );
  }
}
