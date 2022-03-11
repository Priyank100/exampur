import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/shared/daily_monthly_card.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
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
  bool isBottomLoading = false;
  List<Data> contentList = [];
  var scrollController = ScrollController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  int page = 0;
  bool isData = true;
  int isLoad = 0;

  Future<void> getContentList(pageNo) async {
    List<Data> list = (await Provider.of<CaProvider>(context, listen: false).getCaSmList(context, widget.contentCatId, 'content', AppConstants.encodeCategory(),pageNo))!;
    if(list.length > 0) {
      isData = true;
      contentList = contentList + list;
    } else {
      isData = false;
    }
    isBottomLoading = false;
    isLoad++;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(pagination);
    isLoad = 0;
    getContentList(page);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isBottomLoading = true;
        getContentList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }
  Future<void> _refreshLocalGallery() async{
    page = 0;
    contentList.clear();
    return getContentList(page);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoad==0? Center(child: CircularProgressIndicator(color: AppColors.amber,)):
      contentList.length==0 ? AppConstants.noDataFound() :
      RefreshWidget(
        keyRefresh: keyRefresh,
        onRefresh:_refreshLocalGallery,
            child: listing(contentList)
          ),
      bottomNavigationBar: isBottomLoading ? Container(
        // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
      SizedBox(),
    );

  }
  Widget listing(list) {
    return ListView.builder(itemCount:list.length,controller: scrollController,
        itemBuilder: (BuildContext context,int index){
          return DailyMonthlyCard(contentList[index], index,widget.type);
        });
  }
}
