import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/http/http_helper.dart';
import '../../domain/usecases/login_usecase.dart';
import '../models/auth_model.dart';
import '../models/payload/forgot_password_payload.dart';
import '../models/payload/reset_password_payload.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginParams params);
  Future<bool> forgotPassword(ForgotPasswordPayload payload);
  Future<bool> resetPassword(ResetPasswordPayload payload);
  Future<bool> deleteFirebaseToken(
      {required String token, required String userName});
  Future<bool> registrationToken(
      {required String token, required String userName});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpHelper httpHelper;
  AuthRemoteDataSourceImpl({required this.httpHelper});
  @override
  Future<AuthModel> login(LoginParams params) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msSecurity}/auth/authenticate',
          data: params.toJson());
      log(response.toString());
      if (response.statusCode == 200) {
        log(response.requestOptions.baseUrl);
        log(response.data.toString());
        return AuthModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      throw Exception(e.response!.data['statusMessage']);
    }
  }

  @override
  Future<bool> forgotPassword(ForgotPasswordPayload payload) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msSecurity}/auth/forgot-password?phone=225${payload.phone}');
      log(response.toString());
      if (response.statusCode == 200) {
        log(response.requestOptions.path);
        log(response.data.toString());
        return true;
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      log(e.requestOptions.path);
      throw Exception(e.response?.data['statusMessage']);
    }
  }

  @override
  Future<bool> resetPassword(ResetPasswordPayload payload) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msSecurity}/auth/reset-password',
          queryParameters: payload.toJson());
      log(response.toString());
      if (response.statusCode == 200) {
        log(response.requestOptions.baseUrl);
        log(response.data.toString());
        return true;
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> registrationToken(
      {required String token, required String userName}) async {
    try {
      final response = await httpHelper.post(
          '${ConstantUrl.msSecurity}/registration/create',
          data: {'registrationId': token, 'userName': userName});
      log(response.toString());
      if (response.statusCode == 200) {
        log(response.requestOptions.baseUrl);
        log(response.data.toString());
        return true;
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      log(e.requestOptions.baseUrl);
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> deleteFirebaseToken(
      {required String token, required String userName}) async {
    try {
      final response = await httpHelper.delete(
          '${ConstantUrl.msSecurity}/registration/delete',
          data: {'registrationId': token, 'userName': userName});
      log(response.toString());
      if (response.statusCode == 200) {
        log(response.requestOptions.baseUrl); 
        log(response.data.toString());
        return true;
      } else {
        throw Exception(response.data['statusMessage']);
      }
    } on DioException catch (e) {
      log(e.requestOptions.baseUrl);
      throw Exception(e.toString());
    }
  }
}
