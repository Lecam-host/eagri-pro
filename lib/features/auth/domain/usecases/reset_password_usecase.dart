import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/auth_repository.dart';
import '../../data/models/payload/reset_password_payload.dart';

class ResetPasswordUsecase implements UseCase<bool, ResetPasswordPayload> {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(ResetPasswordPayload params) async {
    return authRepository.resetPassword(params);
  }
}