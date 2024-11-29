
import 'package:clean_architecture_flutter/shared/data/models/authUserModel.dart';

abstract class AuthDataSource {
  Future<void> login(String username,String password);
  Future<User> verify();
}
