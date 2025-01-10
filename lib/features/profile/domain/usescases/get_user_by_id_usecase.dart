import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/usecase.dart';
import '../../../auth/data/models/user_model.dart';
import '../repositories/account_repository.dart';

class GetUserByIdUsecase implements UseCase<UserModel, int> {
  final AccountRepository accountRepository;

  GetUserByIdUsecase({required this.accountRepository});

  @override
  Future<Either<Failure, UserModel>> call(int params) async {
    return accountRepository.getUserById(params);
  }
}
