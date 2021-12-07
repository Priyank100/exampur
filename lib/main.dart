import 'package:exampur_mobile/presentation/router/app_router.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
  class _MyAppState extends State<MyApp> {


  final AppRouter _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Exampur',
      theme: CustomTheme.lightTheme,
      //darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}

