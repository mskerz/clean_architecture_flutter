import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters, Options? options});
  Future<dynamic> post(String url, {dynamic data, Map<String, dynamic>? queryParameters, Options? options});
  Future<dynamic> put(String url, {dynamic data, Map<String, dynamic>? queryParameters, Options? options});
  Future<dynamic> delete(String url, {Map<String, dynamic>? queryParameters, Options? options});
}
