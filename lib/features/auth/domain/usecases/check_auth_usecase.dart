import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';
class CheckAuthUsecase implements UseCase<AuthEntity, NoParams> {
  final AuthRepository authRepository;

  CheckAuthUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(NoParams params) async {
    return authRepository.checkAuthentification();
  }
}