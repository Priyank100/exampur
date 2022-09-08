import 'package:exampur_mobile/data/model/current_affairs_new_list_model.dart';
import 'package:exampur_mobile/data/model/current_affairs_new_tag_list_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs_new/current_affairs_details.dart';
import 'package:exampur_mobile/presentation/widgets/loading_indicator.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/api.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'current_affairs_filter.dart';

class CurrentAffairsListing extends StatefulWidget {
  final String tabId;
  const CurrentAffairsListing(this.tabId) : super();

  @override
  State<CurrentAffairsListing> createState() => _CurrentAffairsListingState();
}

class _CurrentAffairsListingState extends State<CurrentAffairsListing> {
  CurrentAffairsNewListModel? currentAffairsListModel;
  bool isLoading = true;
  bool isBottomLoading = false;
  var scrollController = ScrollController();
  List<CurrentAffairsNewTagListModel> tagList = [];
  // CurrentAffairsNewTagListModel? _selectedValue;

  @override
  void initState() {
    scrollController.addListener(pagination);
    getData(API.currentAffairsNewListUrl);
    getTagList();
    super.initState();
  }

  Future<void> getData(String url) async {
    currentAffairsListModel = null;
    isLoading = true;
    currentAffairsListModel = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewList(context, url, widget.tabId))!;
    isLoading = false;
    isBottomLoading = false;
    setState(() {});
  }

  Future<void> getTagList() async {
    tagList = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsTagList(context))!;
    // print('+++' + tagList.length.toString() + '+++' + tagList[0].name.toString());
    setState(() {});
  }

  void pagination() {
    if ((scrollController.position.pixels == scrollController.position.maxScrollExtent)) {
      setState(() {
        isBottomLoading = true;
      });
    } else {
      setState(() {
        isBottomLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        currentAffairsListModel == null || currentAffairsListModel!.count == 0 ? AppConstants.noDataFound() :
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(currentAffairsListModel!.subCategory.toString(),style: TextStyle(fontSize: 15))
                  ),
                  tagList.length == 0 ? SizedBox() : TagDropDownButton(),
                  SizedBox(width: 5),
                  InkWell(
                      onTap:() async {
                        FocusScope.of(context).unfocus();
                        String date = await AppConstants.selectDate(context, 'yyyy-MM-dd');
                        if(date.isNotEmpty) {
                          AppConstants.goTo(context, CurrentAffairsFilter('D', date: date));
                        }
                      },
                      child: FaIcon(FontAwesomeIcons.calendarAlt,size: 20))
                ],),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                  itemCount:currentAffairsListModel!.articleContent!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListItem(index);
                  }),
            ),
          ]),
        bottomNavigationBar:
        currentAffairsListModel == null || currentAffairsListModel!.count == 0 ? SizedBox() :
        isBottomLoading ? Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(8),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                currentAffairsListModel!.previous.toString() == 'null' ? SizedBox() :
                MaterialButton(
                  color: AppColors.amber,
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      getData(currentAffairsListModel!.previous.toString());
                    });
                  },
                  child: Text('<< Previous',style: TextStyle(color: AppColors.white),),
                ),
                  currentAffairsListModel!.next.toString() == 'null' ? SizedBox() :
                  MaterialButton(
                    color: AppColors.amber,
                      onPressed: () {
                      setState(() {
                        isLoading = true;
                        getData(currentAffairsListModel!.next.toString());
                      });
                      },
                    child: Text('Next >>',style: TextStyle(color: AppColors.white)),
                  )
              ]),
        ) : SizedBox()
      );

  }

  Widget ListItem(index){
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
        AppConstants.goTo(context, CurrentAffairsDetails(currentAffairsListModel!.articleContent![index].id.toString()));
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
                      AppConstants.langCode == 'hi' ?
                      currentAffairsListModel!.articleContent![index].titleHindi.toString() :
                      currentAffairsListModel!.articleContent![index].titleEng.toString(),
                      style: TextStyle(fontSize: 15,fontFamily: AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins',
                          fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('Posted on ' + currentAffairsListModel!.articleContent![index].date.toString(),style: TextStyle(fontSize: 10,color: AppColors.amber)),
                  Html(
                      data: AppConstants.langCode == 'hi' ?
                      currentAffairsListModel!.articleContent![index].descriptionHindi.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' ') :
                      currentAffairsListModel!.articleContent![index].descriptionEng.toString().replaceAll(RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), ' '),
                  style: {
                    'body': Style(
                      maxLines: 3,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: const FontSize(12),
                        fontFamily: AppConstants.langCode == 'hi' ?'Noto Sans':'Poppins'
                    )}
                  )],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget TagDropDownButton() {
    return DropdownButton<CurrentAffairsNewTagListModel>(
        hint: Text('Select Tag', style: TextStyle(color: AppColors.black)),
        // value: _selectedValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: AppColors.black, fontSize: 16),
        underline: Container(
          height: 0,
          ),
        onTap: (){
          FocusScope.of(context).unfocus();
          },
        onChanged: (tagData) {
          setState(() {
            // _selectedValue = data!;
            AppConstants.goTo(context, CurrentAffairsFilter('T', selectedTagName: tagData!.name.toString()));
          });
        },
        items: tagList.map<DropdownMenuItem<CurrentAffairsNewTagListModel>>((CurrentAffairsNewTagListModel value) {
          return DropdownMenuItem<CurrentAffairsNewTagListModel>(
              value: value,
              child: Container(
                  width: MediaQuery.of(context).size.width/4,
                  child: Text(value.name.toString()))
          );
        }).toList()
    );
  }
}
