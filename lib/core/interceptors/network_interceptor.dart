
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor  extends Interceptor{
   final StorageService storageService;
   NetworkInterceptor({required this.storageService});

 @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final accessToken = await storageService.get('accessToken');
      
      if (accessToken != null) {
        // ignore: avoid_print
        print("---use Interceptor in Request -------");
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      super.onRequest(options, handler);
    } catch (e) {
      super.onRequest(options, handler);
    }
  }
}