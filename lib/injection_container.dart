import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/http/dio_client.dart';
import 'core/http/http_helper.dart';

import 'core/http/network_info.dart';
import 'features/auth/core/data/datasources/auth_local_data_source.dart';
import 'features/auth/core/data/datasources/auth_remote_data_source.dart';
import 'features/auth/core/data/repositories/auth_repository_impl.dart';
import 'features/auth/core/domain/repositories/auth_repository.dart';
import 'features/auth/core/domain/usecases/check_auth_usecase.dart';
import 'features/auth/core/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/core/domain/usecases/login_usecase.dart';
import 'features/auth/core/domain/usecases/logout_usecase.dart';
import 'features/auth/core/domain/usecases/registration_token_usecase.dart';
import 'features/auth/core/domain/usecases/reset_password_usecase.dart';
import 'features/profile/service/user_service.dart';

final di = GetIt.instance;
Future<void> configureDependencies() async {
  // ** FEATURES **
  // SHARED PREFERENCES
  const sharedPreferences = FlutterSecureStorage();
  di.registerLazySingleton(() => sharedPreferences);
  // NETWORK INFO
  di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
  di.registerLazySingleton<DioClient>(() => DioClient());
  // HTTP HELPER
  di.registerLazySingleton<Dio>(() => DioClient().dio);

  // HTTP HELPER
  di.registerLazySingleton<HttpHelper>(() => HttpHelper(di()));
  di.registerLazySingleton<UserService>(() => UserService(di(), di()));

  // AUTH REPOSITORY
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        networkInfo: di(),
        remoteDataSource: di(),
        store: di(),
      ));
  // AUTH LOCAL DATA SOURCE
  di.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: di()));

  // AUTH REMOTE DATA SOURCE
  di.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(httpHelper: di()));

  // AUTH USECASE
  // di.registerFactory(() => AuthBloc(
  //     registrationTokenUsecase: di(),
  //     loginUsecase: di(),
  //     checkAuthUsecase: di(),
  //     getUserByIdUsecase: di(),
  //     logoutUsecase: di(),
  //     getAccountUsecase: di()));
  // di.registerFactory(() => ForgotPasswordCubit(
  //     forgotPasswordUsecase: di(), resetPasswordUsecase: di()));
  di.registerLazySingleton(() => LoginUsecase(authRepository: di()));
  di.registerLazySingleton(() => CheckAuthUsecase(authRepository: di()));
  di.registerLazySingleton(() => LogoutUsecase(authRepository: di()));
  di.registerLazySingleton(() => ForgotPasswordUsecase(authRepository: di()));
  di.registerLazySingleton(() => ResetPasswordUsecase(authRepository: di()));
  di.registerLazySingleton(
      () => RegistrationTokenUsecase(authRepository: di()));
  // HIVE HELPER
}
