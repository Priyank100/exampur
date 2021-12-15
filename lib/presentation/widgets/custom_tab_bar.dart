import 'package:exampur_mobile/presentation/theme/custom_text_style.dart';
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
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Logo',
            style: TextStyle(color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(65.0),
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
                    unselectedLabelColor: Colors.grey,
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
