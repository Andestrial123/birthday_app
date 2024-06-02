library admin;

import 'package:admin/constans/const.dart';
import 'package:admin/features/link_screen/presentation/link_screen_layout.dart';
import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:admin/features/map_point_screen/presentation/map_point_screen_layout.dart';
import 'package:admin/features/quiz_screen/presentation/quiz_screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';

import '../data/db.dart';

class AdminMainPage extends StatelessWidget {
  final Function() onLogout;

  const AdminMainPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                            builder: (context) => BlocProvider(
                                  lazy: false,
                                  create: (_) => MainCubit(db),
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
                            builder: (context) => BlocProvider(
                                lazy: false,
                                create: (_) => MainCubit(db),
                                child: const MapPointScreenLayout())));
                  },
                  child: const Text('Add map point')),
              sbH24,
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                lazy: false,
                                create: (_) => MainCubit(db),
                                child: const LinkScreenLayout())));
                  },
                  child: const Text('Add link with comment')),
            ],
          ),
        ),
        const Spacer(),
        ElevatedButton(onPressed: onLogout, child: const Text("Logout")),
        ElevatedButton(
            onPressed: () {
              db.set(BaseModel<Map<String, dynamic>>(
                      challengeType: ChallengeType.quiz,
                      data:
                          QuizModel(question: "Your gay ?", answers: <Answers>[
                        Answers(title: "No", isCorrect: false),
                        Answers(title: "Yes", isCorrect: true),
                        Answers(title: "Fuck Off", isCorrect: false),
                      ]).toJson())
                  .toJson());
            },
            child: const Text("Send event"))
      ],
    );
  }
}
