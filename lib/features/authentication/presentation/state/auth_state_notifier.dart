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
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString()); // Update error message
    }
  }

  // You can add more actions (like logout) here if needed
}



// Provide the AuthStateNotifier instance
final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthStateNotifier(authRepository);
  },
);