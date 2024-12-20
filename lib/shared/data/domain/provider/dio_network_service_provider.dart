// shared/data/domain/provider/dio_network_service_provider.dart
import 'package:clean_architecture_flutter/shared/data/domain/provider/storage_service_provider.dart';
import 'package:clean_architecture_flutter/shared/data/remote/dio_network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../remote/network_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(); // สร้าง instance ของ Dio ที่จะใช้
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageServiceProvider);
    // final storage = ref.watch(secureStorageServiceProvider);

  return DioNetworkService(dio: dio,storageService:storage ); // Inject Dio ลงใน DioNetworkService
});
 