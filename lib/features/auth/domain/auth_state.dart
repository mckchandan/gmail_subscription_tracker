import 'package:flutter/foundation.dart';

@immutable
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? userEmail;
  final String? userName;
  final String? userPhotoUrl;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.userEmail,
    this.userName,
    this.userPhotoUrl,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    String? userEmail,
    String? userName,
    String? userPhotoUrl,
    String? error,
  }) => AuthState(
    isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    isLoading: isLoading ?? this.isLoading,
    userEmail: userEmail ?? this.userEmail,
    userName: userName ?? this.userName,
    userPhotoUrl: userPhotoUrl ?? this.userPhotoUrl,
    error: error,
  );
}
