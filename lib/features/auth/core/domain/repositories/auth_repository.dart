import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../data/models/payload/forgot_password_payload.dart';
import '../../data/models/payload/reset_password_payload.dart';
import '../entities/auth_entity.dart';
import '../usecases/login_usecase.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(LoginParams params);
  Future<Either<Failure, AuthEntity>> checkAuthentification();
  Future<Either<Failure, AuthEntity>> get getAuthInfo;
  Future<Either<Failure, bool>>  logout({required String token, required String userName});
  Future<Either<Failure, bool>> deleteFirebaseToken({required String token, required String userName});
  Future<Either<Failure, bool>> forgotPassword(ForgotPasswordPayload payload);
  Future<Either<Failure, bool>> resetPassword(ResetPasswordPayload payload);
  Future<Either<Failure, bool>> registrationToken(
      {required String token, required String userName});
}
