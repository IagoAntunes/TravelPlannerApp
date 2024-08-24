abstract class ISecureStorage {
  Future<String?> readData({required String key});

  Future<void> writeData({required String key, required dynamic value});

  Future<void> deleteData({required String key});

  Future<void> deleteAllStorageData();
}
