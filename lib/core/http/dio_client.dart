import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late Dio _dio;
  //final AuthLocalDataSource auth;
  DioClient._internal(
    this._dio,
    // this.auth,
  );

  static DioClient? _instance;

  factory DioClient(
      //{
      // required AuthLocalDataSource auth,
      //},
      ) {
    if (_instance == null) {
      final dio = Dio(BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? "",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ));

      // Ajout du logger PrettyDioLogger
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ));

      _instance = DioClient._internal(
        dio,
      );
      // _instance!._addAuthInterceptor();
    }

    return _instance!;
  }

  // void _addAuthInterceptor() {
  //   // _dio.interceptors.clear(); // Supprime les intercepteurs existants pour éviter les doublons
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (options, handler) async {
  //      // final AuthModel? currentUser = await auth.loadData();
  //       if (currentUser?.accessToken != null) {
  //         options.headers['Authorization'] =
  //             'Bearer ${currentUser!.accessToken}';
  //       }
  //       return handler.next(options);
  //     },
  //   ));
  // }

  Dio get dio => _dio;
}
