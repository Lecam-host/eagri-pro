import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/storage/secure_storage_manager.dart';
import '../../../../core/storage/storage_constant.dart';
import '../models/auth_model.dart';


abstract class AuthLocalDataSource {
  Future<AuthModel?> loadData();
  Future<void> saveData(AuthModel value);
  Future<void> deleteData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> deleteData() {
    final local = SecureStorageData<AuthModel>(
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: AuthModel.fromJson,
      toJson: (data) => data.toJson(),
    );
    return local.clearData();
  }

  @override
  Future<AuthModel?> loadData() async {
     final local = SecureStorageData<AuthModel>(
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: AuthModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      return (await local.loadData())!;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveData(AuthModel value) async {
    final local = SecureStorageData<AuthModel>(
      StorageConstant.AUTH_CACHED,
      sharedPreferences,
      fromJson: AuthModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      await local.saveData(value);
    } catch (e) {
      throw CacheException();
    }
  }
}
