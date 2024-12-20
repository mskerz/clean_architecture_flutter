

import 'package:clean_architecture_flutter/shared/data/local/secure_storage_service.dart';
import 'package:clean_architecture_flutter/shared/data/local/share_prefs_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider((ref) {
  final SharedPrefsStorageService prefsService = SharedPrefsStorageService();
  prefsService.init();
  return prefsService;
});


final secureStorageServiceProvider = Provider((ref) {
    final SecureStorageService secureService = SecureStorageService();
    secureService.init();
    return secureService;
});