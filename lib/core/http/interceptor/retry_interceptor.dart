import 'dart:io';

import 'package:dio/dio.dart';
//import 'package:connectivity_plus/connectivity_plus.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Gestion du retry uniquement pour les erreurs réseau
    if (
        //await Connectivity().checkConnectivity() != ConnectivityResult.none &&
        err.type != DioExceptionType.cancel && err.error is! SocketException) {
      // Délais croissants pour les retries
      await Future.delayed(const Duration(seconds: 1));
      try {
        final retryResponse = await dio.fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      } catch (e) {
        return handler.next(e as DioException);
      }
    }
    return handler.next(err); // Continuer en cas d'erreur non liée au réseau
  }
}
