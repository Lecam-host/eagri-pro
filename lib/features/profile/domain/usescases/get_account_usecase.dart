import 'package:dartz/dartz.dart';
import 'package:eagri_pro/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../repositories/account_repository.dart';

class GetAccountUsecase implements UseCase<UserEntity, NoParams> {
  final AccountRepository accountRepository;

  GetAccountUsecase({required this.accountRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return accountRepository.getAccount();
  }
}
