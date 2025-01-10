import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/data/models/payload/update_profil_payload.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/entities/account_entity.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class AccountRepository {
  Future<Either<Failure, UserEntity>> getAccount();
  Future<Either<Failure, AccountEntity>> updateAccount(UpdateProfilPayload account);
  Future<Either<Failure, UserEntity>> get currentUser;
  Future<Either<Failure, UserModel>> getUserById(int id);
}
