import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/storage/secure_storage_manager.dart';
import '../../../../core/storage/storage_constant.dart';
import '../../../auth/data/models/account_model.dart';
import '../../../auth/data/models/user_model.dart';

abstract class AccountLocalDataSource {
  Future<UserModel?> loadData();
  Future<void> saveData(UserModel value);
  Future<void> deleteData();
}

class AccountLocalDataSourceImpl implements AccountLocalDataSource {
  final FlutterSecureStorage sharedPreferences;

  AccountLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> deleteData() {
    throw UnimplementedError();
  }

  @override
  Future<UserModel?> loadData() async {
    final local = SecureStorageData<UserModel>(
      StorageConstant.ACCOUNT_CACHED,
      sharedPreferences,
      fromJson: UserModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      return (await local.loadData())!;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveData(UserModel value) async {
    final local = SecureStorageData<UserModel>(
      StorageConstant.ACCOUNT_CACHED,
      sharedPreferences,
      fromJson: UserModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      await local.saveData(value);
    } catch (e) {
      throw CacheException();
    }
  }
}
