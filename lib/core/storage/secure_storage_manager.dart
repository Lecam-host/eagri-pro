import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

typedef FromJsonFunction<T> = T Function(Map<String, dynamic>);
typedef ToJsonFunction<T> = Map<String, dynamic> Function(T);

typedef FromJsonFunctionList<T> = List<T> Function(List<dynamic>);
typedef ToJsonFunctionList<T> = List<Map<String, dynamic>> Function(List<T>);

class SecureStorageManagerSimple<T> {
  SecureStorageManagerSimple(
    this._key,
    this._secureStorage,
  );
  final FlutterSecureStorage _secureStorage;
  final String _key;

  static AndroidOptions get _getAndroidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> saveData(T data) async {
    final value = data.toString();
    await _secureStorage.write(
      key: _key,
      value: value,
      aOptions: _getAndroidOptions,
    );
  }

  Future<T?> loadData() async {
    final value = await _secureStorage.read(
      key: _key,
      aOptions: _getAndroidOptions,
    );
    return value != null ? value as T : null;
  }

  Future<void> deleteData() async {
    await _secureStorage.delete(
      key: _key,
      aOptions: _getAndroidOptions,
    );
  }
}

class SecureStorageData<T> {
  SecureStorageData(
    this._key,
    this._secureStorage, {
    required this.fromJson,
    required this.toJson,
  });
  final String _key;
  final FromJsonFunction<T> fromJson;
  final ToJsonFunction<T> toJson;

  final FlutterSecureStorage _secureStorage;

  static AndroidOptions get _getAndroidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> saveData(T data) async {
    try {
      final encodedData = jsonEncode(toJson(data));
      await _secureStorage.write(
        key: _key,
        value: encodedData,
        aOptions: _getAndroidOptions,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<T?> loadData() async {
    try {
      final storedData = await _secureStorage.read(
        key: _key,
        aOptions: _getAndroidOptions,
      );
      if (storedData != null && storedData.isNotEmpty) {
        final decodedData = jsonDecode(storedData) as Map<String, dynamic>;
        return fromJson(decodedData);
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }


  Future<void> clearData() async {
    try {
      await _secureStorage.delete(
        key: _key,
        aOptions: _getAndroidOptions,
      );
    } catch (e) {
      rethrow;
    }
  }
}

class SecureStorageManager<T> {
  SecureStorageManager(
    this._key,
    this.store, {
    required this.fromJson,
    required this.toJson,
  });
  final String _key;

  final FlutterSecureStorage store;
  final FromJsonFunctionList<T> fromJson;
  final ToJsonFunctionList<T> toJson;

  static AndroidOptions get _getAndroidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future<void> saveData(List<T> data) async {
    try {
      final encodedData = jsonEncode(toJson(data));
      await store.write(
        key: _key,
        value: encodedData,
        aOptions: _getAndroidOptions,
      );
    } catch (e) {
      // Handle the exception as needed
      // print('Error saving data: $e');
    }
  }

  Future<List<T>> loadData() async {
    final jsonData = await store.read(
      key: _key,
      aOptions: _getAndroidOptions,
    );

    if (jsonData != null && jsonData.isNotEmpty) {
      final decodedData = json.decode(jsonData) as List;
      return fromJson(decodedData);
    } else {
      return <T>[];
    }
  }

  Future<void> clear() async {
    await store.delete(key: _key, aOptions: _getAndroidOptions);
  }
}
