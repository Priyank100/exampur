import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/widgets/test_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) => Home(),
        );
      case '/demo':
        return MaterialPageRoute(
          builder: (_) => Demo(),
        );
      case '/mycourses':
        return MaterialPageRoute(
          builder: (_) => MyCourses(),
        );
      case '/downloads':
        return MaterialPageRoute(
          builder: (_) => Downloads(),
        );
      case '/help':
        return MaterialPageRoute(
          builder: (_) => Help(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => TestingScreen(),
        );
    }
  }
}
