import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState());

  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _repository.trySilentSignIn();
      if (user != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userEmail: user.email,
          userName: user.displayName,
          userPhotoUrl: user.photoUrl,
        );
      } else {
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signIn() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.signIn();
      if (user != null) {
        state = state.copyWith(
          isAuthenticated: true,
          isLoading: false,
          userEmail: user.email,
          userName: user.displayName,
          userPhotoUrl: user.photoUrl,
        );
      } else {
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(
        isAuthenticated: false,
        isLoading: false,
        error: 'Sign in failed: ${e.toString()}',
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Sign out failed: ${e.toString()}',
      );
    }
  }
}
