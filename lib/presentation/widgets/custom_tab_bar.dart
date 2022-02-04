import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:exampur_mobile/utils/dimensions.dart';
import 'package:exampur_mobile/utils/images.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  final String title;
  final List<String> names;
  final List<Widget> routes;

  const CustomTabBar({
    Key? key,
    required this.length,
    required this.names,
    required this.routes,
    required this.title,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  Set<String> selected = new Set<String>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.transparent,
          iconTheme: IconThemeData(
            color: AppColors.black,
          ),
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(Images.exampur_title,
              width: Dimensions.ICON_SIZE_Title,
              height: Dimensions.ICON_SIZE_Title,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.title,
                    style: CustomTextStyle.headingBold(context),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: AppColors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    tabs: [for (var i in widget.names) Tab(text: i)],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: widget.routes,
        ),
      ),
    );
  }
}


class TabBarDemo extends StatefulWidget {
  final int length;
  final String title;
  final List<String> names;
  final List<Widget> routes;
  final TabController? controller;

  const TabBarDemo({
    Key? key,
    required this.length,
    required this.names,
    required this.routes,
    required this.title,
    this.controller
  });
  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.card_travel)),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // Create TabController for getting the index of current tab
  //   _controller = TabController(length: widget.names.length, vsync: this);
  //
  //   _controller.addListener(() {
  //     setState(() {
  //       _selectedIndex = _controller.index;
  //     });
  //     AppConstants.printLog("Selected Index: " + _controller.index.toString());
  //   });
  // }
  Set<String> selected = new Set<String>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppColors.transparent,
          iconTheme: IconThemeData(
            color: AppColors.black,
          ),
          elevation: 0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.asset(Images.exampur_title,
              width: Dimensions.ICON_SIZE_Title,
              height: Dimensions.ICON_SIZE_Title,
            ),
          ),
          bottom:
          PreferredSize(
            preferredSize: Size.fromHeight(90.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.title,
                    style: CustomTextStyle.headingMediumBold(context),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                  TabBar(
                    isScrollable: true,
                    unselectedLabelColor: AppColors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    tabs: [for (var i in widget.names) Tab(text: i)],
                    onTap: (index) {
                      _selectedIndex.toString();
                      // Should not used it as it only called when tab options are clicked,
                      // not when user swapped
                    },
                    controller: widget.controller,

                  ),
                ),
              ],
            ),
          ),


        ),
        body: TabBarView(
          controller:widget.controller,
          children: widget.routes,
        ),
      ),
    );
  }
}