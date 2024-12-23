import 'dart:developer';

import 'package:dio/dio.dart';

class HttpHelper {
  final Dio _dio;

  HttpHelper(this._dio);

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      // print((await _dio.options.o))
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      log(e.requestOptions.headers.toString());
      rethrow;
    }
  }

  Future<Response> post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    // Dio dio = Dio();
    try {
      final response = await _dio.post(path,
          data: data, queryParameters: queryParameters, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await _dio.put(path,
          data: data, queryParameters: queryParameters, options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> patch(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await _dio.delete(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> head(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.head(path, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

enum DataSource {
  success,
  noContent,
  babRequest,
  forBiden,
  unauthorised,
  notFound,
  internalSeverError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultResponse,
}

class ErrorHandler implements Exception {
  late ApiFailure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handlerError(error);
    } else {
      failure = DataSource.defaultResponse.getFailure();
    }
  }
  ApiFailure _handlerError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioExceptionType.sendTimeout:
        return DataSource.sendTimeout.getFailure();

      case DioExceptionType.receiveTimeout:
        return DataSource.recieveTimeout.getFailure();

      case DioExceptionType.badResponse:
        switch (dioError.response!.statusCode) {
          case ResponseCode.babRequest:
            return DataSource.babRequest.getFailure();
          case ResponseCode.forBiden:
            return DataSource.forBiden.getFailure();
          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure();
          case ResponseCode.notFound:
            return DataSource.noContent.getFailure();
          case ResponseCode.internalSeverError:
            return DataSource.internalSeverError.getFailure();
          default:
            return DataSource.defaultResponse.getFailure();
        }

      case DioExceptionType.cancel:
        return DataSource.cancel.getFailure();

      case DioExceptionType.unknown:
        return DataSource.defaultResponse.getFailure();

      default:
        return DataSource.defaultResponse.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  ApiFailure getFailure() {
    switch (this) {
      case DataSource.babRequest:
        return ApiFailure(ResponseCode.babRequest, ResponseMessage.babRequest);
      case DataSource.forBiden:
        return ApiFailure(ResponseCode.forBiden, ResponseMessage.forBiden);

      case DataSource.unauthorised:
        return ApiFailure(
            ResponseCode.unauthorised, ResponseMessage.unauthorised);

      case DataSource.notFound:
        return ApiFailure(ResponseCode.notFound, ResponseMessage.notFound);

      case DataSource.internalSeverError:
        return ApiFailure(ResponseCode.internalSeverError,
            ResponseMessage.internalSeverError);

      case DataSource.connectTimeout:
        return ApiFailure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return ApiFailure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.recieveTimeout:
        return ApiFailure(
            ResponseCode.recieveTimeout, ResponseMessage.recieveTimeout);

      case DataSource.sendTimeout:
        return ApiFailure(
            ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return ApiFailure(ResponseCode.cacheError, ResponseMessage.cacheError);

      case DataSource.noInternetConnection:
        return ApiFailure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.defaultResponse:
        return ApiFailure(
            ResponseCode.defaultResponse, ResponseMessage.defaultResponse);

      default:
        return ApiFailure(
            ResponseCode.defaultResponse, ResponseMessage.defaultResponse);
    }
  }
}

class ResponseCode {
  static const int success = 200;
  static const int created = 201;
  static const int babRequest = 400;
  static const int forBiden = 403;
  static const int unauthorised = 401;
  static const int notFound = 404;
  static const int internalSeverError = 500;
  static const int parcelExist = 4001;

// local status code
  static const int defaultResponse = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int recieveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  static const String success = "Succès";
  static const String noContent = "Succès Sans Contenu";
  static const String babRequest =
      "Mauvaise Requête, Veuillez Réessayer Plus Tard";
  static const String forBiden =
      "Requête Interdite, Veuillez Réessayer Plus Tard";
  static const String unauthorised =
      "Utilisateur Non Autorisé, Veuillez Réessayer Plus Tard";
  static const String notFound =
      "URL Introuvable, Veuillez Réessayer Plus Tard";
  static const String internalSeverError =
      "Oups, Une Erreur S'est Produite, Veuillez Réessayer";

// local status code
  static const String defaultResponse =
      "Oups, Une Erreur S'est Produite, Veuillez Réessayer";
  static const String connectTimeout = "Réseau Instable";
  static const String cancel = "Requête Annulée, Veuillez Réessayer Plus Tard";
  static const String recieveTimeout =
      "Délai D'attente Dépassé, Veuillez Réessayer Plus Tard";
  static const String sendTimeout =
      "Délai D'envoi Dépassé, Veuillez Réessayer Plus Tard";
  static const String cacheError =
      "Erreur De Cache, Veuillez Réessayer Plus Tard";
  static const String noInternetConnection =
      "Veuillez Vérifier Votre Connexion";
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

class ApiFailure {
  int code;
  String message;

  ApiFailure(this.code, this.message);
}
