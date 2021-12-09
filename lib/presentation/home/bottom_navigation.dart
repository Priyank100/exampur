import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/home/study_material.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:exampur_mobile/presentation/home/home.dart';

class ItemClass {
  const ItemClass(this.index, this.label, this.icon);

  final int index;
  final String label;
  final icon;
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  int _currIndex = 0;
  late AnimationController _hide;
  late List<AnimationController> _faders;
  late List<Key> _destinationKeys;

  @override
  void initState() {
    super.initState();
    _faders = widgetList.map<AnimationController>((item) {
      return AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );
    }).toList();
    _faders[_currIndex].value = 1.0;
    _destinationKeys =
        List<Key>.generate(widgetList.length, (int index) => GlobalKey())
            .toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders) controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  final List<Widget> widgetList = [
    Home(),
    Demo(),
    MyCourses(),
    Downloads(),
    StudyMaterial()
  ];
  final List<String> widgetNames = [
    "Home",
    "Demo",
    "My Courses",
    "Downloads",
    "Help"
  ];

  @override
  Widget build(BuildContext context) {
    // return NotificationListener<ScrollNotification>(
    // onNotification: _handleScrollNotification,
    // child: Scaffold(
    List<ItemClass> allItems = <ItemClass>[
      ItemClass(
        0,
        //'Home',
        "Home",

        FaIcon(FontAwesomeIcons.home),
      ),
      ItemClass(
        1,
        //'Courses',
        "Demo",
        FaIcon(FontAwesomeIcons.graduationCap),
        //Icon(BottomNavBarIcons.course_icon),
      ),
      ItemClass(
        2,
        //'Resources',
        "My Courses",
        FaIcon(FontAwesomeIcons.camera),
      ),
      ItemClass(
        3,
        "Downloads",
        FaIcon(FontAwesomeIcons.download),
      ),
      ItemClass(
        4,
        "Help",
        FaIcon(FontAwesomeIcons.question),
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        //Use this code if you just want to go back to 0th index
        if (_currIndex == 0) return true;
        setState(() {
          _currIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allItems.map(
              (item) {
                final Widget view = FadeTransition(
                  opacity: _faders[item.index].drive(
                    CurveTween(curve: Curves.fastOutSlowIn),
                  ),
                  child: KeyedSubtree(
                    key: _destinationKeys[item.index],
                    child: widgetList[item.index],
                  ),
                );
                if (item.index == _currIndex) {
                  _faders[item.index].forward();
                  return view;
                } else {
                  _faders[item.index].reverse();
                  if (_faders[item.index].isAnimating) {
                    return IgnorePointer(child: view);
                  }
                  return Offstage(child: view);
                }
              },
            ).toList(),
          ),
        ),

        // bottomNavigationBar: SizeTransition(
        //   sizeFactor: _hide,
        //   axisAlignment: -1.0,
        //   child: BottomNavigationBar(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currIndex,
          showUnselectedLabels: true,
          fixedColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currIndex = index;
            });
          },
          items: allItems.map((item) {
            return BottomNavigationBarItem(
              icon: item.icon,
              label: item.label,
            );
          }).toList(),
        ),
        // ),
        // ),
      ),
    );
  }
}
