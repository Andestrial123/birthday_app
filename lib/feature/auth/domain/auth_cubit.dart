import 'package:birthday_app/feature/auth/domain/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

const adminPhoneNumber = "+380967912182";

enum UserRole { admin, user }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(AuthService authService)
      : _authService = authService,
        super(AuthInitial());

  final AuthService _authService;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      await _authService.verifyPhoneNumber(phoneNumber);
      emit(AuthOTPSend());
    } catch (e) {
      print('[AuthCubit][sendOtp] $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthentication() async {
    final user = _authService.currentUser;
    if (user != null) {
      emit(AuthUserAuthenticated(
        user.phoneNumber! == adminPhoneNumber ? UserRole.admin : UserRole.user,
      ));
    }
  }

  Future<void> signOut() async {
    _authService.signOut();
    emit(AuthInitial());
  }

  Future<void> authenticate(String otp) async {
    emit(AuthLoading());
    try {
      final User? result = await _authService.signInWithPhoneNumber(otp);
      if (result != null) {
        emit(AuthUserAuthenticated(result.phoneNumber == adminPhoneNumber
            ? UserRole.admin
            : UserRole.user));
      }
    } catch (e) {
      print('[AuthCubit][sendOtp] $e');
      emit(AuthError(e.toString()));
    }
  }
}
