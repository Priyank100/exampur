import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:exampur_mobile/provider/Authprovider.dart';
import 'package:exampur_mobile/provider/BooksEBooksProvider.dart';
import 'package:exampur_mobile/provider/ChooseCategory_provider.dart';
import 'package:exampur_mobile/provider/HomeBannerProvider.dart';
import 'package:exampur_mobile/provider/One2one_provider.dart';
import 'package:exampur_mobile/provider/courses_provider.dart';

import 'package:exampur_mobile/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/network_info.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_incepactor.dart';
import 'data/repository/Authrepo.dart';
import 'data/repository/Books_EBooks_repo.dart';
import 'data/repository/ChooseCategory_repo.dart';
import 'data/repository/HomeBanner_repo.dart';
import 'data/repository/One2One_repo.dart';
import 'data/repository/courserepo.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core
  //sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL2, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl()));
  sl.registerLazySingleton(() => HomeBannerRepo(dioClient: sl()));
  // sl.registerLazySingleton(() => ValidTokenRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CoursesRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BooksEBooksRepo(dioClient: sl()));
  sl.registerLazySingleton(() => One2OneRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ChooseCategoryRepo(dioClient: sl()));


  // Provider
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => HomeBannerProvider(homeBannerRepo: sl()));
  // sl.registerFactory(() => ValidTokenProvider(validTokenRepo: sl()));
  sl.registerFactory(() =>  CoursesProvider(courseRepo: sl()));
  sl.registerFactory(() =>  BooksEBooksProvider(booksEbooksRepo: sl()));
  sl.registerFactory(() =>  One2OneProvider(one2oneRepo: sl()));
  sl.registerFactory(() =>  ChooseCategoryProvider(chooseCategoryRepo: sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());
}