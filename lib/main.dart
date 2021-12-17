import 'package:exampur_mobile/logic/globals.dart';
import 'package:exampur_mobile/presentation/router/app_router.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:exampur_mobile/repositories/banner_api_client.dart';
import 'package:exampur_mobile/repositories/banner_repository.dart';
import 'package:exampur_mobile/repositories/demoClass_api_client.dart';
import 'package:exampur_mobile/repositories/demoClass_repository.dart';
import 'package:exampur_mobile/repositories/featured_course_api_client.dart';
import 'package:exampur_mobile/repositories/featured_course_repository.dart';
import 'package:exampur_mobile/repositories/notification_api_client.dart';
import 'package:exampur_mobile/repositories/notification_repository.dart';
import 'package:exampur_mobile/repositories/user_api_client.dart';
import 'package:exampur_mobile/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'logic/bloc/banner_bloc.dart';
import 'logic/bloc/demo_class_bloc.dart';
import 'logic/bloc/featured_course_bloc.dart';
import 'logic/bloc/notification_bloc.dart';
import 'logic/bloc/user_bloc.dart';



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

  final UserRepository userRepository = UserRepository(
    userApiClient: UserApiClient(),
  );
  final BannerRepository bannerRepository = BannerRepository(
    bannerApiClient: BannerApiClient(),
  );
  final NotificationRepository notificationRepository = NotificationRepository(
    notificationApiClient: NotificationApiClient(),
  );
  final DemoClassRepository demoClassRepository = DemoClassRepository(
    demoClassApiClient: DemoClassApiClient(),
  );
  final FeaturedCourseRepository featuredCourseRepository =
      FeaturedCourseRepository(
    featuredCourseApiClient: FeaturedCourseApiClient(),
  );

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserBloc(repository: userRepository),
          ),
          BlocProvider(
            create: (context) => BannerBloc(repository: bannerRepository),
          ),
          BlocProvider(
            create: (context) =>
                NotificationBloc(repository: notificationRepository),
          ),
          BlocProvider(
            create: (context) => DemoClassBloc(repository: demoClassRepository),
          ),
          BlocProvider(
            create: (context) =>
                FeaturedCourseBloc(repository: featuredCourseRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Exampur',
          theme: CustomTheme.lightTheme,
          //darkTheme: CustomTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          onGenerateRoute: _appRouter.onGenerateRoute,
        ));
  }
}
