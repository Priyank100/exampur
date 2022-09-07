import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/demo/demo.dart';
import 'package:exampur_mobile/presentation/downloads/downloads.dart';
import 'package:exampur_mobile/presentation/help/help.dart';
import 'package:exampur_mobile/presentation/home/books/books_ebooks.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';

import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:exampur_mobile/presentation/my_courses/my_courses.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );

      // case '/home':
      //   return MaterialPageRoute(
      //     builder: (_) => Home(),
      //   );
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
          builder: (_) => Downloads(0),
        );
      case '/help':
        return MaterialPageRoute(
          builder: (_) => Help(),
        );
        case '/landingPage':
          return MaterialPageRoute(
          builder: (_) => LandingPage(),
        );
      case '/red':
        return MaterialPageRoute(
          builder: (_) => Notifications(),
        );
      default:
        return null;
        // return MaterialPageRoute(
        //   builder: (_) => BottomNavigation(),
        // );
    }
  }
}
