import 'package:exampur_mobile/data/model/current_affairs_new_detail_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'current_affairs_filter.dart';

class CurrentAffairsDetails extends StatefulWidget {
  final String articleId;
  const CurrentAffairsDetails(this.articleId) : super();

  @override
  State<CurrentAffairsDetails> createState() => _CurrentAffairsDetailsState();
}

class _CurrentAffairsDetailsState extends State<CurrentAffairsDetails> {
  CurrentAffairsNewDetailModel? currentAffairsDetailModel;
  bool isLoading = true;

  @override
  void initState() {
    getTab();
    super.initState();
  }

  Future<void> getTab() async {
    isLoading = true;
    currentAffairsDetailModel = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewDetail(context, widget.articleId))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        currentAffairsDetailModel == null ? AppConstants.noDataFound() :
        SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                AppConstants.langCode == 'hi' ?
                currentAffairsDetailModel!.titleHindi.toString() :
                currentAffairsDetailModel!.titleEng.toString(),
                style: const TextStyle(fontSize: 20),),
                currentAffairsDetailModel!.caTags == null || currentAffairsDetailModel!.caTags!.length < 0 ? SizedBox() :
                Row(
                children: [
                  const Text('Tags: ',style: TextStyle(fontSize: 15)),
                  Expanded(
                      child: Wrap(
                        spacing: 2.0,
                        children: List<Widget>.generate(currentAffairsDetailModel!.caTags!.length, (int index) {
                          return InkWell(
                            onTap: () {
                              AppConstants.goAndReplace(context, CurrentAffairsFilter('T', selectedTagName: currentAffairsDetailModel!.caTags![index]!.name.toString()));
                            },
                            child: Chip(
                                label: Text(currentAffairsDetailModel!.caTags![index].name.toString(), style: TextStyle(fontSize: 10),)
                            ),
                          );
                        }),
                      )
                  )
                ]),
                const SizedBox(height: 5),
                Html(
                  data: AppConstants.langCode == 'hi' ?
                  currentAffairsDetailModel!.descriptionHindi.toString() :
                  currentAffairsDetailModel!.descriptionEng.toString(),
                    style: {
                      'body': Style(
                          fontSize: const FontSize(12),
                      )}),
            ]),
          ),
        ),

    );
  }
}
