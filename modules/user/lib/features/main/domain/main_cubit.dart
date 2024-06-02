import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/link_model/link_model.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';
import 'package:user/features/main/data/constats/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(DatabaseReference db)
      : _db = db,
        super(MainInitial()) {
    _db.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final mapEvent = event.snapshot.value as Map;
        switch (mapEvent['challengeType']) {
          case "ChallengeType.quiz":
            emit(MainQuizState(QuizModel.fromJson(mapEvent['data'])));
            break;
          case "ChallengeType.funnyLink":
            emit(MainLinkState(LinkModel.fromJson(mapEvent['data'])));
        }
      }
    });
  }

  final DatabaseReference _db;

  Future<void> submitQuizAnswer(bool isCorrect) async {
    _db.remove();
    if (isCorrect) {
      emit(MainCorrectState());
      await Future.delayed(const Duration(seconds: 3));
      emit(MainInitial());
    } else {
      final random = Random();
      emit(MainIncorrectState(badList[random.nextInt(badList.length)]));
    }
  }

  Future<void> resetState() async {
    _db.remove();
    emit(MainInitial());
  }
}
