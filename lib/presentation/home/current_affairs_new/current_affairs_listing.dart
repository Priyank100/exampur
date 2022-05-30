import 'package:exampur_mobile/data/model/current_affairs_new_list_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CurrentAffairsListing extends StatefulWidget {
  final String tabId;
  const CurrentAffairsListing(this.tabId) : super();

  @override
  State<CurrentAffairsListing> createState() => _CurrentAffairsListingState();
}

class _CurrentAffairsListingState extends State<CurrentAffairsListing> {
  CurrentAffairsNewListModel? currentAffairsListModel;
  bool isLoading = true;

  @override
  void initState() {
    getTab();
    super.initState();
  }

  Future<void> getTab() async {
    isLoading = true;
    currentAffairsListModel = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewList(context, widget.tabId))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
    currentAffairsListModel == null ? AppConstants.noDataFound() :
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(currentAffairsListModel!.subCategory.toString(),style: TextStyle(fontSize: 15),),
                InkWell(onTap:(){
                  FocusScope.of(context).unfocus();
                },child: FaIcon(FontAwesomeIcons.calendarAlt,size: 20,),)
              ],),
          ),
          Expanded(
            child: ListView.builder(
                itemCount:currentAffairsListModel!.articleContent!.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ListItem(index);
                }),
          ),
        ] );
  }

  Widget ListItem(index){
    return InkWell(
      onTap: (){
        FocusScope.of(context).unfocus();
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
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                      fontSize: const FontSize(10)
                    )}
                  )],
              ),
            )
          ],
        ),
      ),
    );
  }
}
