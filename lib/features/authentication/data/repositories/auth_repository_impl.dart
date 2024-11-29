

import 'package:clean_architecture_flutter/features/authentication/data/datasources/auth_data_source.dart';
import 'package:clean_architecture_flutter/features/authentication/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_flutter/shared/data/models/authUserModel.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<void> login(String username, String password)async {
      await authDataSource.login(username, password);
  }

  @override
  Future<User> verify() {
    // TODO: implement verify
    throw UnimplementedError();
  }

}