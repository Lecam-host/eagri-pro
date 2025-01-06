import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/utils/usecase.dart';
import '../../data/models/payload/forgot_password_payload.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUsecase implements UseCase<bool, ForgotPasswordPayload> {
  final AuthRepository authRepository;

  ForgotPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(ForgotPasswordPayload params) async {
    return authRepository.forgotPassword(params);
  }
}
