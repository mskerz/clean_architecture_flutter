/// Storage service interface
abstract class StorageService {
  void init();

  bool get hasInitialized;

  Future<dynamic> remove(String key);

  Future<Object?> get(String key);

Future<dynamic> set(String key, dynamic data);

  Future<void> clear();

  Future<bool> has(String key);
}