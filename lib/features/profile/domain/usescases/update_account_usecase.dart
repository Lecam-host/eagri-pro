import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/usecase.dart';
import '../../../auth/data/models/payload/update_profil_payload.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../repositories/account_repository.dart';

class UpdateAccountUsecase implements UseCase<AccountEntity, UpdateProfilPayload> {
  final AccountRepository accountRepository;

  UpdateAccountUsecase({required this.accountRepository});

  @override
  Future<Either<Failure, AccountEntity>> call(UpdateProfilPayload params) async {
    return accountRepository.updateAccount(params);
  }
}
