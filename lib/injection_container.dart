import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/http/dio_client.dart';
import 'core/http/http_helper.dart';

import 'core/http/network_info.dart';
import 'features/auth/data/auth_local_data_source.dart';
import 'features/profile/service/user_service.dart';

final di = GetIt.instance;
Future<void> configureDependencies() async {
  // ** FEATURES **
  // SHARED PREFERENCES
  const sharedPreferences = FlutterSecureStorage();
  di.registerLazySingleton(() => sharedPreferences);
  di.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: di()));
  // NETWORK INFO
  di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
  di.registerLazySingleton<DioClient>(() => DioClient());
  // HTTP HELPER
  di.registerLazySingleton<Dio>(() => DioClient().dio);

  // HTTP HELPER
  di.registerLazySingleton<HttpHelper>(() => HttpHelper(di()));
  di.registerLazySingleton<UserService>(() => UserService(di(), di()));
  // HIVE HELPER
}
