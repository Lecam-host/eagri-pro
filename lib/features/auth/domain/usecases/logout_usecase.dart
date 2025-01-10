import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase implements UseCase<bool, LogoutParams> {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(LogoutParams params) async {
    return authRepository.logout(token: params.token, userName: params.userName);
  }
}

class LogoutParams {
  final String token;
  final String userName;
  LogoutParams({required this.token, required this.userName});

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userName': userName,
    };
  }
}