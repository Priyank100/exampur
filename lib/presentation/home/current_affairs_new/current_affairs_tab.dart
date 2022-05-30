import 'package:exampur_mobile/data/model/curent_affairs_new_tab_model.dart';
import 'package:exampur_mobile/presentation/home/current_affairs_new/current_affairs_filter.dart';
import 'package:exampur_mobile/presentation/home/current_affairs_new/current_affairs_listing.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/utils/appBar.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentAffairsTab extends StatefulWidget {
  const CurrentAffairsTab({Key? key}) : super(key: key);

  @override
  State<CurrentAffairsTab> createState() => _CurrentAffairsTabState();
}

class _CurrentAffairsTabState extends State<CurrentAffairsTab> {
  List<CurentAffairsNewTabModel> currentAffairsTab = [];
  bool isLoading = true;

  @override
  void initState() {
    getTab();
    super.initState();
  }

  Future<void> getTab() async {
    isLoading = true;
    currentAffairsTab = (await Provider.of<CaProvider>(context, listen: false).getCurrentAffairsNewTab(context))!;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(),
        body: isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.amber)) :
        currentAffairsTab.isEmpty ? AppConstants.noDataFound() :
        Column(
            children: [
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
                    readOnly: true,
                    autocorrect: false,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      AppConstants.goTo(context, CurrentAffairsFilter());
                    },
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
              ),
              Expanded(
                  child:DefaultTabController(
                    initialIndex: 0,
                    length: currentAffairsTab.length,
                    child: tabBar(),
                  )
              ),
            ]),
      ),
    );
  }
  Widget tabBar() {
    return  Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TabBar(
          isScrollable: true,
          onTap: (i){
            FocusScope.of(context).unfocus();
          },
          tabs: currentAffairsTab.map((item) => Tab(
              text: AppConstants.langCode == 'hi' ? item.titleHindi.toString() : item.titleEng.toString())).toList(),
          indicatorColor: AppColors.amber,
          padding: EdgeInsets.all(8),
        ),
        Expanded(
          child: TabBarView(
              children: currentAffairsTab.map((item) => CurrentAffairsListing(item.id.toString())).toList()
          ),
        ),
      ],
    );
  }
}
