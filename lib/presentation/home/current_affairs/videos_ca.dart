import 'package:exampur_mobile/Localization/language_constrants.dart';
import 'package:exampur_mobile/data/model/ca_sm_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs/viedodetailpage.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/refreshwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideosCA extends StatefulWidget {
  final String type;
  final contentCatId;

  const VideosCA(this.type,this.contentCatId) : super();

  @override
  _VideosCAState createState() => _VideosCAState();
}

class _VideosCAState extends State<VideosCA> {
  bool isLoading = false;
  bool isBottomLoading = false;
  List<Data> videoList = [];
  var scrollController = ScrollController();
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  int page = 0;
  bool isData = true;
  Future<void> getBooksList(pageNo) async {
    videoList.clear();
    isLoading = true;
    List<Data> list =  (await Provider.of<CaProvider>(context, listen: false)
        .getCaSmList(context, widget.contentCatId, 'video', AppConstants.encodeCategory(),pageNo))!;
    if(list.length > 0) {
      isData = true;
      videoList = videoList + list;
    } else {
      isData = false;
    }
    isLoading = false;
  isBottomLoading = false;
  setState(() {

  });
  }
  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(pagination);
    getBooksList(page);
    print(widget.contentCatId);
    super.initState();
  }
  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        if(isData) {
          page += 1;
        }
        isBottomLoading = true;
        getBooksList(page);
        AppConstants.printLog('page>> ' + page.toString());
      });
    }
  }
  Future<void>_refreshLocalGallery() async{
    return getBooksList(page);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading ? Center(child: CircularProgressIndicator(color: AppColors.amber)) : videoList.length == 0
          ? AppConstants.noDataFound()
          :   RefreshWidget(
        keyRefresh: keyRefresh,
        onRefresh:_refreshLocalGallery,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: videoList.length,
         controller: scrollController,
         // shrinkWrap: true,
            itemBuilder: (context, index) {
              return myCard(index);
            }),
          ),
      bottomNavigationBar:  isBottomLoading ? Container(
        // padding: EdgeInsets.all(8),
          height:40,
          width: 40,
          child: Center(child: CircularProgressIndicator(color:AppColors.amber,))) :
      SizedBox(),
    );
  }

  Widget myCard(index) {
    return Container(
      height: MediaQuery.of(context).size.width/1.3,
      margin: EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Column(
          children: [

            InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width/2.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    image: DecorationImage(
                        image: NetworkImage(AppConstants.BANNER_BASE + videoList[index].bannerPath.toString()),
                        fit: BoxFit.fill
                    ),
                  ),
                )
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(videoList[index].title.toString())
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      ViedoDetailPage(videoList[index])
                  ));
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.amber,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                  ),
                  child: Text(getTranslated(context, StringConstant.watch)!, style: TextStyle(color: AppColors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}