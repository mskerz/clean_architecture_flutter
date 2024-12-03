
import 'package:clean_architecture_flutter/shared/data/models/user.dart';

abstract class AuthRepository {
  Future<void> login(String username, String password);
  Future<User> verify();
  Future<void> refreshToken() ;
  Future<void> logout();
}
