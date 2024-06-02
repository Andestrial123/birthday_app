import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/features/main/domain/main_cubit.dart';
import 'package:user/features/main/presentation/widgets/quiz_widget.dart';

import '../data/db/db.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) => MainCubit(db),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (BuildContext context, state) {
            return switch (state) {
              MainInitial() => const Text("Alloha ))"),
              MainQuizState(data: var data) => QuizWidget(
                  data: data,
                  onSubmit: () {},
                )
            };
          },
        ));
  }
}
