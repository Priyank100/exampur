import 'package:exampur_mobile/data/model/current_affairs_new_detail_model.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_colors.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'current_affairs_filter.dart';

class CurrentAffairsDetails extends StatefulWidget {
  final String langCode;
  final String articleId;
  const CurrentAffairsDetails(this.langCode,this.articleId) : super();

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
                  widget.langCode == 'hi' ?
                  currentAffairsDetailModel!.titleHindi.toString() :
                  currentAffairsDetailModel!.titleEng.toString(),
                  style:  TextStyle(fontSize: 20,fontFamily: widget.langCode == 'hi' ?'Noto Sans':'Poppins',fontWeight: FontWeight.bold),),
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
                                  AppConstants.goAndReplace(context, CurrentAffairsFilter(widget.langCode,'T', selectedTagName: currentAffairsDetailModel!.caTags![index].name.toString()));
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
                    data: widget.langCode == 'hi' ?
                    currentAffairsDetailModel!.descriptionHindi.toString() :
                    currentAffairsDetailModel!.descriptionEng.toString(),
                    customRender: {
                      "table": (context, child) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                          (context.tree as TableLayoutElement).toWidget(context),
                        );
                      },
                    },
                    style: {
                      'body': Style(
                        lineHeight:LineHeight(2),
                        fontSize: const FontSize(15),
                        fontFamily: 'Noto Sans',
                      ),
                      'table':Style(
                        border: Border.all(width: 1),
                      ),
                      "tr": Style(
                          border: Border.all(width: 1)
                      ),
                      "th": Style(
                        // padding: EdgeInsets.all(6),
                        backgroundColor: AppColors.grey,
                      ),
                      "td": Style(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 5, right: 5),
                        width: 200,
                      ),
                    }),
              ]),
        ),
      ),

    );
  }
}
