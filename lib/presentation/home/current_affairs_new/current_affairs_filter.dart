import 'package:exampur_mobile/data/model/current_affairs_new_list_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'current_affairs_details.dart';
import 'current_affairs_tab.dart';

class CurrentAffairsFilter extends StatefulWidget {
  final String langCode;
  final String searchType;
  final String? date;
  final String? selectedTagName;
  const CurrentAffairsFilter(this.langCode,this.searchType, {this.date, this.selectedTagName}) : super();

  @override
  State<CurrentAffairsFilter> createState() => _CurrentAffairsFilterState();
}

class _CurrentAffairsFilterState extends State<CurrentAffairsFilter> {
  CurrentAffairsNewListModel? currentAffairsListModel;
  bool isLoading = false;

  @override
  void initState() {
    if(widget.searchType == 'D' || widget.searchType == 'T') {
      getFilterDataList('');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName("CAN"));
        return true;
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.searchType == 'S' ?SizedBox() :  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.selectedTagName == null ?'Selected Date : '+widget.date.toString():'Selected TagName : '+widget.selectedTagName.toString(),style: TextStyle(fontSize: 15),),
            ),
            widget.searchType == 'S' ?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  border: Border.all(color: AppColors.grey, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  autofocus: true,
                  onChanged: (s) {
                    if(s.isNotEmpty) {
                      getFilterDataList(s);
                    } else {
                      setState(() {
                        currentAffairsListModel = null;
                      });
                    }
                  },
                  autocorrect: false,
                  cursorColor: AppColors.amber,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,size: 25,color: AppColors.grey400),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      color: AppColors.grey400,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                    isDense: true,
                    counterText: '',
                    errorStyle: TextStyle(height: 1.5),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ) : SizedBox(),
            SizedBox(height: 10),
            isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
            currentAffairsListModel == null || currentAffairsListModel!.count == 0 ?
            AppConstants.noDataFound() :
            Expanded(
              child: ListView.builder(
                  itemCount:currentAffairsListModel!.articleContent!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListItem(index);
                  }),
            ),
          ],
        )
      ),
    );
  }

  Widget ListItem(index){
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        AppConstants.goTo(context, CurrentAffairsDetails(widget.langCode,currentAffairsListModel!.articleContent![index].id.toString()));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width/3,
              child:Image.asset(Images.exampur_logo,fit: BoxFit.fill),

            ),
            SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.langCode == 'hi' ?
                    currentAffairsListModel!.articleContent![index].titleHindi.toString() :
                    currentAffairsListModel!.articleContent![index].titleEng.toString(),
                    style:  TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: widget.langCode == 'hi' ?'Noto Sans':'Poppins',),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                  ),
                  Text('Posted on ' + currentAffairsListModel!.articleContent![index].date.toString(),style: TextStyle(fontSize: 10,color: AppColors.amber)),
                  Html(
                      data: widget.langCode == 'hi' ?
                      currentAffairsListModel!.articleContent![index].descriptionHindi.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' ') :
                      currentAffairsListModel!.articleContent![index].descriptionEng.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' '),
                      style: {
                        'body': Style(
                            maxLines: 3,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: const FontSize(12),
                            fontFamily: widget.langCode == 'hi' ?'Noto Sans':'Poppins'
                        )}
                  )],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getFilterDataList(String searchText) async {
    String query = '';
    if(widget.searchType == 'S') {
      query = 'q=' + searchText;
    } else if(widget.searchType == 'D') {
      query = 'dt=' + widget.date.toString();
    } else {
      query = 'tag=' + widget.selectedTagName.toString();
    }
    currentAffairsListModel = null;
    isLoading = true;
    currentAffairsListModel = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewListFilter(context, query))!;
    isLoading = false;
    setState(() {});
  }
}
