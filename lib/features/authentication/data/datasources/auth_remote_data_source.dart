// features/posts/data/datasources/posts_remote_data_source.dart
import 'package:clean_architecture_flutter/features/authentication/data/datasources/auth_data_source.dart';
import 'package:clean_architecture_flutter/shared/data/local/storage_service.dart';
import 'package:clean_architecture_flutter/shared/data/models/user.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';

class AuthRemoteDataSource extends AuthDataSource {
  final NetworkService networkService;
  final StorageService storageService;
  // Constructor with NetworkService injected
  AuthRemoteDataSource(this.networkService, this.storageService);

  @override
  Future<void> login(String username, String password) async {
    try {
      // Prepare the body for the login request
      dynamic body = {
        "username": username,
        "password": password,
      };

      // Make POST request to the login API
      final response = await networkService.post('/auth/login', data: body);

      // Check if response is successful
      if (response != null) {
        // Ensure the response contains the accessToken and refreshToken
        if (response['accessToken'] != null &&
            response['refreshToken'] != null) {
          // Save the access and refresh tokens in SharedPreferences
          // print('accessToken: ${response['accessToken']}');
          await storageService.set('accessToken', response['accessToken']);
          var accessToken = await storageService.get('accessToken');
          print('accessToken ${accessToken.runtimeType} in Secure Storage = $accessToken');
          await storageService.set('refreshToken', response['refreshToken']);
          // Optionally, return success message or user details
          // ignore: avoid_print
          print('Login successful and tokens saved');
        } else {
          throw Exception('Failed to login: Missing tokens in response');
        }
      }

      // Handle any other errors (e.g., network issues)
      else {
        throw Exception(
            'Failed to login: Invalid credentials or network error');
      }
    } catch (e) {
      // Catch and throw descriptive error messages
       if (e.toString().contains('400')) {
        throw Exception('Invalid username or password. Please try again.');
      } else {
        throw Exception('Login failed: $e');
      }
    }
  }

  @override
  Future<User> verify() async {
    // throw UnimplementedError();
    try {
      // Retrieve accessToken from SharedPreferences using StorageService
      final accessToken = await storageService.get('accessToken');

      if (accessToken == null) {
        throw Exception('No access token found');
      }

      // Use the access token to verify the user via the API
      final response = await networkService.get('/auth/me',      );
      // print(response);
  
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to verify $e');
    }
  }

  @override
  Future<void> refreshToken() {
     throw UnimplementedError();
  }

  @override
Future<void> logout() async {
  try {
    final isAccessTokenRemoved = await storageService.remove("accessToken");
    final isRefreshTokenRemoved = await storageService.remove("refreshToken");

    if (isAccessTokenRemoved && isRefreshTokenRemoved) {
      print("logged out completed!  ");
      await storageService.set('isLogin', 'false'); // Update login status to false
    } else {
      throw Exception('Failed to remove tokens');
    }
  } catch (e) {
    throw Exception('Failed to logout: $e');
  }
}

}
