import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
    return authRepository.login(params);
  }
}

class LoginParams {
  final String username;
  final String password;
  LoginParams({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
