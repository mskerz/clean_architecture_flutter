// auth_state_notifier.dart
import 'package:clean_architecture_flutter/features/authentication/domain/providers/auth_provider.dart';
import 'package:clean_architecture_flutter/features/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthStateNotifier(this.authRepository) : super(AuthState());

  // Login method that updates the state based on login success or failure
  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true); // Set loading state to true

    try {
      // Call the login function from the repository
      await authRepository.login(username, password);
      state = state.copyWith(isLoggedIn: true, isLoading: false); // Set logged in state
      await verify();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString()); // Update error message
    }
  }


  Future<void> verify() async {
    try {
      final user = await authRepository.verify(); // ดึงข้อมูลผู้ใช้
      state = state.copyWith(user: user);  // อัพเดตสถานะผู้ใช้
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
  // You can add more actions (like logout) here if needed

  Future<void> logout() async {
    state = state.copyWith(isLoading: true); // Set loading state to true

    try {
      await authRepository.logout(); // Call the logout function from the repository
      state = state.copyWith(isLoggedIn: false, isLoading: false,user: null); // Set logged out state
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString()); // Update error message
    }
  }
}




// Provide the AuthStateNotifier instance
final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthStateNotifier(authRepository);
  },
);