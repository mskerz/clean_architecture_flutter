// auth_state.dart
import 'package:clean_architecture_flutter/shared/data/models/user.dart';

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String errorMessage;
  final User? user; // เก็บข้อมูลผู้ใช้

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.errorMessage = '',
    this.user,
  });

  // Copy constructor to create a new state based on the previous one
  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? errorMessage,
    User? user,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
