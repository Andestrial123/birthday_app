import 'package:admin/admin.dart';
import 'package:birthday_app/feature/auth/presentation/widgets/login_form.dart';
import 'package:birthday_app/feature/auth/presentation/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/user.dart';

import '../../../di.dart';
import '../domain/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authCubit = getIt.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return switch (state) {
              AuthInitial() => LoginFormWidget(
                  onSend: (phoneNumber) {
                    _authCubit.verifyPhoneNumber(phoneNumber);
                  },
                ),
              AuthOTPSend() => OTPWidget(
                  onSend: (otp) async {
                    await _authCubit.authenticate(otp);
                  },
                  onBack: () {
                    _authCubit.emit(AuthInitial());
                  },
                ),
              AuthUserAuthenticated(role: var userRole) =>
                userRole == UserRole.admin
                    ? const AdminMainPage()
                    : const UserMainPage(),
              AuthError(error: var error) => Center(
                  child: Text(error),
                ),
              AuthLoading() => const Center(
                  child: CircularProgressIndicator(),
                )
            };
          },
        ),
      ),
    );
  }
}
