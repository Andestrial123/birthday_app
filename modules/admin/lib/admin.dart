library admin;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';
export "features/main_screen/presentation/main_screen_layout.dart";
import 'package:flutter/cupertino.dart';

/// A Calculator.
class AdminMainPage extends StatelessWidget {
  final Function() onLogout;

  AdminMainPage({super.key, required this.onLogout});

  final db = FirebaseDatabase.instance.ref("events");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Hello i'm Admin"),
        const Spacer(),
        ElevatedButton(onPressed: onLogout, child: const Text("Logout")),
        ElevatedButton(
            onPressed: () {
              db.set(BaseModel<Map<String ,dynamic>>(
                  challengeType: ChallengeType.quiz,
                  data: QuizModel(question: "Your gay ?", answers: <Answers>[
                    Answers(title: "No", isCorrect: false),
                    Answers(title: "Yes", isCorrect: true),
                    Answers(title: "Fuck Off", isCorrect: false),
                  ]).toJson()).toJson());
            },
            child: const Text("Send event"))
      ],
    );
  }
}
