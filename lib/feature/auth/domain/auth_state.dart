part of 'auth_cubit.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthOTPSend extends AuthState {}

class AuthUserAuthenticated extends AuthState {
  final UserRole role;

  AuthUserAuthenticated(this.role);
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

class AuthLoading extends AuthState {}
