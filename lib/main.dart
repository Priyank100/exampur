import 'package:exampur_mobile/SplashScreen/splash_screen.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/home/bottom_navigation.dart';
import 'package:exampur_mobile/presentation/home/home.dart';
import 'package:exampur_mobile/presentation/router/app_router.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/BooksProvider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/provider/One2one_provider.dart';
import 'package:exampur_mobile/provider/courses_provider.dart';
import 'package:exampur_mobile/utils/app_constants.dart';

import 'di_container.dart' as di;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await FlutterDownloader.initialize(debug: true);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeBannerProvider>()),
    // ChangeNotifierProvider(create: (context) => di.sl<ValidTokenProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl< CoursesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<BooksProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<One2OneProvider>()),
  ], child: MyApp()));
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
    final platform = Theme.of(context).platform;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode!, language.countryCode));
    });
    return MaterialApp(
      title: 'Exampur',
      theme: CustomTheme.lightTheme,
      //darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      onGenerateRoute: _appRouter.onGenerateRoute,
      supportedLocales: _locals,
      home: SplashScreen(),
    );
  }
}
