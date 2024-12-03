// core/network/dio_network_service.dart
import 'package:clean_architecture_flutter/core/interceptors/network_interceptor.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';
import 'package:dio/dio.dart';
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';

class DioNetworkService implements NetworkService {
  final Dio _dio;
  final StorageService storageService;

  DioNetworkService({required Dio dio, required this.storageService}) 
      : _dio = dio {
    // ตั้งค่าพื้นฐานสำหรับ Dio
    _dio.options.baseUrl = 'https://dummyjson.com';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    // เพิ่ม NetworkInterceptor
    _dio.interceptors.add(NetworkInterceptor(storageService: storageService));
  }

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<dynamic> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<dynamic> put(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw _handleError(error);
    }
  }

  @override
  Future<dynamic> delete(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.delete(url, queryParameters: queryParameters);
      return response.data;
    } catch (error) {
      throw _handleError(error);
    }
  }

  Exception _handleError(Object error) {
    if (error is DioException) {
      return Exception('Network Error: ${error.response?.statusCode} - ${error.message}');
    } else {
      return Exception('Unexpected Error: $error');
    }
  }
}
