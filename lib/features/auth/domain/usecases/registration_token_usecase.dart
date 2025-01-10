import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/auth_repository.dart';

class RegistrationTokenParams {
  final String token;
  final String userName;
  RegistrationTokenParams({required this.token, required this.userName});
}

class RegistrationTokenUsecase implements UseCase<bool, RegistrationTokenParams> {
  final AuthRepository authRepository;

  RegistrationTokenUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(RegistrationTokenParams params) async {
    return authRepository.registrationToken(token: params.token, userName: params.userName);
  }
}