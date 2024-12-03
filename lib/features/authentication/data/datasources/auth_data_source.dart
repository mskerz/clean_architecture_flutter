
import 'package:clean_architecture_flutter/shared/data/models/user.dart';

abstract class AuthDataSource {
  Future<void> login(String username,String password);
  Future<User> verify();
  Future<void> refreshToken(); // เพิ่มเมธอดนี้
  Future<void> logout();

}
