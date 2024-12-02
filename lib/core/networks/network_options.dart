// core/network/network_options.dart

import 'package:dio/dio.dart';

class NetworkOptions {
  final Map<String, dynamic>? headers;

  NetworkOptions({this.headers});

  // แปลงเป็น Dio's Options

  Options setOptions() {
    return Options(
      headers: headers,
    );
  }
}
