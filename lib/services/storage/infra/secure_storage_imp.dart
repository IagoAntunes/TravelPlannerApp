import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/secure_storage.dart';

class SecureStorage implements ISecureStorage {
  late FlutterSecureStorage secureStorage;
  SecureStorage() {
    secureStorage = const FlutterSecureStorage();
  }

  @override
  Future<String?> readData({required String key}) async =>
      await secureStorage.read(key: key);

  @override
  Future<void> writeData({required String key, required dynamic value}) async =>
      await secureStorage.write(key: key, value: value);

  @override
  Future<void> deleteData({required String key}) async =>
      await secureStorage.delete(key: key);

  @override
  Future<void> deleteAllStorageData() async => await secureStorage.deleteAll();

  @visibleForTesting
  SecureStorage.test({required this.secureStorage});
}
