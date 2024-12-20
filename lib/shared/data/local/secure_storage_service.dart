import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';

class SecureStorageService implements StorageService {
  FlutterSecureStorage?_secureStorage;
  final Completer<FlutterSecureStorage> initCompleter = Completer<FlutterSecureStorage>();

  @override

  void init() {
    // FlutterSecureStorage ไม่มีการ initialize แบบ asynchronous
    _secureStorage = FlutterSecureStorage();
    initCompleter.complete(_secureStorage);
  }

  @override
  bool get hasInitialized => initCompleter.isCompleted;

  @override
  Future<Object?> get(String key) async {
    // รอให้ secure storage พร้อม
    await initCompleter.future;
    return await _secureStorage!.read(key: key);
  }

  @override
  Future<void> clear() async {
    await initCompleter.future;
    await _secureStorage!.deleteAll();
  }

  @override
  Future<bool> has(String key) async {
    await initCompleter.future;
    String? value = await _secureStorage?.read(key: key);
    return value != null;
  }

  @override
  Future<void> remove(String key) async {
    await initCompleter.future;
    await _secureStorage?.delete(key: key);
  }

  @override
  Future<void> set(String key, data) async {
    await initCompleter.future;
    await _secureStorage!.write(key: key, value: data.toString());
  }
}
