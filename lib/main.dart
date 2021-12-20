import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/logic/jwt_token.dart';
import 'package:exampur_mobile/presentation/router/app_router.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    jwt = JwtToken(jwtToken: "jwtToken");
    final platform = Theme.of(context).platform;
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
