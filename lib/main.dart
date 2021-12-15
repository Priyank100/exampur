import 'package:exampur_mobile/presentation/router/app_router.dart';
import 'package:exampur_mobile/presentation/theme/themes.dart';
import 'package:exampur_mobile/repositories/banner_api_client.dart';
import 'package:exampur_mobile/repositories/banner_repository.dart';
import 'package:exampur_mobile/repositories/user_api_client.dart';
import 'package:exampur_mobile/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'logic/bloc/banner_bloc.dart';
import 'logic/bloc/user_bloc.dart';

String baseUrl = "https://6b07f566-12f7-4b32-8f2f-8b6046fa0957.mock.pstmn.io"; //todo: change accordingly
String jwtToken = "xxx";

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
