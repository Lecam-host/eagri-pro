import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/error/exception.dart';
import '../../../core/storage/secure_storage_manager.dart';
import '../../../core/storage/storage_constant.dart';
import '../../profile/model/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> loadData();
  Future<void> saveData(UserModel value);
  Future<void> deleteData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> deleteData() {
    final local = SecureStorageData<UserModel>(
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: UserModel.fromMap,
      toJson: (data) => data.toJson(),
    );
    return local.clearData();
  }

  @override
  Future<UserModel?> loadData() async {
    final local = SecureStorageData<UserModel>(
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: UserModel.fromMap,
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
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: UserModel.fromMap,
      toJson: (data) => data.toJson(),
    );

    try {
      await local.saveData(value);
    } catch (e) {
      throw CacheException();
    }
  }
}
