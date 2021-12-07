import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
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
      default:
        return MaterialPageRoute(
          builder: (_) => TestingScreen(),
        );
    }
  }
}