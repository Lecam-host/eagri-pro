import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/http/network_info.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/auth_model.dart';
import '../models/payload/forgot_password_payload.dart';
import '../models/payload/reset_password_payload.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource store;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.store});
  @override
  Future<Either<Failure, AuthModel>> login(LoginParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(params);
        inspect(response);
        await store.saveData(response);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, AuthModel>> checkAuthentification() async {
    try {
      final response = await store.loadData();
      log(response.toString(), level: 1, name: "AuthRepositoryImpl");
      if (response != null) {
        bool isTokenExpired = JwtDecoder.isExpired(response.accessToken!);
        if (isTokenExpired) {
          return const Left(ServerFailure(errorMessage: 'Token expired'));
        }
        return Right(response);
      }
      return const Left(ServerFailure(errorMessage: 'No token found'));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(
      ForgotPasswordPayload payload) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.forgotPassword(payload);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordPayload payload) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.resetPassword(payload);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> get getAuthInfo async {
    try {
      final response = await store.loadData();
      log(response.toString(), level: 1, name: "AuthRepositoryImpl");
      if (response != null) {
        bool isTokenExpired = JwtDecoder.isExpired(response.accessToken!);
        if (isTokenExpired) {
          return const Left(ServerFailure(errorMessage: 'Token expired'));
        }
        return Right(response);
      }
      return const Left(ServerFailure(errorMessage: 'No token found'));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> registrationToken(
      {required String token, required String userName}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.registrationToken(
            token: token, userName: userName);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  // TODO: implement logout
  Future<Either<Failure, bool>> logout({required String token, required String userName}) async {
    try {
       remoteDataSource.deleteFirebaseToken(token: token, userName: userName);
      await store.deleteData();
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
    return const Right(true);
  }
  
  @override
  Future<Either<Failure, bool>> deleteFirebaseToken({required String token, required String userName}) async{
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.deleteFirebaseToken(token: token, userName: userName);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
