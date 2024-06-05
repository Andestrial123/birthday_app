import 'package:admin/admin.dart';
import 'package:birthday_app/feature/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/user.dart';

import '../../../di.dart';
import '../../auth/domain/auth_cubit.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: switch (state) {
            AuthUserAuthenticated(role: var userRole) =>
              userRole == UserRole.user
                  ? const UserMainPage()
                  : AdminMainPage(
                      onLogout: () {
                        getIt.get<AuthCubit>().signOut();
                      },
                    ),
            _ => const LoginScreen(),
          },
        ));
      },
    );
  }
}
