import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eagri_pro/core/utils/router/router_manager.dart';
import 'package:eagri_pro/features/order/domain/usecases/get_orders_usecase.dart';
import 'package:eagri_pro/features/profile/domain/usescases/get_account_usecase.dart';
import 'package:eagri_pro/features/profile/domain/usescases/get_user_by_id_usecase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'core/http/dio_client.dart';
import 'core/http/http_helper.dart';
import 'core/http/network_info.dart';
import 'features/auth/bloc/login/auth_bloc.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/check_auth_usecase.dart';
import 'features/auth/domain/usecases/forgot_password_usecase.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/registration_token_usecase.dart';
import 'features/auth/domain/usecases/reset_password_usecase.dart';
import 'features/client/data/datasources/client_remote_data_source.dart';
import 'features/client/data/repository/client_repository_impl.dart';
import 'features/client/domain/repositories/client_repository.dart';
import 'features/client/domain/usecases/search_clients_usecase.dart';
import 'features/client/presentation/cubit/client_cubit.dart';
import 'features/configuration/data/datasources/configuration_remote_data_source.dart';
import 'features/configuration/data/repositories/configuration_repository_impl.dart';
import 'features/configuration/domain/repositories/configuration.repository.dart';
import 'features/order/cubit/order_cubit.dart';
import 'features/order/data/datasources/order_remote_data_source.dart';
import 'features/order/data/repositories/order_repository_impl.dart';
import 'features/order/domain/repositories/order_repository.dart';
import 'features/order/domain/usecases/get_delivery_by_id_usecase.dart';
import 'features/order/domain/usecases/get_order_delivery_by_qr_usecase.dart';
import 'features/order/domain/usecases/validate_delivery_usecase.dart';
import 'features/payment/data/datasources/payment_data_source.dart';
import 'features/payment/data/repositories/payment_repository_impl.dart';
import 'features/payment/domain/repositories/payment_repository.dart';
import 'features/payment/domain/usecases/payment_usecase.dart';
import 'features/product/data/datasource/product_remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/get_form_product_by_id_usecase.dart';
import 'features/product/domain/usecases/get_type_product_usecase.dart';
import 'features/product/domain/usecases/publish_product_usecase.dart';
import 'features/product/domain/usecases/search_article_product_usecase.dart';
import 'features/product/presentation/cubit/product_cubit.dart';
import 'features/profile/data/datasoucres/account_local_data_source.dart';
import 'features/profile/data/datasoucres/account_remote_datasource.dart';
import 'features/profile/data/repositories/account_repository_impl.dart';
import 'features/profile/domain/repositories/account_repository.dart';
import 'features/profile/domain/usescases/get_current_user_usecase.dart';

final di = GetIt.instance;
Future<void> configureDependencies() async {
  // APP ROUTER
  di.registerLazySingleton(() => RouterManager());
  // ** FEATURES **
  // SHARED PREFERENCES
  const sharedPreferences = FlutterSecureStorage();
  di.registerLazySingleton(() => sharedPreferences);
  // NETWORK INFO
  di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));
  di.registerLazySingleton<DioClient>(() => DioClient(auth: di()));
  // HTTP HELPER
  di.registerLazySingleton<Dio>(() => DioClient(auth: di()).dio);

  // HTTP HELPER
  di.registerLazySingleton<HttpHelper>(() => HttpHelper(di()));

  //***************************  ACCOUNT REPOSITORY ***************************
  di.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(
        networkInfo: di(),
        remoteDataSource: di(),
        store: di(),
      ));
  // ACCOUNT REMOTE DATA SOURCE
  di.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl(httpHelper: di()));
  // ACCOUNT LOCAL DATA SOURCE
  di.registerLazySingleton<AccountLocalDataSource>(
      () => AccountLocalDataSourceImpl(sharedPreferences: di()));
  // ACCOUNT USECASE
  di.registerLazySingleton(
      () => GetCurrentUserUsecase(accountRepository: di()));
  di.registerLazySingleton(() => GetAccountUsecase(accountRepository: di()));
  di.registerLazySingleton(() => GetUserByIdUsecase(accountRepository: di()));

  //***************************  AUTH REPOSITORY ***************************
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
  di.registerFactory(() => AuthBloc(
      // registrationTokenUsecase: di(),
      loginUsecase: di(),
      checkAuthUsecase: di(),
      getUserByIdUsecase: di(),
      logoutUsecase: di(),
      getAccountUsecase: di()));
  // di.registerFactory(() => ForgotPasswordCubit(
  //     forgotPasswordUsecase: di(), resetPasswordUsecase: di()));
  di.registerLazySingleton(() => LoginUsecase(authRepository: di()));
  di.registerLazySingleton(() => CheckAuthUsecase(authRepository: di()));

  di.registerLazySingleton(() => LogoutUsecase(authRepository: di()));
  di.registerLazySingleton(() => ForgotPasswordUsecase(authRepository: di()));
  di.registerLazySingleton(() => ResetPasswordUsecase(authRepository: di()));
  di.registerLazySingleton(
      () => RegistrationTokenUsecase(authRepository: di()));

  // ORDER REPOSITORY
  di.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(
        networkInfo: di(),
        remoteDataSource: di(),
      ));
  // ORDER REMOTE DATA SOURCE
  di.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(httpHelper: di()));

  // ORDER USECASE
  di.registerLazySingleton(() => GetOrdersUsecase(orderRepository: di()));
  di.registerLazySingleton(() => GetDeliveryByIdUsecase(orderRepository: di()));
  di.registerLazySingleton(
      () => ValidateDeliveryUsecase(orderRepository: di()));
  di.registerLazySingleton(
      () => GetOrderDeliveryByQrUsecase(orderRepository: di()));
  di.registerLazySingleton(() => OrderCubit(
      getOrdersUsecase: di(),
      getDeliveryByIdUsecase: di(),
      validateDeliveryUsecase: di(),
      getOrderDeliveryByQrUsecase: di()));

  // *************************** CLIENT REPOSITORY ***************************
  di.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        networkInfo: di(),
        clientRemoteDataSource: di(),
      ));
  // CLIENT REMOTE DATA SOURCE
  di.registerLazySingleton<ClientRemoteDataSource>(
      () => ClientRemoteDataSourceImpl(httpHelper: di()));

  // CLIENT USECASE
  di.registerLazySingleton(() => SearchClientsUsecase(clientRepository: di()));
  di.registerLazySingleton(() => ClientCubit(searchClientsUsecase: di()));

  // *************************** PRODUCT REPOSITORY ***************************
  di.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        networkInfo: di(),
        productRemoteDataSource: di(),
      ));
  // PRODUCT REMOTE DATA SOURCE
  di.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(httpHelper: di()));

  // PRODUCT CUBIT
  di.registerLazySingleton(() => ProductCubit(
      getFormProductByIdUsecase: di(),
      getTypeProductUsecase: di(),
      publishProductUsecase: di(),
      searchArticleProductUsecase: di()));

  // PRODUCT USECASE
  di.registerLazySingleton(
      () => GetTypeProductUsecase(productRepository: di()));
  di.registerLazySingleton(
      () => GetFormProductByIdUsecase(productRepository: di()));
  di.registerLazySingleton(
      () => SearchArticleProductUsecase(productRepository: di()));
  di.registerLazySingleton(
      () => PublishProductUsecase(productRepository: di()));

  // ************************* PAYMENT REPOSITORY ***************************
  di.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
        networkInfo: di(),
        remoteDataSource: di(),
      ));
  // PAYMENT REMOTE DATA SOURCE
  di.registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(httpHelper: di()));

  // PAYMENT USECASE
  di.registerLazySingleton(() => PaymentUsecase(repository: di()));

  // ************************* CONFIGURATION REPOSITORY ***************************
  di.registerLazySingleton<ConfigurationRepository>(() => ConfigurationRepositoryImpl(
        networkInfo: di(),
        configurationRemoteDatasource: di(),
      ));
  // CONFIGURATION REMOTE DATA SOURCE
  di.registerLazySingleton<ConfigurationRemoteDataSource>(
      () => ConfigurationRemoteDataSourceImpl(httpHelper: di()));

  // CONFIGURATION USECASE
}
