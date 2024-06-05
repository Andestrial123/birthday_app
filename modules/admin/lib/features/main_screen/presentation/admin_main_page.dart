library admin;

import 'package:admin/constans/const.dart';
import 'package:admin/features/link_screen/presentation/link_screen_layout.dart';
import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:admin/features/map_point_screen/presentation/map_point_screen_layout.dart';
import 'package:admin/features/quiz_screen/presentation/quiz_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../data/db.dart';

class AdminMainPage extends StatelessWidget {
  final Function() onLogout;

  AdminMainPage({super.key, required this.onLogout});

  final _mainCubit = MainCubit(userDb, answersDb);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => _mainCubit,
      child: BlocListener<MainCubit, MainState>(
        listener: (context, state) {
          if (state is MainReceiveAnswer) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.answers.title ?? "")));
          }
        },
        child: Column(
          children: [
            const Text("Hello i'm Admin"),
            const Spacer(),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                      value: _mainCubit,
                                      child: const QuizScreenLayout(
                                        titleAppBar: 'Quiz Screen',
                                      ),
                                    )));
                      },
                      child: const Text('Add quiz')),
                  sbH24,
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                    value: _mainCubit,
                                    child: const MapPointScreenLayout())));
                      },
                      child: const Text('Add map point')),
                  sbH24,
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                    value: _mainCubit,
                                    child: const LinkScreenLayout())));
                      },
                      child: const Text('Add link with comment')),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(onPressed: onLogout, child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
