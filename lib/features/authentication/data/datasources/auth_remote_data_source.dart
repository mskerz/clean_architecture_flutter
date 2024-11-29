// features/posts/data/datasources/posts_remote_data_source.dart
import 'package:clean_architecture_flutter/features/authentication/data/datasources/auth_data_source.dart';
import 'package:clean_architecture_flutter/shared/data/models/authUserModel.dart';
import 'package:clean_architecture_flutter/shared/data/remote/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource  extends AuthDataSource {
  final NetworkService networkService;

  // Constructor with NetworkService injected
  AuthRemoteDataSource(this.networkService);

 

  @override
  Future<void> login(String username, String password) async {
    try {
      // Prepare the body for the login request
      dynamic body = {
        "username": username,
        "password": password,
      };

      // Make POST request to the login API
      final response = await networkService.post('/user/login',data: body);

      // Check if response is successful
      if (response != null && response.statusCode == 200) {
        // Ensure the response contains the accessToken and refreshToken
        if (response['accessToken'] != null && response['refreshToken'] != null) {
          // Save the access and refresh tokens in SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          print('accessToken: ${response['accessToken']}');
          await prefs.setString('accessToken', response['accessToken']);
          await prefs.setString('refreshToken', response['refreshToken']);
          await prefs.setBool('isLogin', true); // Mark as logged in

          // Optionally, return success message or user details
          // ignore: avoid_print
          print('Login successful and tokens saved');
        } else {
          throw Exception('Failed to login: Missing tokens in response');
        }
      } 
      // Handle invalid credentials (statusCode 400)
      else if (response.statusCode == 400) {
        throw Exception('Invalid credentials. Please try again.');
      } 
      // Handle any other errors (e.g., network issues)
      else {
        throw Exception('Failed to login: Invalid credentials or network error');
      }
    } catch (e) {
      // Catch and throw descriptive error messages
      throw Exception('Login failed: $e');
    }
  }

  
  @override
  Future<User> verify()  async{
    // TODO: implement verify
    throw UnimplementedError();
  }

  
}
