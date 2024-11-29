// auth_state.dart
class AuthState {
  final bool isLoggedIn;
  final bool isLoading;
  final String errorMessage;

  AuthState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.errorMessage = '',
  });

  // Copy constructor to create a new state based on the previous one
  AuthState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
