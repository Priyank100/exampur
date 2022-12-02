import 'dart:io';
import 'package:exampur_mobile/SplashScreen/splash_screen.dart';
import 'package:exampur_mobile/presentation/authentication/landing_page.dart';
import 'package:exampur_mobile/presentation/notifications/notification_screen.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:exampur_mobile/provider/AppToutorial_provider.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/provider/CABytesProvider.dart';
import 'package:exampur_mobile/provider/CaProvider.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/provider/ConfigProvider.dart';
import 'package:exampur_mobile/provider/DailyQuizProvider.dart';
import 'package:exampur_mobile/provider/Demoprovider.dart';
import 'package:exampur_mobile/provider/FreeVideoProvider.dart';
import 'package:exampur_mobile/provider/Helpandfeedback.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/provider/JobAlertsProvider.dart';
import 'package:exampur_mobile/provider/MyCourseProvider.dart';
import 'package:exampur_mobile/provider/Offline_batchesProvider.dart';
import 'package:exampur_mobile/provider/One2one_provider.dart';
import 'package:exampur_mobile/provider/PaidCourseProvider.dart';
import 'package:exampur_mobile/provider/PracticeQuestionProvider.dart';
import 'package:exampur_mobile/provider/StudyNotesProvider.dart';
import 'package:exampur_mobile/provider/TestSeriesProvider.dart';
import 'package:exampur_mobile/provider/mypurchaseProvider.dart';
import 'package:exampur_mobile/provider/new_my_course_provider.dart';
import 'package:exampur_mobile/utils/app_colors.dart';

import 'package:exampur_mobile/utils/lang_string.dart';
import 'package:exampur_mobile/utils/app_constants.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Localization/app_localization.dart';
import 'Localization/language_constrants.dart';
import 'di_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async{
  // AppConstants.printLog(message.data.toString());
  // AppConstants.printLog(message.notification!.title);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  await FlutterDownloader.initialize(debug: true);
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, badge: true, sound: true
  );
  // Get any initial links
  HttpOverrides.global = MyHttpOverrides();

  // to crash the app in any exception
  // FlutterError.onError = (FlutterErrorDetails details) async {
  //   await FirebaseCrashlytics.instance.recordFlutterError(details);
  //   exit(0);
  // };

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
   // ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<HomeBannerProvider>()),
    // ChangeNotifierProvider(create: (context) => di.sl<ValidTokenProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<BooksEBooksProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<One2OneProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ChooseCategoryProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<PaidCoursesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<DemoProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<OfflinebatchesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<AppTutorialProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl< HelpandFeedbackprovider>()),
    ChangeNotifierProvider(create: (context) => di.sl<JobAlertsProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<CABytesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<CaProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<MyPurchaseProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<MyCourseProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<TestSeriesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<DailyQuizProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<PracticeQuestionProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<StudyNotesProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<FreeVideoProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<ConfigProvider>()),
    ChangeNotifierProvider(create: (context) => di.sl<NewMyCourseProvider>()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      AppConstants.langCode = locale.languageCode;
    });
  }
 // final AppRouter _appRouter = AppRouter();
 @override
 void didChangeDependencies() {
   getLocale().then((locale) {
     setState(() {
       this._locale = locale;
       AppConstants.langCode = locale.languageCode;
     });
   });
   super.didChangeDependencies();
 }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // List<Locale> _locals = [];
    // AppConstants.languages.forEach((language) {
    //   _locals.add(Locale(language.languageCode!, language.countryCode));
    // });
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue)),
        ),
      );
    } else {
    return MaterialApp(
      title: 'Exampur',
      theme: CustomTheme.lightTheme,
      //darkTheme: CustomTheme.darkTheme,

      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      locale: _locale,
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("hi", "IN")
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
     // onGenerateRoute: _appRouter.onGenerateRoute,
      routes: {
        "red": (_) => Notifications(),
        "/landingPage": (_) => LandingPage()
      },
        home: SplashScreen(),
    );
    }
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}