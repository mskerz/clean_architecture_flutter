import 'package:clean_architecture_flutter/core/networks/network_options.dart';

abstract class NetworkService {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters, NetworkOptions? options});
  Future<dynamic> post(String url, {dynamic data, Map<String, dynamic>? queryParameters, NetworkOptions? options});
  Future<dynamic> put(String url, {dynamic data, Map<String, dynamic>? queryParameters, NetworkOptions? options});
  Future<dynamic> delete(String url, {Map<String, dynamic>? queryParameters, NetworkOptions? options});

  
}
