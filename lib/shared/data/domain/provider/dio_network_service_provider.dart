// shared/data/domain/provider/dio_network_service_provider.dart
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../remote/dio_network_service.dart';
import '../../remote/network_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(); // สร้าง instance ของ Dio ที่จะใช้
});

final networkServiceProvider = Provider<NetworkService>((ref) {
  final dio = ref.watch(dioProvider);
  return DioNetworkService(dio: dio); // Inject Dio ลงใน DioNetworkService
});
 