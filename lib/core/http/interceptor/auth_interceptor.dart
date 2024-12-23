import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Ajouter le token d'authentification
    const token =
        'your_auth_token'; // À remplacer par la gestion réelle du token

    options.connectTimeout = const Duration(seconds: 20);
    options.receiveTimeout = const Duration(seconds: 20);
    options.headers['Accept'] = '*/*';
    // options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Si le token est expiré, tenter de le renouveler
      final success = await _refreshToken();
      if (success) {
        // Refaire la requête avec le nouveau token
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer new_token';
        // final retryResponse = await Dio().fetch(options);
        // return handler.resolve(retryResponse);
      }
    }
    return handler.next(err); // Continuer en cas d'autres erreurs
  }

  Future<bool> _refreshToken() async {
    try {
      // Implémentation de l'appel API pour le refresh du token
      // Ex: Dio().post('/auth/refresh-token', data: {...});
      return true;
    } catch (e) {
      return false;
    }
  }
}
