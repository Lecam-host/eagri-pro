import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eagri_pro/features/auth/data/models/user_model.dart';
import 'package:eagri_pro/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/http/network_info.dart';
import '../../../auth/data/models/payload/update_profil_payload.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasoucres/account_local_data_source.dart';
import '../datasoucres/account_remote_datasource.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;
  AccountLocalDataSource store;
  AccountRepositoryImpl(
      {required this.remoteDataSource,
      required this.networkInfo,
      required this.store});
  @override
  Future<Either<Failure, UserEntity>> getAccount() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAccount();
        inspect(response);
        await store.saveData(response);
        return Right(response);
      } on DioException catch (e) {
        inspect(e);
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      try {
        final localAccount = await store.loadData();
        return Right(localAccount!);
      } on CacheException catch (e) {
        return Left(CacheFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity>> get currentUser async {
    if (await networkInfo.isConnected) {
      try {
        final response = await store.loadData();
        if (response != null) {
          return Right(response);
        }
        return const Left(ServerFailure(errorMessage: "Aucune donnée"));
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      try {
        final localAccount = await store.loadData();
        return Right(localAccount!);
      } on CacheException catch (e) {
        return Left(CacheFailure(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> updateAccount(
      UpdateProfilPayload account) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateAccount(account);
        // await store.saveData(response);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserById(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getUserById(id);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure(errorMessage: e.toString()));
      }
    } else {
      return const Left(ServerFailure(errorMessage: 'No internet connection'));
    }
  }
}
